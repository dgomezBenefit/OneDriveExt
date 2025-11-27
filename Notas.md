Crear un nuevo Factbox en distintas pantallas donde el cliente requiere subir algunos archivos relacionados a un documento.

Para que esto no merme el rendimiento de la aplicacion ni sature la base de datos de BC, se requiere que los archivos se guarden en un servicio en la nube distinto, One Drive en este caso.


# Microsoft Graph

Es una Web API Restful que permite el acceso a aplicaciones y servicios web de Microsoft 365 como:
- OneDrive
- Outlook
- Teams
- SharePoint
- Azure Active, etc.

Se pueden subir y descargar archivos, leer y crear eventos en Outlook, enviar correos, etc.


## Posibilidad de multicuentas

- Es necesario que exista una pagina de configuracion de cuentas de One Drive para que se pueda seleccionar una cuenta activa y se carguen en esa cuenta los nuevos archivos.
-   asi mismo que se pueda configurar la carpeta a donde se subiran los archivos.

- tambien que cuando un documento se suba y ya exista un documento con el mismo nombre, lo renombre para que se conserven ambos

- El numero de tabla, el numero de documento y la compañia establecen la ruta de almacenamiento.


## Ruta del documento a guardar
Cuando se mande llamar la funcion upload document.
    - El primer folder: 'es el root de la cuenta de configuracion'
    - Segundo folder: seria 'BC'
    - Tercer folder: 'Numero de pagina desde la cual se hace el upload'
    - Cuarto folder : 'Numero de documento ejemplo "FV00034" desde la cual se sube el archivo'

Quedando de la sigueinte manera:
    *Root/BC/{NumPagina}/{NumDocumento}/{NombreArchivo}*