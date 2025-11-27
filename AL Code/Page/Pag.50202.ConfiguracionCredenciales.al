page 50202 "Configuracion Credenciales"
{
    PageType = Card;
    SourceTable = Credenciales;
    Caption = 'Credenciales Microsoft';
    UsageCategory = Administration;
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    // ShowFilter = false;
    // AutoSplitKey = false;

    layout
    {
        area(Content)
        {
            group(OneDrive)
            {
                Caption = 'OneDrive';
                field("OneDriveID"; Rec.OneDriveID)
                {
                    Caption = 'OneDrive';
                    ApplicationArea = All;
                    TableRelation = "AAD Application".Description;
                    ToolTip = 'Identificador de la aplicación registrado en Azure Active Directory.';
                    trigger OnValidate()
                    var
                        AADAppRec: Record "AAD Application";
                    begin
                        if Rec.OneDriveID <> '' then begin
                            AADAppRec.SetFilter(Description, Rec.OneDriveID);
                            if AADAppRec.FindFirst() then begin
                                if AADAppRec."Client Secret" = '' then
                                    Error('La aplicación seleccionada no tiene un Client Secret configurado en Azure AD.');
                            end
                            else
                                Error('La aplicación seleccionada no es válida.');
                        end;

                    end;
                }
            }
            group(SharePoint)
            {
                Caption = 'SharePoint';
                field("SharePoint Client Id"; Rec.SharePointID)
                {
                    Caption = 'SharePoint ID';
                    ApplicationArea = All;
                    TableRelation = "AAD Application".Description;
                    ToolTip = 'Identificador de la aplicación registrado en Azure Active Directory para SharePoint.';
                    trigger OnValidate()
                    var
                        AADAppRec: Record "AAD Application";
                    begin
                        if Rec.SharePointID <> '' then begin
                            AADAppRec.SetFilter(Description, Rec.SharePointID);
                            if AADAppRec.FindFirst() then begin
                                if AADAppRec."Client Secret" = '' then
                                    Error('La aplicación seleccionada no tiene un Client Secret configurado en Azure AD.');
                            end
                            else
                                Error('La aplicación seleccionada no es válida.');
                        end;

                    end;
                }
            }
        }
    }
    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             Caption = 'Probar Token';
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             Image = TestFile;
    //             trigger OnAction()
    //             var
    //                 OAuth: Codeunit "OAuth Cod";
    //             begin
    //                 if Rec.OneDriveID = '' then
    //                     Error('Debe seleccionar una aplicación válida.');
    //                 OAuth.GetOAuthTokenOneDrive();
    //             end;
    //         }
    //     }
    // }

    trigger OnOpenPage()
    begin
        //Inicializa un registro en caso de que no exista.
        if Rec.IsEmpty then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;


    var
        pag: page "General Ledger Setup";
        PAG2: Page "AAD Application Card";
}