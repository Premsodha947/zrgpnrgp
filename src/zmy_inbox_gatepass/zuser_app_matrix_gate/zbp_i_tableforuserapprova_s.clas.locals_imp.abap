CLASS lhc_rap_tdat_cts DEFINITION FINAL.
* LHC_ZI_TABLEFORUSERAPPROVA_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
 PUBLIC SECTION.
    CLASS-METHODS:
      get
        RETURNING
          VALUE(result) TYPE REF TO if_mbc_cp_rap_table_cts.
*  PUBLIC SECTION.
*    CONSTANTS:
*      CO_ENTITY TYPE abp_entity_name VALUE `ZI_TABLEFORUSERAPPROVA_S`,
*      CO_TRANSPORT_OBJECT TYPE mbc_cp_api=>indiv_transaction_obj_name VALUE `ZTABLEFORUSERAPPROVA`,
*      CO_AUTHORIZATION_ENTITY TYPE abp_entity_name VALUE `ZI_TABLEFORUSERAPPROVA`.
*
*  PRIVATE SECTION.
*    METHODS:
*      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
*        IMPORTING
*          KEYS REQUEST requested_features FOR TableForUserApprAll
*        RESULT result,
*      SELECTCUSTOMIZINGTRANSPTREQ FOR MODIFY
*        IMPORTING
*          KEYS FOR ACTION TableForUserApprAll~SelectCustomizingTransptReq
*        RESULT result,
*      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
*        IMPORTING
*           REQUEST requested_authorizations FOR TableForUserApprAll
*        RESULT result,
*      EDIT FOR MODIFY
*        IMPORTING
*          KEYS FOR ACTION TableForUserApprAll~edit.
ENDCLASS.



CLASS lhc_rap_tdat_cts IMPLEMENTATION.

  METHOD get.

    result = mbc_cp_api=>rap_table_cts( table_entity_relations = VALUE #(
                                          ( entity = 'ZI_TABLEFORUSERAPPROVA' table = 'ZUSER_A_GATE_TAB' )
                                        ) ) ##NO_TEXT.
  ENDMETHOD.

  ENDCLASS.
CLASS LHC_YI_SALESSCHEMETMG_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      get_instance_features FOR INSTANCE FEATURES
        IMPORTING
                  keys   REQUEST requested_features FOR TableForUserApprAll
        RESULT    result,
      selectcustomizingtransptreq FOR MODIFY
        IMPORTING
                  keys   FOR ACTION TableForUserApprAll~selectcustomizingtransptreq
        RESULT    result,
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR TableForUserApprAll
        RESULT result.

ENDCLASS.

CLASS LHC_YI_SALESSCHEMETMG_S IMPLEMENTATION.

  METHOD get_instance_features.
    DATA: selecttransport_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled,
          edit_flag            TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.

    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
        iv_objectname = 'ZUSER_A_GATE_TAB'
        iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    DATA(transport_service) = cl_bcfg_cd_reuse_api_factory=>get_transport_service_instance(
                                iv_objectname = 'ZUSER_A_GATE_TAB'
                                iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table ).
    IF transport_service->is_transport_allowed( ) = abap_false.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    READ ENTITIES OF ZI_TableForUserApprova_S  IN LOCAL MODE
    ENTITY TableForUserApprAll
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(all).
    IF all[ 1 ]-%is_draft = if_abap_behv=>mk-off.
      selecttransport_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result = VALUE #( (
               %tky = all[ 1 ]-%tky
               %action-edit = edit_flag
               %assoc-_TableForUserApprova = edit_flag
               %action-selectcustomizingtransptreq = selecttransport_flag ) ).

  ENDMETHOD.

METHOD selectcustomizingtransptreq.
    MODIFY ENTITIES OF ZI_TableForUserApprova_S IN LOCAL MODE
      ENTITY TableForUserApprAll
        UPDATE FIELDS ( transportrequestid )
        WITH VALUE #( FOR key IN keys
                        ( %tky               = key-%tky
                          transportrequestid = key-%param-transportrequestid
                         ) ).

    READ ENTITIES OF ZI_TableForUserApprova_S IN LOCAL MODE
      ENTITY TableForUserApprAll
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(entities).
    result = VALUE #( FOR entity IN entities
                        ( %tky   = entity-%tky
                          %param = entity ) ).
  ENDMETHOD.
  METHOD get_global_authorizations.
    AUTHORITY-CHECK OBJECT 'S_TABU_NAM' ID 'TABLE' FIELD 'ZI_TABLEFORUSERAPPROVA' ID 'ACTVT' FIELD '02'.
    DATA(is_authorized) = COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                                  ELSE if_abap_behv=>auth-unauthorized ).
    result-%update      = is_authorized.
    result-%action-edit = is_authorized.
    result-%action-selectcustomizingtransptreq = is_authorized.
  ENDMETHOD.
