<%--
    Document   : adjustment
    Created on : Jun 30, 2010, 1:44:34 PM
    Author     : Isuru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Plethora</title>
  <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
  <meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
  <meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
  <script language="javascript" type="text/javascript">

      var count=0;
      var tabc;
    
  function filltable(){


            if(count==0){
            var strURL="../fillTablef?owner="+document.getElementById("owner").value;
            var xmlHttp;
            if(window.XMLHttpRequest){ // For Mozilla, Safari, ...
            var xmlHttp = new XMLHttpRequest();
            }
                else if(window.ActiveXObject){ // For Internet Explorer
                        var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
            xmlHttp.open('POST', strURL, true);
            xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xmlHttp.onreadystatechange = function(){
            if (xmlHttp.readyState == 4){
                    var str=xmlHttp.responseText;
                    var temp = new Array();
                    temp = str.split("%");
                    var a1=temp.length;
                    var b;
                    for(b=0;b<a1-1;b++){
                    var temp1=new Array();
                    temp1=temp[b].split(":");
                        var root=document.getElementById("fillhere");
                        var opt= document.createElement('tr');
                        opt.setAttribute("id", "text"+b);
                        var tag1=document.createElement('td');
                        var ta1=document.createElement('input');
                        ta1.setAttribute("type", "text");
                        ta1.setAttribute("id", "itemcode"+b);
                        ta1.setAttribute("value", temp1[0]);
                        ta1.setAttribute("size","10");
                        tag1.appendChild(ta1);
                        var tag2=document.createElement('td');
                        var ta2=document.createElement('input');
                        ta2.setAttribute("type", "text");
                        ta2.setAttribute("id", "status"+b);
                        ta2.setAttribute("value",temp1[1]);
                        ta2.setAttribute("size","25");
                        tag2.appendChild(ta2);
                        var tag3=document.createElement('td');
                        var ta3=document.createElement('input');
                        ta3.setAttribute("type", "text");
                        ta3.setAttribute("id", "itemname"+b);
                        ta3.setAttribute("value",temp1[2]);
                        ta3.setAttribute("size","10");
                        tag3.appendChild(ta3);
                        var tag4=document.createElement('td');
                        var ta4=document.createElement('input');
                        ta4.setAttribute("type", "text");
                        ta4.setAttribute("value", temp1[3]);
                        ta4.setAttribute("id", "qty"+b);
                        ta4.setAttribute("size","10");
                        tag4.appendChild(ta4);
                        var tag5=document.createElement('td');
                        var ta5=document.createElement('input');
                        ta5.setAttribute("type", "text");
                        ta5.setAttribute("id", "remarks"+b);
                        ta5.setAttribute("value", temp1[4]);
                        ta5.setAttribute("size","10");
                        tag5.appendChild(ta5);
                        var tag6=document.createElement('td');
                        var ta6=document.createElement('input');
                        ta6.setAttribute("type", "text");
                        ta6.setAttribute("value", temp1[5]);
                        ta6.setAttribute("id", "price"+b);
                        ta6.setAttribute("size","10");
                        tag6.appendChild(ta6);
                        var tag7=document.createElement('td');
                        var ta7=document.createElement('input');
                        ta7.setAttribute("type", "text");
                        ta7.setAttribute("id", "value"+b);
                        ta7.setAttribute("value", temp1[6]);
                        ta7.setAttribute("size","10");
                        tag7.appendChild(ta7);
                        var tag8=document.createElement('td');
                        var ta8=document.createElement('input');
                        ta8.setAttribute("type", "checkbox");
                        ta8.setAttribute("id", "check"+b);
                        ta8.setAttribute("size","10");
                        tag8.appendChild(ta8);


                opt.appendChild(tag1);
                opt.appendChild(tag2);
                opt.appendChild(tag3);
                opt.appendChild(tag4);
                opt.appendChild(tag5);
                opt.appendChild(tag6);
                opt.appendChild(tag7);
                opt.appendChild(tag8);
                root.appendChild(opt);


            }
                    tabc=b;
                    count+=1;
            }

                }

                    xmlHttp.send(strURL);
            }


}


function submitfreeze(){    


    var url="../submitFreeze?owner="+document.getElementById("owner").value;;
    var a=0;
    var x=0;
    while(a<tabc){


                    var tag1="itemcode"+a;
                    var tag2="status"+a;
                    var tag3="check"+a;
                    var check=document.getElementById(tag3).checked;

                 if(check==true){

                    url+="&itemcode"+x+"="+document.getElementById(tag1).value;
                    url+="&status"+x+"="+document.getElementById(tag2).value;
                    x++;

        }
                            a++;

}

         var strurl=url+"&row="+x;


    var xmlHttp;
if(window.XMLHttpRequest){ // For Mozilla, Safari, ...
var xmlHttp = new XMLHttpRequest();
}
else if(window.ActiveXObject){ // For Internet Explorer
var xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
}
xmlHttp.open('POST',strurl,true);
xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlHttp.onreadystatechange = function(){
if (xmlHttp.readyState == 4){

    var str=xmlHttp.responseText;
    //alert(str);
    alert("submit data successfully");
    location.reload(true);


    }
}
xmlHttp.send(strurl);
}
  </script>
</head><body onload="auctionno();filltable()">
<div id="hom_hea"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="85" width="1290"></div>
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
          <td width="44"><a href="../logout">Logout</a></td>
          <td width="9">&nbsp;</td>
          <td width="13">&nbsp;</td>
        </tr>
      </table>
      <h2>Freeze</h2>
       <div class="storycontent">
           <form id="form1" name="form1" method="post" action="">
        <table width="710" border="0" cellpadding="1" cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="74">Owner: </td>
            <td colspan="2"><input type="text" name="textfield" id="owner"/><input type="button" onclick="filltable();" value="OK"></td>
          </tr>

           <tr>
            <td>&nbsp;</td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td height="1" colspan="3">
             <table border="1" id="fillhere">
               <tr>
                <td>Item Code</td>
                <td>Item Status</td>
                <td>Item Name</td>
                <td>Quantity</td>
                <td>Remarks</td>
                <td>Price</td>
                <td>Value</td>
                <td>Select</td>
               </tr>
             </table></td>
            </tr>
          <tr>
            <td width="74"><input name="b_transfer" type="button" value="Save" onclick="submitfreeze();"/></td>
            </tr>
        </table>
               </form>
        <p>&nbsp;</p>
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>
