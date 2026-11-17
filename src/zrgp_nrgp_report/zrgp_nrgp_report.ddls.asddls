@AbapCatalog.sqlViewName: 'YRGPNRGP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For RGP NRGP Report'
@Metadata.ignorePropagatedAnnotations: true
define view ZRGP_NRGP_REPORT as select from  ZGATEPASS_CDS_REP     as a
left outer join zrgp_nrgp_item       as b on ( b.gateno     = a.Gateno and b.fiscalyear = a.fiscalyear  )
left outer join ZRGP_QTY_CDS1       as c on ( c.refgateno     = a.Gateno and c.refgateit = b.srno  )
left outer join I_PurchasingGroup as d on ( d.PurchasingGroup = a.department )
left outer join I_Supplier as e on ( e.Supplier = a.vendor )
left outer join I_User as f on ( f.UserID = a.createdby )
{
@UI.lineItem             : [{ position: 10 }]
@EndUserText.label       : 'Gate No.'  
@UI.selectionField       : [{position: 10 }]  
@Consumption.valueHelpDefinition: [ { entity : { name: 'ZGATE_NO_F4', element : 'Gateno' } }]
 key  a.Gateno as Gateno,
@UI.lineItem             : [{ position: 20 }] 
@EndUserText.label       : 'Sr. No.' 
 key   b.srno as Srno,
 @UI.lineItem             : [{ position: 30 }]
@EndUserText.label       : 'Material' 
@UI.selectionField       : [{position: 20 }]  
@Consumption.valueHelpDefinition: [ { entity : { name: 'ZMATERIAL_F4', element : 'Material' } }]
 key   b.material as Material,
 @UI.lineItem             : [{ position: 50 }]
@EndUserText.label       : 'Plant' 
@UI.selectionField       : [{position: 30 }]  
@Consumption.valueHelpDefinition: [ { entity : { name: 'I_PlantStdVH', element : 'Plant' } }]
 key   a.Plant as Plant,
  @UI.lineItem             : [{ position: 60 }]
@EndUserText.label       : 'Gate Type' 
@UI.selectionField       : [{position: 30 }]  
@Consumption.valueHelpDefinition: [ { entity : { name: 'Zgatetype_F4', element : 'gatetype' } }]
 key a.gatetype as gatetype,
  @UI.lineItem             : [{ position: 70 }]
@EndUserText.label       : 'Fiscal Year' 
 key a.fiscalyear as fiscalyear,
   @UI.lineItem             : [{ position: 80 }]
@EndUserText.label       : 'Gate Pass Date' 
      a.gatepassdate,
        @UI.lineItem             : [{ position: 90 }]
@EndUserText.label       : 'Gate Pass' 
      a.gatepass,
        @UI.lineItem             : [{ position: 100 }]
@EndUserText.label       : 'Vendor' 
@UI.selectionField       : [{position: 30 }]  
@Consumption.valueHelpDefinition: [ { entity : { name: 'Z_vendor_F4', element : 'vendor' } }]
      a.vendor,
      @UI.lineItem             : [{ position: 101 }]
@EndUserText.label       : 'Vendor Name' 
      e.SupplierName,
        @UI.lineItem             : [{ position: 120 }]
@EndUserText.label       : 'Reservation' 
@UI.selectionField       : [{position: 30 }]  
@Consumption.valueHelpDefinition: [ { entity : { name: 'ZRESERVATION_F4', element : 'reservation' } }]
      a.reservation,
        @UI.lineItem             : [{ position: 130 }]
@EndUserText.label       : 'Eway Bill Date' 
      a.ewaybilldate,
        @UI.lineItem             : [{ position: 140 }]
@EndUserText.label       : 'Eway Bill No.' 
      a.ewaybillno,
        @UI.lineItem             : [{ position: 150 }]
@EndUserText.label       : 'Purpose' 
      a.purpose,
   @UI.lineItem             : [{ position: 40 }]
@EndUserText.label       : 'Material Description' 
   b.materialdec as Materialdec,
   @UI.lineItem             : [{ position: 360 }]
@EndUserText.label       : 'Issue Qty' 
  case when a.gatetype <> 'Gate In' then b.issueqty end as Issueqty,
   @UI.lineItem             : [{ position: 390 }]
@EndUserText.label       : 'UOM' 
   b.uom as Uom,
   @UI.lineItem             : [{ position: 410 }]
@EndUserText.label       : 'Return Qty' 
 case when a.gatetype = 'Gate In' then   b.returnqty else c.ttl_returnqty end as Returnqty,
   @UI.lineItem             : [{ position: 420 }]
@EndUserText.label       : 'Balance Qty' 
case when a.gatetype <> 'Gate In' then cast( coalesce( b.issueqty,0) - coalesce(c.ttl_returnqty,0)  as abap.dec( 13, 3 ) ) end as BalanceQTY ,
 @UI.lineItem             : [{ position: 450 }]
@EndUserText.label       : 'Referance Gate No' 
   b.refgateno,
    @UI.lineItem             : [{ position: 450 }]
@EndUserText.label       : 'Referance Gate Item' 
   b.refgateit,
       @UI.lineItem             : [{ position: 451 }]
@EndUserText.label       : 'Completed' 
   b.completed,
       @UI.lineItem             : [{ position: 452 }]
@EndUserText.label       : 'Department' 
@UI.selectionField       : [{position: 30 }]  
@Consumption.valueHelpDefinition: [ { entity : { name: 'Z_department_F4', element : 'PurchasingGroupName' } }]
      d.PurchasingGroupName as department,
          @UI.lineItem             : [{ position: 453 }]
@EndUserText.label       : 'Tentative Return Date' 
      a.tentativereturndate,
          @UI.lineItem             : [{ position: 454 }]
@EndUserText.label       : 'Vehicle No' 
      a.vehicleno,
        @UI.lineItem             : [{ position: 455 }]
@EndUserText.label       : 'Returnable' 
     case when a.gatepass = 'RGP' then 'X' end as Returnable,
          @UI.lineItem             : [{ position: 456 }]
@EndUserText.label       : 'Gate Out Remark' 
    a.gateoutremark,
          @UI.lineItem             : [{ position: 457 }]
@EndUserText.label       : 'Gate Out Number' 
    a.outnumber,
    @UI.lineItem             : [{ position: 458 }]
@EndUserText.label       : 'Created By' 
    a.createdby,
@UI.lineItem             : [{ position: 459 }]
@EndUserText.label       : 'Created By Name' 
    f.UserDescription,
    @UI.lineItem             : [{ position: 460 }]
@EndUserText.label       : 'Created On' 
      a.createddate,
      @UI.lineItem             : [{ position: 461 }]
@EndUserText.label       : 'Created Time' 
      a.createdtime
     
     
   
}
