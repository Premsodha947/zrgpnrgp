@AbapCatalog.sqlViewName: 'YGATETYF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Type F4'
@Metadata.ignorePropagatedAnnotations: true
define view Zgatetype_F4 as select from  ZGATEPASS_CDS_REP
{ 
 @ObjectModel.text.element: ['gatetype']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
    key gatetype
}
group by
gatetype 
