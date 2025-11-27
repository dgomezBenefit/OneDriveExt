page 50200 "Pag. OneDrive FactBox"
{
    Caption = 'One Drive FactBox';
    PageType = ListPart;
    DeleteAllowed = false;
    DelayedInsert = true;
    InsertAllowed = false;
    ApplicationArea = All;
    // UsageCategory = ;
    SourceTable = "OneDrive Recs";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Name; Rec."File Name")
                {
                    Caption = 'Nombre';
                    ApplicationArea = All;
                    ToolTip = 'Nombre del archivo almacenado en One Drive.';
                    Width = 30;

                    trigger OnDrillDown()
                    begin
                        Hyperlink(Rec."Web Url");
                    end;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Extensión del archivo.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenInDetail)
            {
                ApplicationArea = All;
                Image = ViewDetails;
                Caption = 'Ver detalle';
                ToolTip = 'Abrir el registro en modo de detalle.';
                trigger OnAction()
                var
                    _OneDrive: Record "OneDrive Recs";
                begin
                    _OneDrive.Reset();
                    _OneDrive.SetRange("Table ID", Rec."Table ID");
                    _OneDrive.SetRange("No.", Rec."No.");
                    // Page.Run(Page::);
                end;
            }
            action(Upload)
            {
                ApplicationArea = All;
                Caption = 'Cargar archivo a One Drive';
                ToolTip = 'Subir un archivo seleccionado a One Drive.';
                Image = Import;
                trigger OnAction()
                var
                    HTTPFunctions: Codeunit "HTTP Functions";
                    InS: InStream;
                    FileMgt: Codeunit "File Management";
                    FileName: Text[250];
                    UploadFileMsg: Label 'Please select the file to upload';
                begin
                    if UploadIntoStream(UploadFileMsg, '', '', FileName, InS) then
                        HTTPFunctions.UploadFileToOneDrive(Rec, FileName, FileMgt.GetFileNameMimeType(FileName), InS);
                end;
            }
        }
    }

    var
        myInt: Integer;
}