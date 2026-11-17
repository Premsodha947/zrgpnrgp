@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For RGP & NRGP Gate Pass Root Item Proj'
define root view entity ZRGP_NRGP_GATE_ITEM_PROJ
 provider contract transactional_query
  as projection on ZRGP_NRGP_GATE_ITEM_CDS
{
    key Gateno,
    key Srno,
    key Material,
    key fiscalyear,
    Materialdec,
    Issueqty,
    Perunitvalue,
    Value,
    Uom,
    Returnable,
    Returnqty,
    returndate,
      gatepass,
      refgateno,
      refgateit,
      completed
}
