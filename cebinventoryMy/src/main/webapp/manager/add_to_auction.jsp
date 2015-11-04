<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Plethora</title>
  <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css"/>
<script language="javascript" type="text/javascript">
_global.aucNo = "";

function searchData(num){
    aucNo = num;
    var url="../ApproveAuctioningServlet?parameter=search&auctionNo="+num;
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
                alert("Invalid Auction Number!");
            }
            var table = document.getElementById("t1");
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
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[8]));
                row.appendChild(c);
                var c = document.createElement("td");
                c.appendChild(document.createTextNode(temp1[9]));
                row.appendChild(c);
                var c1 = document.createElement("input");
                c1.setAttribute("type", "submit");
                c1.setAttribute("name", "Y_"+temp1[1]+"_"+temp1[10]+"_"+temp1[3]+"_"+temp1[4]+"_"+temp1[11]);
                c1.setAttribute("value", "Yes");
                c1.setAttribute("onclick", "update(this);");
                var c2 = document.createElement("td");
                c2.appendChild(c1);
                row.appendChild(c2);
                var c3 = document.createElement("input");
                c3.setAttribute("type", "submit");
                c3.setAttribute("name", "N_"+temp1[1]+"_"+temp1[10]+"_"+temp1[3]+"_Y_"+temp1[11]);
                c3.setAttribute("value", "No");
                c3.setAttribute("onclick", "update(this);");
                var c4 = document.createElement("td");
                c4.appendChild(c3);
                row.appendChild(c4);
                table.appendChild(row);
            }
        }
    }
    xmlHttp.send(url);
}

function view(){
    var url="../ApproveAuctioningServlet?parameter=view";
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
    var url="../ApproveAuctioningServlet?parameter=update&type="+tmp[0]+"&itemCode="+tmp[1]+"&userName="+tmp[2]+"&status="+tmp[3]+"&quantity="+tmp[4]+"&auctionNo="+tmp[5];
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
        var url="../ApproveAuctioningServlet?parameter=updateAll&type="+type+"&auctionNo="+aucNo;
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
      <h2>Approve Auctioning Items</h2>
      <div class="storycontent">
      <form id="f1">
        <table  border="0">
          <tr>
            <td >Auction Number : </td>
            <td width="5">&nbsp;</td>
            <td><input type="text" name="textfield" id="aucno" /> </td>
            <td width="13">&nbsp;</td>
            <td ><input type="button" name="Search" value="Search" onclick="searchData(aucno.value)" /> </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td ><input type="button" name="View Auctioning List" value="View Auctioning List" onclick="view()" /> </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
      </form>
      <form id="f2">
            <table id="t1" width="887" border="1" cellspacing="1" cellpadding="1">
                <tr>
                  <td width="90" bordercolor="#000000" bgcolor="#696969"><font color='white'>Owner</font></td>
                  <td width="69" bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Code</font></td>
                  <td width="70" bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Name </font></td>
                  <td width="72" bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Status</font></td>
                  <td width="107" bordercolor="#000000" bgcolor="#696969"><font color='white'>Quantity</font></td>
                  <td width="107" bordercolor="#000000" bgcolor="#696969"><font color='white'>Remarks</font></td>
                  <td width="32" bordercolor="#000000" bgcolor="#696969"><font color='white'>Price</font></td>
                  <td width="38" bordercolor="#000000" bgcolor="#696969"><font color='white'>Value</font></td>
                  <td width="80" bordercolor="#000000" bgcolor="#696969"><font color='white'>Selling Price</font></td>
                  <td width="159" bordercolor="#000000" bgcolor="#696969"><font color='white'>Cause for Auction</font></td>
                  <td colspan="2" bordercolor="#000000" bgcolor="#696969"><font color='white'>Approve</font></td>
                </tr>
            </table>
        </form>
        <p>&nbsp;</p>
        <table>
      
            <tr>
                <td>Approve All :</td>
                <td width="25">&nbsp;</td>
                <td><input type="submit" name="approve" id="approve" value="Yes All" onclick="updateAll('Y')"/></td>
                <td width="25">&nbsp;</td>
                <td><input type="submit" name="reject" id="reject" value="No All"  onclick="updateAll('N')"/></td>
            </tr>
        </table>
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>