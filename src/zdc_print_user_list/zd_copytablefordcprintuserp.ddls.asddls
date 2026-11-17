@EndUserText.label: 'Copy Table For DC Print User List'
define abstract entity ZD_CopyTableForDcPrintUserP
{
  @EndUserText.label: 'New INT4'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Srno' )
  Srno : INT4;
}
