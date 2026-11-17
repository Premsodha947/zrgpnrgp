@AbapCatalog.sqlViewName: 'ZVENDORF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Report F4'
@Metadata.ignorePropagatedAnnotations: true
define view Z_vendor_F4 as select from ZGATEPASS_CDS_REP
{ 
 @ObjectModel.text.element: ['vendor']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
    key vendor
}
group by
vendor 
