@AbapCatalog.sqlViewName: 'YAMTERF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Material F4'
@Metadata.ignorePropagatedAnnotations: true
define view ZMATERIAL_F4 as select distinct from zrgp_nrgp_item
{
 @ObjectModel.text.element: ['Material']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
     key  material as Material,
      @Search.defaultSearchElement: true 
 @Search.ranking: #LOW
 @Search.fuzzinessThreshold: 0.8
       materialdec
}
group by material,
materialdec
