@AbapCatalog.sqlViewName: 'YGATEAUTHID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For User Gate Auth ID'
@Metadata.ignorePropagatedAnnotations: true
define view ZUSER_A_GATE_AUTH_ID as select from zuser_a_gate_tab
{
    key tcode as Tcode,
    key plant as Plant,
    key department as Department,
    key 'L1' as LevelApr,
    userid1 as Userid
}
union select from zuser_a_gate_tab
{
    key tcode as Tcode,
    key plant as Plant,
    key department as Department,
    key 'L2' as LevelApr,
    userid2 as Userid
}
union select from zuser_a_gate_tab
{
    key tcode as Tcode,
    key plant as Plant,
    key department as Department,
    key 'L3' as LevelApr,
    userid3 as Userid
}
union select from zuser_a_gate_tab
{
    key tcode as Tcode,
    key plant as Plant,
    key department as Department,
    key 'L4' as LevelApr,
    userid4 as Userid
}
