@EndUserText.label: 'Table For User Approval Matrix Gate'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_TableForUserApprova
  as select from ZUSER_A_GATE_TAB
  association to parent ZI_TableForUserApprova_S as _TableForUserApprAll on $projection.SingletonID = _TableForUserApprAll.SingletonID
{
  key TCODE as Tcode,
  key PLANT as Plant,
  key DEPARTMENT as Department,
  USERID1 as Userid1,
  USERID2 as Userid2,
  USERID3 as Userid3,
  USERID4 as Userid4,
  @Consumption.hidden: true
  1 as SingletonID,
  _TableForUserApprAll
}
