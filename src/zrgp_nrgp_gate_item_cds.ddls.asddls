@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For RGP & NRGP Gate Pass Root Item CDS'
define root view entity ZRGP_NRGP_GATE_ITEM_CDS
  as select from zrgp_nrgp_item
{
  key gateno       as Gateno,
  key srno         as Srno,
  key material     as Material,
  key fiscalyear,
      materialdec  as Materialdec,
      issueqty     as Issueqty,
      value        as Value,
      perunitvalue as Perunitvalue,
      uom          as Uom,
      returnable   as Returnable,
      returnqty    as Returnqty,
      returndate,
      gatepass,
      refgateno,
      refgateit, 
      completed
}
