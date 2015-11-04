<%-- 
    Document   : receive_item
    Created on : May 20, 2010, 8:55:02 AM
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

      var st="";
      var date="";

function validateFormOnSubmit1(theForm){
    
  var reason = "";
    
    reason += validateEmpty(theForm.textfield4,"please Enter receipt Number");
    reason += validateEmpty(theForm.textfield42,"please Enter Wbnumber");
    reason += validateEmpty(theForm.tf_userId2,"please Enter owner");
    reason += validateEmpty(theForm.textarea,"please Enter Remarks");
    reason += validateEmpty(theForm.itemcode,"please Enter itemcode and click on Background");
   
   var d;
   for(d=0;d<=counttextbox;d++){

        var tag1="itcode"+d;
        var tag2="itstatus"+d;
         var tag3="qty"+d;

            var itemcode=document.getElementById(tag1);
            var itemstatus=document.getElementById(tag2);
            var itemqty=document.getElementById(tag3);

            var message=validatetable(itemcode,itemstatus,itemqty,"Please Enter itemcode/itemstaus/itemqty");

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
        
       submitreceive(theForm);
  
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

function requestEmpty(){
        
           document.getElementById("req").disabled=true;
           document.getElementById("itemcodelist").disabled=false;
           document.getElementById("buttondis").disabled=false;                

}

var counttextbox=0;

function addMore(){

         counttextbox+=1;
        var inp1=document.createElement('input');
        inp1.setAttribute("type", "text");
        inp1.setAttribute("id", "itcode"+counttextbox);
        inp1.setAttribute("onchange", "filldata(this);")
        var inp2=document.createElement('input');
        inp2.setAttribute("type", "text");
        inp2.setAttribute("id", "itstatus"+counttextbox);
        var inp3=document.createElement('input');
        inp3.setAttribute("type", "text");
        inp3.setAttribute("id", "itname"+counttextbox);
        var inp4=document.createElement('input');
        inp4.setAttribute("type", "text");
        inp4.setAttribute("id", "unit"+counttextbox);
        var inp5=document.createElement('input');
        inp5.setAttribute("type", "text");
        inp5.setAttribute("id", "price"+counttextbox);
        var inp6=document.createElement('input');
        inp6.setAttribute("type", "text");
        inp6.setAttribute("id", "qty"+counttextbox);
        var inp7=document.createElement('input');
        inp7.setAttribute("type", "text");
        inp7.setAttribute("id", "value"+counttextbox);

         
         var rootsub=document.createElement('tr');
         var opt1= document.createElement('td');
         opt1.appendChild(inp1);
         var opt2=document.createElement('td');
         opt2.appendChild(inp2);
         var opt3= document.createElement('td');
         opt3.appendChild(inp3);
         var opt4=document.createElement('td');
         opt4.appendChild(inp4);
         var opt5= document.createElement('td');
         opt5.appendChild(inp5);
         var opt6=document.createElement('td');
         opt6.appendChild(inp6);
         var opt7=document.createElement('td');
         opt7.appendChild(inp7);

        rootsub.appendChild(opt1);
        rootsub.appendChild(opt2);
        rootsub.appendChild(opt3);
        rootsub.appendChild(opt4);
        rootsub.appendChild(opt5);
        rootsub.appendChild(opt6);
        rootsub.appendChild(opt7);

        var root=document.getElementById("datatable");
        root.appendChild(rootsub);


}






function createReceiptNum(){

    
var strurl="../receiptNum";

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
    temp = str.split(":");
    document.getElementById("receipt").value=temp[0];
    document.getElementById("tf_userId2").value=temp[1];
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



function requestdetail(){

    
    var name=document.getElementById("itemname").value;
    var strurl="../requestDetail?itemname="+name;

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
     document.getElementById("req").options.length=0;
    //var iteml=document.getElementById("item").options.length=0;
    for(b=0;b<a1-1;b++){


         var opt= document.createElement("option");
         var tag=document.getElementById("req");
         tag.options.add(opt);
         opt.text=temp[b];

    }
    

}
}
xmlHttp.send(strurl);

}

var fillcom=new Array();

function filldata(myvalue){

        var itemcode=myvalue.value;
        var strurl="../fillData?itemcode="+itemcode;
        var iden=myvalue.id;
        var length=iden.length;
        var last_char=iden.charAt(length-1);

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

            document.getElementById("itstatus"+last_char).value=temp[0];
            document.getElementById("itname"+last_char).value=temp[1];
            document.getElementById("unit"+last_char).value=temp[2];
            document.getElementById("price"+last_char).value=temp[3];
            document.getElementById("value"+last_char).value=temp[4];
            fillcom[last_char]=temp[5];


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

function submitreceive(form){

    var receipt=form.textfield4.value;
    var remarks=form.textarea.value;
    var owner=form.tf_userId2.value;
    var wbnum=form.textfield42.value;
    var strurl;

    if(confirm("Are you sure you want to submit?")){



    if(counttextbox>=1){
        var i=0;
        var url="../SubmitReceiveNoRequest?receipt="+receipt+"&remarks="+remarks+"&owner="+owner+"&wbnum="+wbnum;
        while(i<=counttextbox){
                    
                    var tag1="itcode"+i;
                    var tag2="itstatus"+i;
                    var tag3="itname"+i;
                    var tag4="unit"+i;
                    var tag5="price"+i;
                    var tag6="qty"+i;
                    var tag7="value"+i;
                    var itemcode=document.getElementById(tag1).value;
                    if(itemcode==null)
                    break;
                    url+="&itemcode"+i+"="+document.getElementById(tag1).value;
                    url+="&itemstatus"+i+"="+document.getElementById(tag2).value;
                    url+="&itemname"+i+"="+document.getElementById(tag3).value;
                    url+="&unit"+i+"="+document.getElementById(tag4).value;
                    url+="&price"+i+"="+document.getElementById(tag5).value;
                    url+="&qty"+i+"="+document.getElementById(tag6).value;
                    url+="&value"+i+"="+document.getElementById(tag7).value;
                    url+="&com"+i+"="+fillcom[i];
                    i++;
        }
        strurl=url+"&date="+date+"&count="+counttextbox;
                   
    }
    else{

        
       
    
    var mystr=document.getElementById("req").value;
    var temp = new Array();
    temp = mystr.split(":");
    var request=temp[0];
    var itemcode=form.itemcode.value;
    var itemname=form.itemname.value;
    var price=form.itemprice.value;
    var unit=form.itemunit.value;
    var status=form.itemstatus.value;
    var value=form.itemvalue.value;
    var qty=form.itemqty.value;
    

    strurl="../submitReceive?com="+fillcom[0]+"&receipt="+receipt+"&request="+request+"&itemcode="+itemcode+"&itemname="+itemname+"&price="+price+"&value="+value+"&remarks="+remarks+"&owner="+owner+"&status="+status+"&unit="+unit+"&wbnum="+wbnum+"&qty="+qty+"&date="+date;

    }

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
    alert(str);
    location.reload(true);


    }
}
xmlHttp.send(strurl);


}

}
   

  </script>

    </head><body onload="createReceiptNum();">
