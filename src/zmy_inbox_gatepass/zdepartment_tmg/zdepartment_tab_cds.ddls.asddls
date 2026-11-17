@AbapCatalog.sqlViewName: 'YDEPARTMENTF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Department F4'
@Metadata.ignorePropagatedAnnotations: true
define view ZDEPARTMENT_TAB_CDS as select from zdepartment_tab
{
    key plant as Plant,
    key department as Department
}
