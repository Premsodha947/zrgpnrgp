@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for RGP NRGP Return Quantity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRGP_QTY_CDS as select from zrgp_nrgp_item as A
{
  key A.refgateno,
      A.refgateit,
      A.completed,
      cast(sum(A.returnqty ) as abap.dec( 16, 3 ) ) as ttl_returnqty

}
where
  A.refgateno <> ''

group by
  A.refgateno,
  A.refgateit,
A.completed



//define view entity ZRGP_QTY_CDS as select from zrgp_nrgp_gatepa as A
//    left outer join zrgp_nrgp_item   as B on B.gateno = A.gateno
//{
//  key A.refgateno,
//      B.srno,
//      cast(sum(B.returnqty ) as abap.dec( 16, 3 ) ) as ttl_returnqty
//
//}
//where
//  A.refgateno <> ''
//
//group by
//  A.refgateno,
//  B.srno