<div id="hom_hea">
  <div id="div">
    <div align="left"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="86" width="1290" /></div>
  </div>
  <div id="div2">
    <div id="div3"></div>
  </div>
</div>

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

      <h2>Receive Item </h2>
      <div class="storycontent">
        <p class="hom_titverde">&nbsp;</p>
        <form name="receive" onkeypress="return disableEnterKey(event);">
        <table width="695" border="0" cellpadding="1" cellspacing="1">
          <tr>
            <td width="163">Receipt Number: </td>
            <td width="525" colspan="2"><input type="text" name="textfield4" id="receipt"/></td>
          </tr>
          <tr>
            <td>TV/WB Number: </td>
            <td colspan="2"><input type="text" name="textfield42" /></td>
          </tr>
          <tr>
            <td>Item Name: </td>
            <td colspan="2"><input type="text" name="textfield31" id="itemname"  onkeypress="requestdetail();"/>            </td>
          </tr>
          <tr>
              <td>Request Number:</td>
            <td colspan="2">
                <select  name="select1"  id="req">
            </select>
            </td>
            </tr>
          <tr>
            <td>Date:</td>
          <td width="889" colspan="2"><label name="label1" id="date"></label></td>
          </tr>
          <tr>
            <td>Owner:</td>
            <td colspan="2"><input name="tf_userId2" type="text" id="tf_userId2" /></td>
          </tr>
          <tr>
            <td>Remarks:</td>
            <td colspan="2"><textarea name="textarea"></textarea></td>
          </tr>

          <tr>
            <td colspan="3">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3">
               
                <table width="800" border="1" id="datatable">
              <tr>
                <td width="100">Item Code </td>
                <td width="100">Item Status </td>
                <td width="100">Item Name </td>
                <td width="100">Unit of measure</td>
                <td width="100">Price</td>
                <td width="100">Qty</td>
                <td width="100">Value</td>
              </tr>
              <tr>
                  <td><input type="text" id="itcode0" name="itemcode" onchange="filldata(this);"  onkeypress="return disableEnterKey(event);"/></td>
                  <td><input type="text" id="itstatus0" name="itemstatus"/></td>
                  <td><input type="text" id="itname0" name="itemname"/></td>
                  <td><input type="text" id="unit0" name="itemunit"/></td>
                  <td><input type="text" id="price0" name="itemprice"/></td>
                <td><input type="text" id="qty0" name="itemqty"/></td>
                <td><input type="text" id="value0" name="itemvalue"/></td>
              </tr>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="3"><label></label></td>
          </tr>
          <tr>
            <td colspan="4"><table width="765" border="0">
              <tr align="center">
                  <td width="190"><input type="button" name="button" value="Submit"  onclick="validateFormOnSubmit1(receive);"/></td>
                  <td width="163"><input type="button" name="button12" value="ADD MORE" onclick="addMore();"/></td>
                  <td width="195"><input type="button" name="button1" value="Print" /></td>
                <td width="199"><input type="button" name="button2" value="Cancel" /></td>
              </tr>
            </table>
            <label></label></td>
            </tr>
        </table>
          </form>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>
