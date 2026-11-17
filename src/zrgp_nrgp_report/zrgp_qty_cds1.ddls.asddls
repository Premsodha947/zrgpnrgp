@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for RGP NRGP Return Quantity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRGP_QTY_CDS1 as select from  zrgp_nrgp_item as A
{
  key A.refgateno,
  key    A.refgateit,
      cast(sum(A.returnqty ) as abap.dec( 16, 3 ) ) as ttl_returnqty

}
where
  A.refgateno <> ''

group by
  A.refgateno,
  A.refgateit
