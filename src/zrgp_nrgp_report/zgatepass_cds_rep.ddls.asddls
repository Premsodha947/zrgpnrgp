@AbapCatalog.sqlViewName: 'YGATEPASREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Pass Report'
@Metadata.ignorePropagatedAnnotations: true
define view ZGATEPASS_CDS_REP as select from    zrgp_nrgp_gatepa     as a
//left outer join zrgp_nrgp_item       as b on ( b.gateno     = a.gateno and b.fiscalyear = a.fiscalyear )
//left outer join ZUSER_A_GATE_TAB_CDS as c on ( c.Department = a.department and c.Plant  = a.plant )
//left outer join ZGATE_VALUE_CDS    as d on (d.Gateno = a.gateno )

{
  key a.gateno           as Gateno,
  key a.gatetype,
  key a.fiscalyear,
      a.plant            as Plant,
      a.gatepassdate,
      a.gatepass,
      a.vendor,
      a.pono,
      a.reservation,
      a.ewaybilldate,
      a.ewaybillno,
      a.purpose,
      $session.user_date as sysdats,
      a.lastreceiveddate ,
      a.lastreceivedtime,
      a.department,
      a.tentativereturndate,
      a.vehicleno,
      
      a.gateoutremark,
      a.outnumber,
      a.createdby,
      a.createddate,
      a.createdtime
}

group by
a.gateno   ,   
a.gatetype,   
a.fiscalyear, 
a.plant       ,
a.gatepassdate,
a.gatepass,
a.vendor,
a.pono,
a.reservation,
a.ewaybilldate,
a.ewaybillno,
a.purpose,
a.lastreceiveddate ,
a.lastreceivedtime,
a.department,
a.tentativereturndate,
a.vehicleno,
      a.gateoutremark,
      a.outnumber,
      a.createdby,
      a.createddate,
      a.createdtime

