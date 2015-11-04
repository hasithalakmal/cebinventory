<%-- 
    Document   : issue_item
    Created on : May 25, 2010, 2:34:54 PM
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
 
 
var date="";


function validateFormOnSubmit2(theForm){

  var reason = "";

    reason += validateEmpty(theForm.textfield4,"please Enter issue Number");
    reason += validateEmpty(theForm.manual,"please Enter manual number");
    reason += validateEmpty(theForm.tf_userId,"please Enter to whom issue to");
    reason += validateEmpty(theForm.textarea,"please Enter remarks");
    

            var itemcode=document.getElementById("itcode");
            var itemstatus=document.getElementById("itstatus");
            var itemqty=document.getElementById("qty");

            reason +=validatetable(itemcode,itemstatus,itemqty,"Please Enter itemcode/itemstaus/itemqty");

    
  if (reason != "") {
    alert("Some fields need correction:\n" + reason);
    return false;
  }
  else
       submitissue(theForm);

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


function validatetable(ic,is,iq,err){

    var error="";

    if (ic.value.length == 0) {
        ic.style.background = 'Yellow';
        error = err+".\n";
    }
    else if (is.value.length == 0) {
        is.style.background = 'Yellow';
        error = err+".\n";
    }
    else if (iq.value.length == 0) {
        iq.style.background = 'Yellow';
        error = err+".\n";
    }
    else {
        ic.style.background = 'White';
        is.style.background = 'White';
        iq.style.background = 'White';
    }
    return error;


}

function createIssueNum(){

    
var strurl="../issueNum";

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
    document.getElementById("issue").value=str;
    var currentTime = new Date();
var month = currentTime.getMonth() + 1;
var day = currentTime.getDate();
var year = currentTime.getFullYear();
var str=year+"/"+month+"/"+day;
date=str;
var da=document.createTextNode(str);
var d=document.getElementById("date");
d.appendChild(da);

}
}
xmlHttp.send(strurl);

}

function issueReport(){


        var strurl="../issueReport?issue="+document.getElementById("issue").value;

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

    
}
}
xmlHttp.send(strurl);

}


function getReceipt(){

    var strurl="../getReceipt?";
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
    var temp = new Array();
    temp = str.split("%");
    var a1=temp.length;
     document.getElementById("receipt").options.length=0;
    //var iteml=document.getElementById("item").options.length=0;
    for(b=0;b<a1-1;b++){


         var opt= document.createElement("option");
         var tag=document.getElementById("receipt");
         tag.options.add(opt);
         opt.text=temp[b];

    }


}
}
xmlHttp.send(strurl);
}

function disableEnterKey(e)
{
     var key;
     if(window.event)
          key = window.event.keyCode; //IE
     else
          key = e.which; //firefox

     return (key != 13);
}


function filldata(){

     var itemcode=document.getElementById("itcode").value;
     var strurl="../fillDat?itemcode="+itemcode;

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
    var temp = new Array();
    temp = str.split(":");

            document.getElementById("itstatus").value=temp[0];
            document.getElementById("itname").value=temp[1];
            document.getElementById("unit").value=temp[2];
            document.getElementById("price").value=temp[3];
            document.getElementById("value").value=temp[4];
            st=temp[5];

}
}
xmlHttp.send(strurl);

}



function submitissue(form){

    
    var issue=document.getElementById("issue").value;
    var itemcode=form.itemcode.value;
    var itemname=form.itemname.value;
    var price=form.itemprice.value;
    var value=form.itemvalue.value;
    var remarks=form.textarea.value;
    var issueto=form.tf_userId.value;
    var status=form.itemstatus.value;
    var unit=form.itemunit.value;
    var qty=form.itemqty.value;
    var manual=form.manual.value;

   if(confirm("do you want to issue?")){

    
    var strurl="../submitIssue?com="+st+"&issue="+issue+"&itemcode="+itemcode+"&itemname="+itemname+"&price="+price+"&value="+value+"&remarks="+remarks+"&issueto="+issueto+"&status="+status+"&unit="+unit+"&qty="+qty+"&date="+date+"&manual="+manual;
    



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
    //issueReport();
    alert("submit data successfully");
    location.reload(true);


    }
}
xmlHttp.send(strurl);


}
}
        
    </script>

    </head><body onload="createIssueNum();getReceipt();">
<div id="hom_hea">
  <div align="left"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="86" width="1290"></div>
</div>

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
      <h2>Issue Item </h2>
      <div class="storycontent">
        <p class="hom_titverde">&nbsp;</p>
        <form name="issu" onkeypress="return disableEnterKey(event);">
        <table width="619" border="0" cellpadding="1" cellspacing="1">
          <tr>
            <td width="252">Issue Number: </td>
            <td colspan="2"><input type="text" name="textfield4" id="issue"/></td>
          </tr>
          <tr>
              <td>Manual Doc Number:</td>
              <td><input type="text" name="manual" id="manual"></td>
          </tr>
          <tr>
            <td>Date:</td>
            <td colspan="2"><label name="label1" id="date"></label></td>
          </tr>
          <tr>
            <td>Issue to:</td>
            <td colspan="2"><input name="tf_userId" type="text" id="tf_userId" /></td>
          </tr>
          <tr>
            <td>Remarks:</td>
            <td colspan="2"><textarea name="textarea"></textarea></td>
          </tr>
          <tr>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3"><table width="792" border="1">
              <tr>
                <td width="109">Item Code </td>
                <td width="123">Item Status </td>
                <td width="221">Item Name </td>
                <td width="101">Unit of measure </td>
                <td width="60">Price</td>
                <td width="47">Qty</td>
                <td width="85">Value</td>
              </tr>
              <tr>
                  <td><input type="text" id="itcode" name="itemcode" onchange="filldata();"  onkeypress="return disableEnterKey(event);"/></td>
                  <td><input type="text" id="itstatus" name="itemstatus"/></td>
                  <td><input type="text" id="itname" name="itemname"/></td>
                  <td><input type="text" id="unit" name="itemunit"/></td>
                  <td><input type="text" id="price" name="itemprice"/></td>
                <td><input type="text" id="qty" name="itemqty"/></td>
                <td><input type="text" id="value" name="itemvalue"/></td>
              </tr>
              
            </table></td>
          </tr>
          <tr>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3"><label></label></td>
            </tr>
        </table>
          <table width="1057" border="0">
            <tr align="center">
              <td width="363"><input type="button" name="button12" value="OK" onclick="validateFormOnSubmit2(issu);"/></td>
              <td width="232"><input type="button" name="button1" value="Print" /></td>
              <td width="440"><input type="button" name="button2" value="Cancel" /></td>
            </tr>
          </table>
        </form>
        <p></p>
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>
