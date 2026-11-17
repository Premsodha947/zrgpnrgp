@AbapCatalog.sqlViewName: 'YNRGPRGPMAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For NRGP Material F4'
@Metadata.ignorePropagatedAnnotations: true
define view ZNRGP_MATERIAL_F4 as select from I_Product as a 
left outer join I_ProductDescription_2 as b on (b.Product = a.Product and b.Language = 'E')
{
    key a.Product,
        b.ProductDescription,
        a.BaseUnit
}
where  
a.ProductType = 'UNBW'   or
a.ProductType = 'ZAST' 
