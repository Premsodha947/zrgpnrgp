CLASS lhc_ZRGP_NRGP_GATE_ITEM_CDS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zrgp_nrgp_gate_item_cds RESULT result.

ENDCLASS.

CLASS lhc_ZRGP_NRGP_GATE_ITEM_CDS IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.
