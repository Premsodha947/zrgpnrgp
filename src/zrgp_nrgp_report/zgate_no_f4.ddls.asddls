@AbapCatalog.sqlViewName: 'YGATENOF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Number F4'
@Metadata.ignorePropagatedAnnotations: true
define view ZGATE_NO_F4 as select from ZGATEPASS_CDS_REP
{ 
 @ObjectModel.text.element: ['Gateno']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
    key Gateno
}
group by
Gateno 
