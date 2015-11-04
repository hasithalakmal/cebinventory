<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Plethora</title>
  <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript">
_global.str="Transfer out";
_global.un="";
function load(){
    //un=username;
    var url="../ItemList?parameter=load";
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
            var temp = new Array();
            temp = str.split("%");
            var table = document.getElementById("t1");

            for(var i=0; i<temp.length-1; i++){
                var temp1 = new Array();
                temp1 = temp[i].split(";");
                var row = document.createElement("tr");
                var item_code = document.createTextNode(temp1[0]);
                var c1 = document.createElement("td");
                c1.appendChild(item_code);

                row.appendChild(c1);
                var item_name = document.createTextNode(temp1[1]);
                var c2 = document.createElement("td");
                c2.appendChild(item_name);
                row.appendChild(c2);
                var price = document.createTextNode(temp1[2]);
                var c3 = document.createElement("td");
                c3.appendChild(price);
                row.appendChild(c3);
                var value = document.createTextNode(temp1[3]);
                var c4 = document.createElement("td");
                c4.appendChild(value);
                row.appendChild(c4);

                var ser_no = document.createTextNode(temp1[4]);
                var c6 = document.createElement("td");
                c6.appendChild(ser_no);
                row.appendChild(c6);
                var status = document.createTextNode(temp1[5]);
                var c7 = document.createElement("td");
                c7.appendChild(status);
                row.appendChild(c7);
                var composite = document.createTextNode(temp1[6]);
                var c8 = document.createElement("td");
                c8.appendChild(composite);
                row.appendChild(c8);
                var composite_code = document.createTextNode(temp1[7]);
                var c9 = document.createElement("td");
                c9.appendChild(composite_code);
                row.appendChild(c9);
                var is_inv = document.createTextNode(temp1[8]);
                var c10 = document.createElement("td");
                c10.appendChild(is_inv);
                row.appendChild(c10);
                var is_cap = document.createTextNode(temp1[9]);
                var c11 = document.createElement("td");
                c11.appendChild(is_cap);
                row.appendChild(c11);
                var dep_rate = document.createTextNode(temp1[10]);
                var c12 = document.createElement("td");
                c12.appendChild(dep_rate);
                row.appendChild(c12);
                var critical = document.createTextNode(temp1[11]);
                var c13 = document.createElement("td");
                c13.appendChild(critical);
                row.appendChild(c13);
                var uom = document.createTextNode(temp1[12]);
                var c14 = document.createElement("td");
                c14.appendChild(uom);
                row.appendChild(c14);

                table.appendChild(row);

            }

document.getElementById("l1").appendChild(document.createTextNode(owner));
        }
    }
    xmlHttp.send(url);
}



</script>
</head>
    <body onload="load()">
<div id="hom_hea"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="86" width="1290" /></div>
<div id="con_fja">
<div id="hom_fja">The Inventory Management System </div>
</div>
<div id="men"><a href="add_inventory_item.jsp">Add Inventory item </a><a href="add_stock_item.jsp">add stock item</a><a href="receive_item.jsp">Receive item</a><a href="issue_item.jsp">issue item</a><a href="report_damage.jsp">Change status</a><a href="annual_verification.jsp">annual verification</a><a href="adjustment.jsp">adjustments</a><a href="edit_profile.jsp">Edit Profile</a><a href="inquiry.jsp">Inquiries</a><a href="report.jsp">reports</a><a href="openning_stock.jsp">OpenningStock</a><a href="auction.jsp">Auction</a><a href="freeze.jsp">Freeze</a></div>
<div id="pri">
<div id="con_int">
  <div id="content">
    <!-- end header -->
    <div class="post">
      <table width="970" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="891">&nbsp;</td>
          <td width="44"><a href="../login/login.html">Logout</a></td>
          <td width="9">&nbsp;</td>
          <td width="13">&nbsp;</td>
        </tr>
      </table>
      <h2>List of Items</h2>
      <div class="storycontent">

        <form id="f2">
        <table>

          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
        <table id="t1" width="811" border="1" cellspacing="1" cellpadding="1">
           <tr>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Code</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Name</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Price</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Value</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Serial Number</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Status</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Depreciation rate</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Unit of measure</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Composite</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Composite Code</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Is Inventory</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Is Capital</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Critical</font></td>

           </tr>
      </table>
            <p>&nbsp;</p>
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