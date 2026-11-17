@AbapCatalog.sqlViewName: 'YUSERAPP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For MY Inbox Gate Pass Approval'
@Metadata.ignorePropagatedAnnotations: true
define view ZUSER_A_GATE_TAB_CDS as select from zuser_a_gate_tab
{
    key tcode as Tcode,
    key plant as Plant,
    key department as Department,
    userid1 as Userid1,
    userid2 as Userid2,
    userid3 as Userid3,
    userid4 as Userid4
}
