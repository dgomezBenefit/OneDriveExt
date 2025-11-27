table 50201 "OneDrive Recs"
{
    Caption = 'Documentos One Drive';
    DataClassification = CustomerContent;
    Permissions = tabledata "OneDrive Recs" = rimd;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
            Caption = 'ID';
            Editable = false;
        }
        field(2; "Table ID"; Integer)
        {
            Caption = 'Table ID';
            NotBlank = true;
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Table));
        }
        field(3; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(4; "Attached Date"; DateTime)
        {
            Caption = 'Attached Date';
        }
        field(5; "File Name"; Text[250])
        {
            Caption = 'Attachment';
            NotBlank = true;
        }
        field(6; "File Extension"; Text[250])
        {
            Caption = 'File Extension';
        }
        field(7; "Mime Type"; Text[100])
        {
            Caption = 'Mime Type';
        }
        field(8; "SharePoint File ID"; Text[100])
        {
            Caption = 'SharePoint File ID';
        }
        field(9; "Web Url"; Text[1024])
        {
            Caption = 'Web URL';
            ExtendedDatatype = URL;
        }
        field(10; "Attached By"; Guid)
        {
            Caption = 'Attached By';
            Editable = false;
            TableRelation = User."User Security ID" where("License Type" = const("Full User"));
        }
        field(11; Email; Code[50])
        {
            // CalcFormula = lookup(User."User Name" where("User Security ID" = field("Attached By"),
            //                                              "License Type" = const("Full User")));
            Caption = 'User';
            Editable = false;
            // FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; ID, "Table ID", "No.")
        {
            Clustered = true;
        }
    }


    var
        myInt: Integer;


    procedure GetLastID(): Integer;
    var
        _Rec: Record "OneDrive Recs";
    begin
        _Rec.SetCurrentKey(ID);
        _Rec.Ascending();
        if _Rec.FindLast() then
            exit(_Rec.ID)
        else
            exit(0);
    end;

    trigger OnInsert()
    begin
        Validate("Attached Date", CurrentDateTime);
        if IsNullGuid("Attached By") then
            "Attached By" := UserSecurityId();
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}