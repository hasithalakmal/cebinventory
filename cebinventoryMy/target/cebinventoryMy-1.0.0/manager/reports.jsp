<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Plethora</title>
  <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css"/>
<script language="javascript" type="text/javascript">
function viewReport(input){
    var url = "";
    if(input == 'A'){
        var itemCode = prompt("Please Enter The Item Code :","");
        url="../ReportInvokeServlet?report=ItemDetailsReport&itemCode="+itemCode;
    }
    else if (input == 'B'){
        var userName = prompt("Please Enter The User Name :","");
        url="../ReportInvokeServlet?report=QuantityOnHandReportAll&userName="+userName;
    }
    else if (input == 'C'){
        var userName = prompt("Please Enter The User Name :","");
        url="../ReportInvokeServlet?report=QuantityOnHandReportInventory&userName="+userName;
    }
    else if (input == 'D'){
        var userName = prompt("Please Enter The User Name :","");
        url="../ReportInvokeServlet?report=QuantityOnHandReportStock&userName="+userName;
    }
    else if (input == 'E'){
        var docNo = prompt("Please Enter The Document Number :","");
        url="../ReportInvokeServlet?report=OpeningStockDetailsReport&docNo="+docNo;
    }
    else if (input == 'F'){
        url="../ReportInvokeServlet?report=ServiceAgentExpiringItemListReport";
    }
    else if (input == 'G'){
        url="../ReportInvokeServlet?report=WarrentyExpiredItemListReport";
    }
    else if (input == 'H'){
        url="../ReportInvokeServlet?report=ItemStatusChangeRequestDetailsReport";
    }
    else if (input == 'I'){
        var adjustmentNo = prompt("Please Enter The Adjustment Number :","");
        url="../ReportInvokeServlet?report=AdjustmentDetailsReport&adjustmentNo="+adjustmentNo;
    }
    else if (input == 'J'){
        var acutionNo = prompt("Please Enter The Auction No :","");
        url="../ReportInvokeServlet?report=AuctioningListReport&acutionNo="+acutionNo;
    }
    else if (input == 'K'){
        var verificationNo = prompt("Please Enter The Verification Number :","");
        url="../ReportInvokeServlet?report=AnnualVerificationDetailsReport&verificationNo="+verificationNo;
    }
    var xmlHttp;
    if(window.XMLHttpRequest){ // For Mozilla, Safari, ...
        var xmlHttp = new XMLHttpRequest();
    }
    else if(window.ActiveXObject){ // For Internet Explorer
        var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlHttp.open('GET',url,true);
    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlHttp.onreadystatechange = function(){
        if (xmlHttp.readyState == 4){
            var str=xmlHttp.responseText;
            alert(str);
        }
    }
    xmlHttp.send(url);
}

</script>
</head>
<body>
<div id="hom_hea"><img src="../files/header.jpg" alt="Plethora" title="Plethora - The Inventory Management System" height="86" width="1290"/></div>
<div id="con_fja">
<div id="hom_fja">The Inventory Management System </div>
</div>
<div id="men"><a href="approve_damaged_items.jsp">Approve Item Status Changes</a><a href="confirm_opening_stock.jsp">Confirm Opening Stock</a><a href="approve_adjustments.jsp">Approve Item Adjustments</a><a href="add_to_auction.jsp">Approve Auctioning Items</a><a href="confirm_annual_verification.jsp">Approve Annual Verifications</a><a href="reports.jsp">Inquiries</a><a href="reports.jsp">Reports</a><a href="request_item.jsp">Request Item</a><a href="receive_item.jsp">Receive Item</a><a href="transfer_item.jsp">Lend Item</a><a href="get_lend_item.jsp">Get Lended Items</a><a href="report_damage.jsp">Change Item Status </a><a href="edit_profile.jsp">Edit Profile</a><a href="get_item_details.jsp">View Item Details</a></div>
<div id="pri">
<div id="con_int">
  <div id="content">
    <!-- end header -->
    <div class="post">
      <table width="970" border="0" cellspacing="1" cellpadding="1">
        <tr>       
          <td width="891">&nbsp;</td>
          <td width="44"><a href="../logout">Logout</a></td>
          <td width="9">&nbsp;</td>
          <td width="13">&nbsp;</td>
        </tr>
      </table>
      <h2>Reports</h2>
      <div class="storycontent">
      <form id="f1">
        <table width="753" height="214"  border="0">
          <tr>&nbsp;</tr>
          <tr>&nbsp;</tr>
          <tr>
            <td width="260" ><input type="button" name="b1" value="Item Details Report" onclick="viewReport('A')" /> </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td ><p>
              <input type="button" name="b2" value="Quantity On Hand Report - All Items" onclick="viewReport('B')" />
            </p>
              </td>
          </tr>
          <tr>&nbsp;</tr>
          <tr>&nbsp;</tr>
          <tr>
            <td ><input type="button" name="b3" value="Quantity On Hand Report - Inventory Items" onclick="viewReport('C')" id="b3" />             </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td ><p>
              <input type="button" name="b4" value="Quantity On Hand Report - Stock Items" onclick="viewReport('D')" id="b4" />
            </p>
              </td>
          </tr>
          <tr>&nbsp;</tr>
          <tr>&nbsp;</tr>
          <tr>
            <td ><input type="button" name="b5" value="Opening Stock Details Report" onclick="viewReport('E')" id="b5" />             </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td ><p>
              <input type="button" name="b6" value="Service Agent Expiring Item List Report" onclick="viewReport('F')" id="b6" />
            </p>
              </td>
          </tr>
          <tr>&nbsp;</tr>
          <tr>&nbsp;</tr>
          <tr>
            <td ><input type="button" name="b7" value="Warrenty Expired Item List Report" onclick="viewReport('G')" id="b7" />             </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td ><p>
              <input type="button" name="b8" value="Item Status Change Request Details Report" onclick="viewReport('H')" id="b8" />
            </p>
              </td>
          </tr>
          <tr>&nbsp;</tr>
          <tr>&nbsp;</tr>
          <tr>
            <td ><input type="button" name="b9" value="Adjustment Details Report" onclick="viewReport('I')" id="b9" />             </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td ><p>
              <input type="button" name="b10" value="Auctioning List Report" onclick="viewReport('J')" id="b10" />
            </p>
              </td>
          </tr>
          <tr>&nbsp;</tr>
          <tr>&nbsp;</tr>
          <tr>
            <td ><input type="button" name="b11" value="Annual Verification Details Report" onclick="viewReport('K')" id="b11" />
          </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <p>&nbsp;</p>
          </tr>
          <tr>
            <td colspan="5">&nbsp;</td>
          </tr>
        </table>
      </form>
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>
