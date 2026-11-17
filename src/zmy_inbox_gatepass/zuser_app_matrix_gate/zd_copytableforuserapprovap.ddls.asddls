@EndUserText.label: 'Copy Table For User Approval Matrix Gate'
define abstract entity ZD_CopyTableForUserApprovaP
{
  @EndUserText.label: 'New Char'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Tcode' )
  Tcode : CHAR40;
  @EndUserText.label: 'New Plant'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Plant' )
  Plant : CHAR4;
  @EndUserText.label: 'New Char'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Department' )
  Department : CHAR40;
}
