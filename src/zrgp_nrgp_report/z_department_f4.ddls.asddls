@AbapCatalog.sqlViewName: 'YDEPF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Report F4'
@Metadata.ignorePropagatedAnnotations: true
define view Z_department_F4 as select from I_PurchasingGroup
{ 
 @ObjectModel.text.element: ['PurchasingGroupName']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
    key PurchasingGroupName
}
group by
PurchasingGroupName 
