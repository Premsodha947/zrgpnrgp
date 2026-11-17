@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for RGP NRGP Reservation Data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRGP_RES_PRODUCT_DATA as select from I_ReservationDocumentItem as A
left outer join I_ProductDescription_2 as B on (B.Product = A.Product and B.Language = 'E')
{
    key A.Reservation,
    key A.ReservationItem,
    A.Product,
    A.BaseUnit,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    A.ResvnItmRequiredQtyInEntryUnit as Quantity,
    B.ProductDescription
}