ENDCLASS.
CLASS LSC_YI_SALESSCHEMETMG_S DEFINITION FINAL INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS:
      save_modified REDEFINITION.
ENDCLASS.

CLASS LSC_YI_SALESSCHEMETMG_S IMPLEMENTATION.
  METHOD save_modified.
    DATA(transport_from_singleton) = VALUE #( update-tableforuserapprall[ 1 ]-transportrequestid OPTIONAL ).
    IF transport_from_singleton IS NOT INITIAL.
      lhc_rap_tdat_cts=>get( )->record_changes(
                                  transport_request = transport_from_singleton
                                  create            = REF #( create )
                                  update            = REF #( update )
                                  delete            = REF #( delete ) )->update_last_changed_date_time( view_entity_name   = 'ZI_TABLEFORUSERAPPROVA'
                                                                                                        maintenance_object = 'ZTABLEFORUSERAPPROVA' ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
CLASS LHC_YI_SALESSCHEMETMG DEFINITION FINAL INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      validatetransportrequest FOR VALIDATE ON SAVE
        IMPORTING
          keys FOR TableForUserApprAll~validatetransportrequest,
      get_global_features FOR GLOBAL FEATURES
        IMPORTING
        REQUEST requested_features FOR TableForUserApprova
        RESULT result.
ENDCLASS.



CLASS LHC_YI_SALESSCHEMETMG IMPLEMENTATION.

  METHOD get_global_features.
    DATA edit_flag TYPE abp_behv_flag VALUE if_abap_behv=>fc-o-enabled.
    IF cl_bcfg_cd_reuse_api_factory=>get_cust_obj_service_instance(
         iv_objectname = 'ZUSER_A_GATE_TAB'
         iv_objecttype = cl_bcfg_cd_reuse_api_factory=>simple_table )->is_editable( ) = abap_false.
      edit_flag = if_abap_behv=>fc-o-disabled.
    ENDIF.
    result-%update = edit_flag.
    result-%delete = edit_flag.
  ENDMETHOD.

  METHOD validatetransportrequest.
    DATA change TYPE REQUEST FOR CHANGE ZI_TableForUserApprova_S .
    SELECT SINGLE transportrequestid
      FROM zuser_a_gat_d_s
      WHERE singletonid = 1
      INTO @DATA(transportrequestid).
    lhc_rap_tdat_cts=>get( )->validate_changes(
                                transport_request = transportrequestid
                                table             = 'ZUSER_A_GATE_TAB'
                                keys              = REF #( keys )
                                reported          = REF #( reported )
                                failed            = REF #( failed )
                                change            = REF #( change-tableforuserapprova ) ).
  ENDMETHOD.
ENDCLASS.

*CLASS LHC_ZI_TABLEFORUSERAPPROVA_S IMPLEMENTATION.
*  METHOD GET_INSTANCE_FEATURES.
*  mbc_cp_api=>rap_bc_api( )->get_instance_features(
*    transport_object   = co_transport_object
*    entity             = co_entity
*    keys               = REF #( keys )
*    requested_features = REF #( requested_features )
*    result             = REF #( result )
*    failed             = REF #( failed )
*    reported           = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD SELECTCUSTOMIZINGTRANSPTREQ.
*  mbc_cp_api=>rap_bc_api( )->select_transport_action(
*    entity   = co_entity
*    keys     = REF #( keys )
*    result   = REF #( result )
*    mapped   = REF #( mapped )
*    failed   = REF #( failed )
*    reported = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD GET_GLOBAL_AUTHORIZATIONS.
*  mbc_cp_api=>rap_bc_api( )->get_global_authorizations(
*    entity                   = co_authorization_entity
*    requested_authorizations = REF #( requested_authorizations )
*    result                   = REF #( result )
*    reported                 = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD EDIT.
*  mbc_cp_api=>rap_bc_api( )->get_default_transport_request(
*    transport_object = co_transport_object
*    entity           = co_entity
*    keys             = REF #( keys )
*    mapped           = REF #( mapped )
*    failed           = REF #( failed )
*    reported         = REF #( reported ) ).
*  ENDMETHOD.
*ENDCLASS.
*CLASS LSC_ZI_TABLEFORUSERAPPROVA_S DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_SAVER.
*  PROTECTED SECTION.
*    METHODS:
*      SAVE_MODIFIED REDEFINITION.
*ENDCLASS.
*
*CLASS LSC_ZI_TABLEFORUSERAPPROVA_S IMPLEMENTATION.
*  METHOD SAVE_MODIFIED.
*  mbc_cp_api=>rap_bc_api( )->record_changes(
*    transport_object = lhc_ZI_TableForUserApprova_S=>co_transport_object
*    entity           = lhc_ZI_TableForUserApprova_S=>co_entity
*    create           = REF #( create )
*    update           = REF #( update )
*    delete           = REF #( delete )
*    reported         = REF #( reported ) ).
*  mbc_cp_api=>rap_bc_api( )->update_last_changed_date_time(
*    maintenance_object = 'ZTABLEFORUSERAPPROVA'
*    entity             = lhc_ZI_TableForUserApprova_S=>co_authorization_entity
*    create             = REF #( create )
*    update             = REF #( update )
*    delete             = REF #( delete )
*    reported           = REF #( reported ) ).
*  ENDMETHOD.
*ENDCLASS.
*CLASS LHC_ZI_TABLEFORUSERAPPROVA DEFINITION FINAL INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
*  PUBLIC SECTION.
*    CONSTANTS:
*      CO_ENTITY TYPE sxco_cds_object_name VALUE `ZI_TABLEFORUSERAPPROVA`.
*
*  PRIVATE SECTION.
*    METHODS:
*      VALIDATEDATACONSISTENCY FOR VALIDATE ON SAVE
*        IMPORTING
*          KEYS FOR TableForUserApprova~ValidateDataConsistency,
*      GET_GLOBAL_FEATURES FOR GLOBAL FEATURES
*        IMPORTING
*          REQUEST REQUESTED_FEATURES FOR TableForUserApprova
*        RESULT result,
*      COPY FOR MODIFY
*        IMPORTING
*          KEYS FOR ACTION TableForUserApprova~Copy,
*      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
*        IMPORTING
*           REQUEST requested_authorizations FOR TableForUserApprova
*        RESULT result,
*      GET_INSTANCE_FEATURES FOR INSTANCE FEATURES
*        IMPORTING
*          KEYS REQUEST requested_features FOR TableForUserApprova
*        RESULT result,
*      VALIDATETRANSPORTREQUEST FOR VALIDATE ON SAVE
*        IMPORTING
*          KEYS_TABLEFORUSERAPPRALL FOR TableForUserApprAll~ValidateTransportRequest
*          KEYS_TABLEFORUSERAPPROVA FOR TableForUserApprova~ValidateTransportRequest.
*ENDCLASS.
*
*CLASS LHC_ZI_TABLEFORUSERAPPROVA IMPLEMENTATION.
*  METHOD VALIDATEDATACONSISTENCY.
*  mbc_cp_api=>rap_bc_api( )->check_consistency(
*    entity   = co_entity
*    keys     = REF #( keys )
*    failed   = REF #( failed )
*    reported = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD GET_GLOBAL_FEATURES.
*  mbc_cp_api=>rap_bc_api( )->get_global_features(
*    transport_object   = lhc_ZI_TableForUserApprova_S=>co_transport_object
*    entity             = co_entity
*    requested_features = REF #( requested_features )
*    result             = REF #( result )
*    reported           = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD COPY.
*  mbc_cp_api=>rap_bc_api( )->copy_by_association(
*    entity   = co_entity
*    keys     = REF #( keys )
*    mapped   = REF #( mapped )
*    failed   = REF #( failed )
*    reported = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD GET_GLOBAL_AUTHORIZATIONS.
*  mbc_cp_api=>rap_bc_api( )->get_global_authorizations(
*    entity                   = lhc_ZI_TableForUserApprova_S=>co_authorization_entity
*    requested_authorizations = REF #( requested_authorizations )
*    result                   = REF #( result )
*    reported                 = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD GET_INSTANCE_FEATURES.
*  mbc_cp_api=>rap_bc_api( )->get_action_features(
*    entity             = co_entity
*    keys               = REF #( keys )
*    requested_features = REF #( requested_features )
*    result             = REF #( result )
*    failed             = REF #( failed )
*    reported           = REF #( reported ) ).
*  ENDMETHOD.
*  METHOD VALIDATETRANSPORTREQUEST.
*  mbc_cp_api=>rap_bc_api( )->validate_transport_request(
*    transport_object = lhc_ZI_TableForUserApprova_S=>co_transport_object
*    entity           = lhc_ZI_TableForUserApprova_S=>co_entity
*    validation_keys  = VALUE #( ( REF #( keys_TableForUserApprAll ) )
*                                ( REF #( keys_TableForUserApprova ) ) )
*    failed           = REF #( failed )
*    reported         = REF #( reported ) ).
*  ENDMETHOD.
*ENDCLASS.
