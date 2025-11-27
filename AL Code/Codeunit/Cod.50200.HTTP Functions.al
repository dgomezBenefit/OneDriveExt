codeunit 50200 "HTTP Functions"
{
    procedure UploadFileToOneDrive()
    var
    begin

    end;

    procedure GetOAuthTokenOneDrive() AuthToken: SecretText;
    var
        _ClientID: Text;
        _ClientSecret: Text;
        _AuthTokenText: Text;
        _AccessTokenURL: Text;
        _OAuth2: Codeunit OAuth2;
        _Scopes: List of [Text];
        _AADApp: Record "AAD Application";
        _Credenciales: Record Credenciales;
        _Description: Text;
    begin
        if _Credenciales.FindFirst() then
            _Description := _Credenciales.OneDriveID
        else
            Error('No hay Credenciales configuradas para One Drive');

        _AADApp.Reset();
        _AADApp.SetFilter(Description, _Description);
        if _AADApp.FindFirst() then begin
            EMAIL := _AADApp.Email;
            _ClientID := Format(_AADApp."Client ID");
            _AccessTokenURL := 'https://login.microsoftonline.com/' + GetTenantID() + '/oauth2/v2.0/token';
            _Scopes.Add('https://graph.microsoft.com/.default');
            if not _OAuth2.AcquireTokenWithClientCredentials(_ClientID, _AADApp."Client Secret", _AccessTokenURL, '', _Scopes, AuthToken) then
                Error('Falló el acceso al Token\%1', GetLastErrorText())
        end
        else
            Error('No hay Credenciales configuradas para One Drive');
    end;

    local procedure GetTenantID() Result: Text
    var
        AzureTenant: Codeunit "Azure AD Tenant";
    begin
        Result := AzureTenant.GetAadTenantId();
        exit(Result);
    end;


    procedure UploadFileToOneDrive(var OneDriveAttach: Record "OneDrive Recs";
    FileName: Text[250]; MimeType: Text; FileContent: InStream)
    var
        _HttpClient: HttpClient;
        _HttpRequestMessage: HttpRequestMessage;
        _HttpResponseMessage: HttpResponseMessage;
        _Headers: HttpHeaders;
        _ContentHeader: HttpHeaders;
        _RequestContent: HttpContent;
        _JsonResponse: JsonObject;
        _AuthToken: SecretText;
        _OneDriveFileUrl: Text;
        _ResponseText: Text;
        _OutStream: OutStream;
        _FileContent: InStream;
        _tempBlob: Codeunit "Temp Blob";
        _FileName: Text;
        _TenantMedia: Record "Tenant Media";
        _MimeType: Text;
        AADApp: Record "AAD Application";
        ContainsSameFile: Label 'Ya existe un registro con el mismo nombre de archivo: %1';
        FileMngm: Codeunit "File Management";
        _FolderPath: Text;
    begin


        // Check if there is a file with the same name in the customer, if it exists, an error message will be displayed
        OneDriveAttach.Reset();
        OneDriveAttach.SetRange("Table ID", OneDriveAttach."Table ID");
        OneDriveAttach.SetRange("No.", OneDriveAttach."No.");
        OneDriveAttach.SetRange("File Name", FileName);
        if OneDriveAttach.FindFirst() then
            Error(ContainsSameFile, FileName);

        _AuthToken := GetOAuthTokenOneDrive();
        if _AuthToken.IsEmpty() then
            Error('Error al obtener el token de acceso.');
        _FolderPath := 'https://graph.microsoft.com/v1.0/users/' + EMAIL + '/drive/root:/BC/' + Format(OneDriveAttach."Table ID") + '/' + OneDriveAttach."No." + '/';
        _OneDriveFileUrl := _FolderPath + FileName + ':/content';

        //CREAR FOLDER ANTES DE SUBIR SI NO EXISTE
        //    CrearFolder(); 


        _HttpRequestMessage.SetRequestUri(_OneDriveFileUrl);
        _HttpRequestMessage.Method := 'PUT';
        _HttpRequestMessage.GetHeaders(_Headers);
        _Headers.Add('Authorization', SecretStrSubstNo('Bearer %1', _AuthToken));
        _RequestContent.GetHeaders(_ContentHeader);
        _ContentHeader.Clear();
        _ContentHeader.Add('Content-Type', MimeType);
        _HttpRequestMessage.Content.WriteFrom(FileContent);

        // Send the HTTP request
        if _HttpClient.Send(_HttpRequestMessage, _HttpResponseMessage) then begin
            // Log the status code for debugging
            //Message('HTTP Status Code: %1', HttpResponseMessage.HttpStatusCode());

            if _HttpResponseMessage.HttpStatusCode() = 404 then begin
                //create folder structure

            end;
            if _HttpResponseMessage.IsSuccessStatusCode() then begin
                _HttpResponseMessage.Content.ReadAs(_ResponseText);
                _JsonResponse.ReadFrom(_ResponseText);
                Message(_ResponseText);
            end else begin
                //Report errors!
                _HttpResponseMessage.Content.ReadAs(_ResponseText);
                Error('Failed to upload files to OneDrive: %1 %2', _HttpResponseMessage.HttpStatusCode(), _ResponseText);
            end;
        end else
            Error('Failed to send HTTP request to OneDrive');
    end;

    local procedure CrearFolder(FolderPath: Text; FolderName: Text; Token: SecretText)
    var
        _Client: HttpClient;
        _Request: HttpRequestMessage;
        _Response: HttpResponseMessage;
        _Headers: HttpHeaders;
        _Content: HttpContent;
        _ContentHeaders: HttpHeaders;
        _JsonBody: Text;
    begin
        _Request.SetRequestUri(FolderPath);
        _Request.Method := 'POST';
        _Request.GetHeaders(_Headers);
        _Headers.Add('Authorization', SecretStrSubstNo('Bearer %1', Token));
        _Headers.Add('Content-Type', 'application/json');

        _JsonBody := '{ "name": "' + FolderName + '", "folder": {}, "@microsoft.graph.conflictBehavior": "rename" }';
        _Content.WriteFrom(_JsonBody);
        _Content.GetHeaders(_ContentHeaders);
        _ContentHeaders.Add('Content-Type', 'application/json');
        _Request.Content := _Content;
        _Client.Send(_Request, _Response);
        if not _Response.IsSuccessStatusCode() then
            Error('Error al crear la carpeta en OneDrive: %1', _Response.HttpStatusCode());
    end;

    local procedure InsertarRegistroOneDrive(var OneDriveAttach: Record "OneDrive Recs")
    var
    begin

    end;

    var
        // TOKEN: SecretText;
        EMAIL: Text[250];

}