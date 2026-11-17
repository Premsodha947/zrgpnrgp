@AbapCatalog.sqlViewName: 'YGATEVALUE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Value'
@Metadata.ignorePropagatedAnnotations: true
define view ZGATE_VALUE_CDS as select from zrgp_nrgp_item
{
    key gateno as Gateno,
   sum( value ) as Value
}
group by
    gateno
