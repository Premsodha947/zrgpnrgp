@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for RGP NRGP Reservation F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRGP_RESERVATION_F4 as select from I_ReservationDocumentItem as A
{
   key A.Reservation
}
group by
A.Reservation
