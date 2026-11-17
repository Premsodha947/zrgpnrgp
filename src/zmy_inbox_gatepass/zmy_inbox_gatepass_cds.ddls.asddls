@AbapCatalog.sqlViewName: 'YGATEPASSINBOX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For MY Inbox Gate Pass'
@Metadata.ignorePropagatedAnnotations: true
define view ZMY_INBOX_GATEPASS_CDS
as select from    zrgp_nrgp_gatepa     as a
left outer join zrgp_nrgp_item       as b on ( b.gateno     = a.gateno  and b.returnable <> 'X' )
left outer join ZUSER_A_GATE_TAB_CDS as c on ( c.Department = a.department and c.Plant  = a.plant )
left outer join ZGATE_VALUE_CDS    as d on (d.Gateno = a.gateno )

{
  key a.gateno           as Gateno,
      a.plant            as Plant,
      a.department       as Department,
      a.chalandate       as Chalandate,
      a.challantime      as Challantime,
      a.duedate          as Duedate,
      a.headertext       as Headertext,
      a.username         as Username,
      a.issueby          as Issueby,
      a.vehicleno        as Vehicleno,
      a.contactno        as Contactno,
      a.partyname        as Partyname,
      a.addressline1     as Addressline1,
      a.addressline2     as Addressline2,
      a.contactperson    as Contactperson,
      a.mobilenonumer    as Mobilenonumer,
//      a.valueabue10k     as Valueabue10k,
      case when b.gateno is null or b.gateno = '' then  a.valueabue10k 
      else '1' end as Valueabue10k,
      a.valuebelow10k    as Valuebelow10k,
      a.approvedby       as Approvedby,
      a.trancomapnyname  as Trancomapnyname,
      a.transmobileno    as Transmobileno,
      a.vehicletype      as Vehicletype,
      c.Userid1          as L1approvalAuthuser,
      c.Userid2          as L2approvalAuthuser,
      c.Userid3          as L3approvalAuthuser,
      c.Userid4          as L4approvalAuthuser,
      a.l1approval,
      a.l2approval,
      a.l3approval,
      a.l4approval,
      a.l1approvalremark as L1approvalremark,
      a.l2approvalremark as L2approvalremark,
      a.l3approvalremark as L3approvalremark,
      a.l4approvalremark as L4approvalremark,
      case when b.gateno is initial or b.gateno is null or b.gateno = '' then ''
      else 'X' end as returnable,
      $session.user_date as sysdats,
      a.lastreceiveddate ,
       a.lastreceivedtime,
       d.Value,
       
      a.gateoutremark,
      a.outnumber      
}
where 
  a.l1approval <> 'N' and
  a.l2approval <> 'N' and
  a.l3approval  <> 'N' and
  a.l4approval <> 'N' 
group by
  a.gateno,
  b.gateno,
  a.plant,
  a.department,
  a.chalandate,
  a.challantime,
  a.duedate,
  a.headertext,
  a.username,
  a.issueby,
  a.vehicleno,
  a.contactno,
  a.partyname,
  a.addressline1,
  a.addressline2,
  a.contactperson,
  a.mobilenonumer,
  a.valueabue10k,
  a.valuebelow10k,
  a.approvedby,
  a.trancomapnyname,
  a.transmobileno,
  a.vehicletype,
  c.Userid1,
  c.Userid2,
  c.Userid3,
  c.Userid4,
  a.l1approvalremark,
  a.l2approvalremark,
  a.l3approvalremark,
  a.l4approvalremark,
  a.l1approval,
  a.l2approval,
  a.l3approval,
  a.l4approval,
  b.returnable,
  a.lastreceiveddate ,
  a.lastreceivedtime,
  d.Value,
  a.gateoutremark,
      a.outnumber  
