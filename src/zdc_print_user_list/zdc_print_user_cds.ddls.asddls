@AbapCatalog.sqlViewName: 'YDCPRINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For DC Print User Cds'
@Metadata.ignorePropagatedAnnotations: true
define view ZDC_PRINT_USER_CDS as select from zdc_print_user
{
    key srno as Srno,
    userid as Userid,
    username as Username
}
