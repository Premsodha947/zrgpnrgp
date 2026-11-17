@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For RGP & NRGP Gate Pass Root Item'
define view entity zrgp_nrgp_item_CDS as select from zrgp_nrgp_item
  association to parent ZRGP_NRGP_GATE_PAS_ROT as _gatehead on $projection.Gateno = _gatehead.Gateno and $projection.fiscalyear = _gatehead.fiscalyear
{
    key gateno as Gateno,
    key srno as Srno,
    key material as Material,
    key fiscalyear,
    materialdec as Materialdec,
    issueqty as Issueqty,
    perunitvalue  as Perunitvalue,
    value as Value, 
    uom as Uom,
    returnable as Returnable,
    returnqty as Returnqty,
    returndate,
      gatepass,
      refgateno,
      refgateit,
      completed,
    _gatehead // Make association public
}
