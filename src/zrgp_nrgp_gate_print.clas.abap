CLASS zrgp_nrgp_gate_print DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS :
      read_posts
        IMPORTING VALUE(DELIVERYCHALLAN) TYPE STRING
        VALUE(printtype) TYPE STRING
        RETURNING VALUE(result12) TYPE string
                                  RAISING   cx_static_check .
  PROTECTED SECTION.
  PRIVATE SECTION.
   CONSTANTS lc_template_name TYPE string VALUE 'RGP_NRGP_GATEPASS'.
ENDCLASS.



CLASS ZRGP_NRGP_GATE_PRINT IMPLEMENTATION.


 METHOD read_posts .

 DATA  lv_xml TYPE STRING.

DATA(YEAR) = SY-datum+0(4).
IF SY-datum+4(2) = '01' OR SY-datum+4(2) = '02' OR SY-datum+4(2) = '03'.
YEAR = YEAR - 1.
ENDIF.

SELECT SINGLE * FROM zrgp_nrgp_gatepa WITH PRIVILEGED ACCESS as a
WHERE gateno = @deliverychallan AND a~fiscalyear = @YEAR INTO @DATA(CHAHEAD).

SELECT * FROM zrgp_nrgp_item WITH PRIVILEGED ACCESS as a
WHERE gateno = @deliverychallan AND a~fiscalyear = @YEAR  INTO  TABLE @DATA(CHACKITEM).

READ TABLE CHACKITEM INTO DATA(wa) INDEX 1 .

DATA VENDOR TYPE C LENGTH 10.
VENDOR =  |{ chahead-vendor ALPHA = IN }|.
SELECT SINGLE * FROM I_Supplier WITH PRIVILEGED ACCESS as a
WHERE Supplier = @VENDOR INTO @DATA(VENDORName).

lv_xml =
|<form1>                                           |  &&
|<GatePassNo>{ CHAHEAD-gateno }</GatePassNo>  |  &&
|<Date>{ CHAHEAD-gatepassdate+6(2) }-{ CHAHEAD-gatepassdate+4(2) }-{ CHAHEAD-gatepassdate+0(4) }</Date>  |  &&
|<Vehicleno>{ CHAHEAD-vehicleno }</Vehicleno>  |  &&
|<Vendorname>{ VENDORName-SupplierName }</Vendorname>  |  &&
|<EWaybillNo>{ CHAHEAD-ewaybillno }</EWaybillNo>  |  &&
|<Reason>: { CHAHEAD-purpose }</Reason>  |  .

DATA N TYPE C LENGTH 10.

LOOP AT chackitem INTO DATA(WA_ITEM).

N = N + 1.
lv_xml = lv_xml &&
|<Row2>  |  &&
|<Srno>{ N }</Srno>  |  &&
|<MatNumber>{ WA_ITEM-material }</MatNumber>  |  &&
|<Matdesc>{ WA_ITEM-materialdec }</Matdesc>  |  &&
|<qty>{ WA_ITEM-issueqty }</qty>  |  &&
|<UOM>{ WA_ITEM-uom }</UOM>  |  .

IF WA_ITEM-returnqty <> 0 .
lv_xml = lv_xml &&
|<RETURNQTY>{ WA_ITEM-returnqty }</RETURNQTY>  |  .
ENDIF.
lv_xml = lv_xml &&
|<remark></remark>  |  &&
|</Row2>  |  .

ENDLOOP.

IF CHAHEAD-tentativereturndate <> '' AND CHAHEAD-tentativereturndate <> 00000000.
lv_xml = lv_xml &&
|<TentativeReturnDate>{ CHAHEAD-tentativereturndate+6(2) }-{ CHAHEAD-tentativereturndate+4(2) }-{ CHAHEAD-tentativereturndate+0(4) }</TentativeReturnDate>  |  .
ENDIF.

IF wa-returndate <> '' AND wa-returndate <> 00000000.
lv_xml = lv_xml &&
|<Returndate>{ wa-returndate+6(2) }-{ wa-returndate+4(2) }-{ wa-returndate+0(4) }</Returndate>  | .
ENDIF.

lv_xml = lv_xml &&
|</form1>  |  .


DATA FORM TYPE  STRING.

FORM = 'GATE_PRINT_RGP_NRG' .


   CALL METHOD zcl_adobe_print=>adobe(
       EXPORTING
         xml  = LV_XML
         form_name = FORM
       RECEIVING
         result   = result12 ).

 ENDMETHOD.
ENDCLASS.
