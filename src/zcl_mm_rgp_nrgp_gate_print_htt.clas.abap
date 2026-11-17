class ZCL_MM_RGP_NRGP_GATE_PRINT_HTT definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
    INTERFACES if_oo_adt_classrun .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MM_RGP_NRGP_GATE_PRINT_HTT IMPLEMENTATION.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.


  DATA(req) = request->get_form_fields(  ).
  DATA(GATEENTRY) = VALUE #( req[ name = 'gateentryno' ]-value OPTIONAL ) .
  DATA(printtype) = VALUE #( req[ name = 'printtype' ]-value OPTIONAL ) .

*IF printtype = 'GI' .
*
*SELECT SINGLE * FROM ZRGP_NRGP_REPORT WITH PRIVILEGED ACCESS as a
*WHERE  a~gateno = @GATEENTRY AND Returnqty <> 0  AND a~Returnable = 'X'
*INTO @DATA(CHCKDATA).
*
*ELSE.
*
*SELECT SINGLE * FROM ZRGP_NRGP_REPORT WITH PRIVILEGED ACCESS as a
*WHERE  a~gateno = @GATEENTRY
*INTO @CHCKDATA.
*
*ENDIF.
*
*IF CHCKDATA IS INITIAL .
*
*DATA ERROR TYPE STRING.
*
*IF  printtype = 'GI' .
*error = |Error: Gate Number { GATEENTRY } not found in Gate In Details.|.
*ELSE.
*error = |Error: Gate Number { GATEENTRY } not found in Gate Out Details.|.
*ENDIF.
*
*response->set_text( ERROR ) .
*
*ELSE.
*
*  SELECT SINGLE * FROM zrgp_nrgp_gatepa WITH PRIVILEGED ACCESS as a
*  left outer join zrgp_nrgp_item       as b on ( b~gateno  = a~gateno and b~returnable <> 'X' )
*WHERE a~gateno = @GATEENTRY AND
*(
*(    "   For Not Re
*( b~returnable is NOT null or b~returnable <> '' ) and
* (  a~l1approval = '' OR a~l2approval = '' OR a~l3approval = ''  OR a~l4approval = ''  )
*)
*OR
*( ( b~returnable is null or b~returnable = '' )
*and  (
*( a~Valueabue10k  = '1' AND (  a~l1approval = '' OR a~l2approval = '' OR a~l3approval = ''  OR a~l4approval = ''  )  )
* OR (   ( a~Valueabue10k  <> '1'  AND ( a~l1approval = '' OR a~l2approval = '' ) )
* )
*  )
*)
*)
* INTO @DATA(CHAHEAD).
*
*IF CHAHEAD IS NOT INITIAL .
*
*ERROR  = 'Error : DC Not Yet Approved'.
* response->set_text( ERROR ) .
*ELSE.
  DATA(pdf2) = zrgp_nrgp_gate_print=>read_posts( deliverychallan = GATEENTRY  printtype = printtype ) .
  response->set_text( pdf2 ) .
*ENDIF.
*
*ENDIF.

  endmethod.


   METHOD if_oo_adt_classrun~main .
*   delete from zrgp_nrgp_gatepa.
*   delete from zrgp_nrgp_item.
  endmethod.
ENDCLASS.
