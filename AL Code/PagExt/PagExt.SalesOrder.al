pageextension 50201 "Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addbefore("Attached Documents List")
        {
            part("Pag. OneDrive FactBox"; "Pag. OneDrive FactBox")
            {
                ApplicationArea = All;
                Caption = 'Documentos OneDrive';
                UpdatePropagation = Both;
                SubPageLink = "Table ID" = const(Database::"Sales Header"), "No." = field("No.");
            }
        }
    }

    actions
    {
        addlast(processing)
        {
            action(UploadToOneDrive)
            {
                ApplicationArea = All;
                Caption = 'Prueba Token';
                ToolTip = 'Obten el token para probar';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;

                trigger OnAction()
                var
                    SecTxt: SecretText;
                    OAuth: Codeunit "HTTP Functions";
                begin
                    SecTxt := OAuth.GetOAuthTokenOneDrive();
                end;
            }
        }
    }

    var
        myInt: Integer;
}