@AbapCatalog.sqlViewName: 'YRESF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Report F4'
@Metadata.ignorePropagatedAnnotations: true
define view ZRESERVATION_F4 as select from ZGATEPASS_CDS_REP
{ 
 @ObjectModel.text.element: ['reservation']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
    key reservation
}
group by
reservation 
