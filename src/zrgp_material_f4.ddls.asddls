@AbapCatalog.sqlViewName: 'YMATERF4RGP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For RGP Material F4'
@Metadata.ignorePropagatedAnnotations: true
define view ZRGP_MATERIAL_F4 as select from I_Product as a 
left outer join I_ProductDescription_2 as b on (b.Product = a.Product and b.Language = 'E')
{
    key a.Product,
        b.ProductDescription,
        a.BaseUnit
}
where  
a.ProductType = 'ROH'   or
a.ProductType = 'HALB'   or
a.ProductType = 'FERT'   or
a.ProductType = 'SERV'   or
a.ProductType = 'ERSA'   or
a.ProductType = 'VERP'   or
a.ProductType = 'HAWA'   or
a.ProductType = 'ZSCP'   or
a.ProductType = 'ZCSM'   or
a.ProductType = 'ZCHM'   or
a.ProductType = 'ZFRT'   or
a.ProductType = 'ZSPA'   or
a.ProductType = 'ZBMA'   or
a.ProductType = 'ZITM'   or
a.ProductType = 'ZAGR'
