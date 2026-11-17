@AbapCatalog.sqlViewName: 'YRGPGATEQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For RGP Gate Out QTY'
@Metadata.ignorePropagatedAnnotations: true
define view ZRGP_GATE_OUT_QTY as select from zrgp_nrgp_item as A
{
  key A.gateno,
  key A.srno,
      cast(sum(A.issueqty ) as abap.dec( 16, 3 ) ) as ISUEQTY

}
where
  A.refgateno <> ''

group by
  A.gateno,
  A.srno
