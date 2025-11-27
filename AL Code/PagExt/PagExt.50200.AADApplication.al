pageextension 50200 "Entra ID Application" extends "AAD Application Card"
{
    layout
    {
        addafter("Client Id")
        {
            field("Client Secret"; Rec."Client Secret")
            {
                ApplicationArea = All;
                Caption = 'Client Secret';
                ExtendedDatatype = Masked;
                ToolTip = 'Secreto de la aplicación registrado en Azure Active Directory.';
            }
            field(Email; Rec.Email)
            {
                ApplicationArea = All;
                Caption = 'Email Usuario';
                ToolTip = 'Email del usuario propietario de la aplicación AAD.';
            }
        }
    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}