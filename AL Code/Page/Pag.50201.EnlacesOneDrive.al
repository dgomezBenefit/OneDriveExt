page 50201 "Enlaces OneDrive"
{
    Caption = 'Enlaces OneDrive';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Enlaces OneDrive";

    layout
    {
        area(Content)
        {
            repeater(repeater)
            {
                Caption = 'Credenciales OneDrive';
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = All;
                }
                field("Client Secret"; Rec."Client Secret")
                {
                    ApplicationArea = All;
                }
                field(Url; Rec.Url)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
    begin
    end;

    var
        pag: page "Sales Order";
}