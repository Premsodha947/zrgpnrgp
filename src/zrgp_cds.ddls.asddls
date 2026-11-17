@AbapCatalog.sqlViewName: 'YRGNRGP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For GRP NRGP GATE PASS'
@Metadata.ignorePropagatedAnnotations: true
define view ZRGP_CDS as select from I_ProductDescription_2 as  a

{
    key a.Product,
        a.ProductDescription
} 
where a.Language = 'E'

