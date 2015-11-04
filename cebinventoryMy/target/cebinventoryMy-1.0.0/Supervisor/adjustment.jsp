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
     function validateFormOnSubmit1(theForm){

  var reason = "";

    reason += validateEmpty(theForm.adjustno,"please Enter adjustment Number");
    reason += validateEmpty(theForm.owner,"please Enter owner");


   var d;
   for(d=0;d<tabc;d++){

        var tag1="itemcode"+d;
        var tag2="avqty"+d;
        

            var itemcode=document.getElementById(tag1);
            var aqty=document.getElementById(tag2);
            

            var message=validatetable(itemcode,aqty,"Please Enter itemcode/itemstaus/itemqty");

            reason +=message;
            if(message!=""){

                break;
            }

   }



  if (reason != "") {
    alert("Some fields need correction:\n" + reason);
    return false;
  }
  else
       submitadjustment();

  return true;
}

function validateEmpty(fld,err){
    var error = "";

    if (fld.value.length == 0) {
        fld.style.background = 'Yellow';
        error = err+".\n";
    } else {
        fld.style.background = 'White';
    }
    return error;
}

function validatetable(ic,aq,err){

    var error="";

    if (ic.value.length == 0) {
        ic.style.background = 'Yellow';
        error = err+".\n";
    }
    else if (aq.value.length == 0) {
        aq.style.background = 'Yellow';
        error = err+".\n";
    }
   else {
        ic.style.background = 'White';
        aq.style.background = 'White';
        
    }
    return error;


}

  function filltable(){

            if(count==0){
            var owner=document.getElementById("owner").value;
            var strURL="../fillTab?owner="+owner;
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
                        tag1.appendChild(ta1);
                        var tag2=document.createElement('td');
                        var ta2=document.createElement('input');
                        ta2.setAttribute("type", "text");
                        ta2.setAttribute("id", "status"+b);
                        ta2.setAttribute("value",temp1[1]);
                        tag2.appendChild(ta2);
                        var tag3=document.createElement('td');
                        var ta3=document.createElement('input');
                        ta3.setAttribute("type", "text");
                        ta3.setAttribute("id", "acqty"+b);
                        ta3.setAttribute("value", temp1[2]);
                        tag3.appendChild(ta3);
                        var tag4=document.createElement('td');
                        var ta4=document.createElement('input');
                        ta4.setAttribute("type", "text");
                        ta4.setAttribute("id", "avqty"+b);
                        tag4.appendChild(ta4);
                        var tag5=document.createElement('td');
                        var ta5=document.createElement('input');
                        ta5.setAttribute("type", "text");
                        ta5.setAttribute("id", "remarks"+b);
                        ta5.setAttribute("value", temp1[3]);
                        tag5.appendChild(ta5);
                        

                opt.appendChild(tag1);
                opt.appendChild(tag2);
                opt.appendChild(tag3);
                opt.appendChild(tag4);
                opt.appendChild(tag5);
                root.appendChild(opt);


            }
                    tabc=b;
                    count+=1;
            }

                }

                    xmlHttp.send(strURL);
            }


}

function adjustmentno(){

    var strurl="../adjNum";

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
    document.getElementById("adjustno").value=str;
}
}
xmlHttp.send(strurl);


}

function submitadjustment(){

        
    var adjustno=document.getElementById("adjustno").value;
    var owner=document.getElementById("owner").value;

    var url="../submitAdjustment?owner="+owner+"&adjustno="+adjustno;
    var a=0;
    while(a<tabc){


                    var tag1="itemcode"+a;
                    var tag2="status"+a;
                    var tag3="acqty"+a;
                    var tag4="avqty"+a;
                    var tag5="remarks"+a;
                    url+="&itemcode"+a+"="+document.getElementById(tag1).value;
                    url+="&status"+a+"="+document.getElementById(tag2).value;
                    url+="&acqty"+a+"="+document.getElementById(tag3).value;
                    url+="&avqty"+a+"="+document.getElementById(tag4).value;
                    url+="&remarks"+a+"="+document.getElementById(tag5).value;
                    a++;
        }

         var strurl=url+"&row="+a;

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
</head><body onload="adjustmentno();">
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
      <h2>Adjustments</h2>
       <div class="storycontent">
           <form id="form1" name="form1" method="post" action="">
        <table width="710" border="0" cellpadding="1" cellspacing="1">
          <!--DWLayoutTable-->
          <tr>
            <td width="185">Adjustment Number: </td>
            <td colspan="2"><input type="text" name="textfield" id="adjustno"/></td>
          </tr>
           <tr>
              <td>Owner:</td>
              <td><input type="text" name="owner" id="owner" /><input type="button" value="OK" onclick="filltable();" /></td>
            </tr>
          <tr>
            <td>&nbsp;</td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td height="1" colspan="3">
             <table width="708" border="1" id="fillhere">
               <tr>
                <td width="101">Item Code </td>
                <td width="87">Item Status </td>
                <td width="103">Actual Quantity</td>
                <td width="125">Available Quantity </td>
                <td width="111">Remarks</td>
               </tr>
             </table></td>
            </tr>
          <tr>
            <td width="129"><input name="b_transfer" type="button" value="Save" onclick="validateFormOnSubmit1(form1);"/></td>
            <td width="386"><input name="b_transfer3" type="button" value="Print" /></td>
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
