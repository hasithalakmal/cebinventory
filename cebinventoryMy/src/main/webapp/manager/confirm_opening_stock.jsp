<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Plethora</title>
  <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css"/>
<script language="javascript" type="text/javascript">
_global.docNo = "";

function searchData(num){
    docNo = num;
    var url="../ApproveOpeningStockServlet?parameter=search&docNo="+num;
    var xmlHttp;
    if(window.XMLHttpRequest){ // For Mozilla, Safari, ...
        var xmlHttp = new XMLHttpRequest();
    }
    else if(window.ActiveXObject){ // For Internet Explorer
        var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlHttp.open('POST',url,true);
    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlHttp.onreadystatechange = function(){
        if (xmlHttp.readyState == 4){
            var str=xmlHttp.responseText;
            var temp = new Array();
            temp = str.split("%");
            if(temp[0] == "zzzz"){
                alert("Invalid Document Number!");
            }
            var table = document.getElementById("t1");
            var docDate = "";
            for(var i=0; i<temp.length-1; i++){
                var temp1 = new Array();
                temp1 = temp[i].split(";");
                var row = document.createElement("tr");
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[0]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[1]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[2]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[3]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[4]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[5]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[6]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[7]));
                row.appendChild(c);
                var c1 = document.createElement("input");
                c1.setAttribute("type", "submit");
                c1.setAttribute("name", "Y_"+temp1[1]+"_"+temp1[9]+"_"+temp1[10]);
                c1.setAttribute("value", "Yes");
                c1.setAttribute("onclick", "update(this);");
                var c2 = document.createElement("td");
                c2.appendChild(c1);
                row.appendChild(c2);
                var c3 = document.createElement("input");
                c3.setAttribute("type", "submit");
                c3.setAttribute("name", "N_"+temp1[1]+"_"+temp1[9]+"_"+temp1[10]);
                c3.setAttribute("value", "No");
                c3.setAttribute("onclick", "update(this);");
                var c4 = document.createElement("td");
                c4.appendChild(c3);
                row.appendChild(c4);
                table.appendChild(row);
                docDate = temp1[8];
            }
            document.getElementById("l1").appendChild(document.createTextNode(docDate));
        }
    }
    xmlHttp.send(url);
}

function view(){
    var url="../ApproveOpeningStockServlet?parameter=view";
    var xmlHttp;
    if(window.XMLHttpRequest){ // For Mozilla, Safari, ...
        var xmlHttp = new XMLHttpRequest();
    }
    else if(window.ActiveXObject){ // For Internet Explorer
        var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlHttp.open('POST',url,true);
    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlHttp.onreadystatechange = function(){
        if (xmlHttp.readyState == 4){
            var str=xmlHttp.responseText;
            alert(str);
        }
    }
    xmlHttp.send(url);
}


function update(button){
    var param = button.name
    var tmp = new Array();
    tmp = param.split("_")
    var url="../ApproveOpeningStockServlet?parameter=update&type="+tmp[0]+"&itemCode="+tmp[1]+"&userName="+tmp[2]+"&docNo="+tmp[3];
    var xmlHttp;
    if(window.XMLHttpRequest){ // For Mozilla, Safari, ...
        var xmlHttp = new XMLHttpRequest();
    }
    else if(window.ActiveXObject){ // For Internet Explorer
        var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlHttp.open('POST',url,true);
    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlHttp.onreadystatechange = function(){
        if (xmlHttp.readyState == 4){
            var str=xmlHttp.responseText;
            alert("Data Submitted Successfully!");
            alert(str);
            location.reload(true);
        }
    }
    xmlHttp.send(url);
}

function updateAll(type){
    var typ = "";
    if(type=="Y"){
        typ="Yes All";
    }
    else{
        typ = "No All";
    }
    if(confirm("Are you sure that you want to proceed with the \""+typ+"\" action?")){
        var url="../ApproveOpeningStockServlet?parameter=updateAll&type="+type+"&docNo="+docNo;
        var xmlHttp;
        if(window.XMLHttpRequest){ // For Mozilla, Safari, ...
            var xmlHttp = new XMLHttpRequest();
        }
        else if(window.ActiveXObject){ // For Internet Explorer
            var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlHttp.open('POST',url,true);
        xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xmlHttp.onreadystatechange = function(){
            if (xmlHttp.readyState == 4){
                var str=xmlHttp.responseText;
                alert("Data Submitted Successfully!");
                alert(str);
                location.reload(true);
            }
        }
        xmlHttp.send(url);
    }
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
      <h2>Approve Opening Stock</h2>
      <div class="storycontent">
      <form id="f1">
        <table  border="0">
          <tr>
            <td >Document Number : </td>
            <td width="5">&nbsp;</td>
            <td ><input type="text" name="docno" /> </td>
            <td width="13">&nbsp;</td>
            <td ><input type="button" name="Search" value="Search" onclick="searchData(docno.value)" /> </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td ><input type="button" name="View Document List" value="View Document List" onclick="view()" /> </td>
          </tr>
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
        </table>
      </form>
      <form id="f2">
        <table>
          <tr>
            <td>Document Date : </td>
            <td ><label  id="l1"> </label></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
            <table id="t1" width="795" border="1">
              <tr>
                <td width="134"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Owner</font></td>
                <td width="178"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Code</font></td>
                <td width="126"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Name</font></td>
                <td width="206"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Status</font></td>
                <td width="106"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Quantity</font></td>
                <td width="134"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Company</font></td>
                <td width="134"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Received Date</font></td>
                <td width="134"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Reference</font></td>
                <td colspan="2"  bordercolor="#000000" bgcolor="#696969"><font color='white'>Approve</font></td>
              </tr>
            </table>
            <p>&nbsp;</p>
            <table>
                <tr>
                    <td>Approve All :</td>
                    <td width="25">&nbsp;</td>
                    <td><input type="submit" name="approve" id="approve" value="Yes All" onclick="updateAll('Y');" /></td>
                    <td width="25">&nbsp;</td>
                    <td><input type="submit" name="reject" id="reject" value="No All" onclick="updateAll('N');" /></td>
                </tr>
            </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </form>
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>
