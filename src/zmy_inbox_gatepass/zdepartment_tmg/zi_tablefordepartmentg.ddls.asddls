@EndUserText.label: 'Table For Department Gate Pass TMG'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_TableForDepartmentG
  as select from ZDEPARTMENT_TAB
  association to parent ZI_TableForDepartmentG_S as _TableForDepartmeAll on $projection.SingletonID = _TableForDepartmeAll.SingletonID
{
  key PLANT as Plant,
  key DEPARTMENT as Department,
  @Consumption.hidden: true
  1 as SingletonID,
  _TableForDepartmeAll
}
