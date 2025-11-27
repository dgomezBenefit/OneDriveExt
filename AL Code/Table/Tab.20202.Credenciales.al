table 50202 "Credenciales"
{

    Caption = 'Credenciales';
    DataClassification = CustomerContent;
    Permissions = tabledata "Credenciales" = rimd;

    fields
    {
        field(1; ID; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'ID';
            InitValue = 'Credenciales Microsoft';
            // AutoIncrement = true;
        }
        field(2; OneDriveID; Text[150])
        {
            DataClassification = CustomerContent;
            Description = 'Guarda el Description de la aplicación AAD para OneDrive.';
        }
        field(3; SharePointID; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'SharePoint Client ID';
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
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