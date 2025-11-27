tableextension 50200 "AAD Application TabExt" extends "AAD Application"
{
    fields
    {
        field(50200; "Client Secret"; Text[150])
        {

            DataClassification = EndUserPseudonymousIdentifiers;
            Caption = 'Client Secret';
        }
        field(50201; Email; Text[150])
        {

            DataClassification = CustomerContent;
            Caption = 'Email';
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}