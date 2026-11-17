@EndUserText.label: 'Table For DC Print User List'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_TableForDcPrintUser
  as select from ZDC_PRINT_USER
  association to parent ZI_TableForDcPrintUser_S as _TableForDcPrintUAll on $projection.SingletonID = _TableForDcPrintUAll.SingletonID
{
  key SRNO as Srno,
  USERID as Userid, 
  USERNAME as Username,
  @Consumption.hidden: true
  1 as SingletonID,
  _TableForDcPrintUAll
}
