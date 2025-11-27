table 50200 "Enlaces OneDrive"
{
    Caption = 'Credenciales One Drive';
    DataClassification = CustomerContent;
    Description = 'Accede a los Tokens One Drive enlazadas a Business Central';
    Permissions = tabledata "Enlaces OneDrive" = rimd;

    fields
    {
        field(1; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Nombre';
        }
        field(2; "Client ID"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Cliente';
        }
        field(3; "Client Secret"; Text[150])
        {
            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'Client Secret';
        }
        field(4; "Tecnologia"; Enum "Tecnologias Disp")
        {
            DataClassification = CustomerContent;
            Caption = 'Tecnología';
        }
        field(5; Url; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'URL';
        }
    }

    keys
    {
        key(PK; Name, "Client ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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