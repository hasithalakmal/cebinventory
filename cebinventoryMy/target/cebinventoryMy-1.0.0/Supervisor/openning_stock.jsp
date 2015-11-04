<%--
    Document   : annual_verification
    Created on : Jun 24, 2010, 10:05:55 AM
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


function validateFormOnSubmit1(theForm){

  var reason = "";

    reason += validateEmpty(theForm.docnum,"please Enter receipt Number");
    reason += validateEmpty(theForm.owner,"please Enter Wbnumber");


   var d;
   for(d=0;d<=counttextbox;d++){

        var tag1="itemcode"+d;
        var tag3="status"+d;
        var tag2="itemname"+d
        var tag4="qty"+d;
        var tag5="pdate"+d;
        var tag6="company"+d;
        var tag7="ref"+d;


            var itemcode=document.getElementById(tag1);
            var itemstatus=document.getElementById(tag3);
            var itemname=document.getElementById(tag2);
            var qty=document.getElementById(tag4);
            var pdate=document.getElementById(tag5);
            var company=document.getElementById(tag6);
            var ref=document.getElementById(tag7);


            var message=validatetable(itemcode,itemstatus,itemname,qty,pdate,company,ref,"Please Enter itemcode/itemstaus/itemqty.....etc");

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
        
       submitOpen(theForm);

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

function validatetable(ic,is,inm,iq,ipd,icm,irf,err){

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
    if (inm.value.length == 0) {
        ic.style.background = 'Yellow';
        error = err+".\n";
    }
    if (ipd.value.length == 0) {
        ic.style.background = 'Yellow';
        error = err+".\n";
    }
    if (icm.value.length == 0) {
        ic.style.background = 'Yellow';
        error = err+".\n";
    }
    if (irf.value.length == 0) {
        ic.style.background = 'Yellow';
        error = err+".\n";
    }
    else {
        ic.style.background = 'White';
        is.style.background = 'White';
        iq.style.background = 'White';
        inm.style.background = 'White';
        ipd.style.background = 'White';
        icm.style.background = 'White';
        irf.style.background = 'White';
    }
    return error;


}






function documentNumber(){

var strurl="../documentNumber";

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
    document.getElementById("docnum").value=str;
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


var counttextbox=0;


function addMore(){

        counttextbox+=1;

        var inp1=document.createElement('input');
        inp1.setAttribute("type", "text");
        inp1.setAttribute("id", "itemcode"+counttextbox);
        inp1.setAttribute("onchange", "filldata(this);");
        var inp2=document.createElement('input');
        inp2.setAttribute("type", "text");
        inp2.setAttribute("id", "itemname"+counttextbox);
        var inp3=document.createElement('input');
        inp3.setAttribute("type", "text");
        inp3.setAttribute("id", "status"+counttextbox);
        var inp4=document.createElement('input');
        inp4.setAttribute("type", "text");
        inp4.setAttribute("id", "qty"+counttextbox);
        var inp5=document.createElement('input');
        inp5.setAttribute("type", "text");
        inp5.setAttribute("id", "pdate"+counttextbox);
        var inp6=document.createElement('input');
        inp6.setAttribute("type", "text");
        inp6.setAttribute("id", "company"+counttextbox);
        var inp7=document.createElement('input');
        inp7.setAttribute("type", "text");
        inp7.setAttribute("id", "ref"+counttextbox);


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
var fillcom=new Array();

function filldata(myvalue){

        var itemcode=myvalue.value;
        var strurl="../fillDataopp?itemcode="+itemcode;
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

            document.getElementById("status"+last_char).value=temp[0];
            document.getElementById("itemname"+last_char).value=temp[1];
            fillcom[last_char]=temp[2];


}
}
xmlHttp.send(strurl);

}



function submitOpen(form){


    var docnum=form.docnum.value;
    var owner=form.owner.value;
    var strurl;

   

        var i=0;
        var url="../SubmitOpen?docnum="+docnum+"&owner="+owner+"&date="+date;
        while(i<=counttextbox){

                    var tag1="itemcode"+i;
                    var tag2="itemname"+i;
                    var tag3="status"+i;
                    var tag4="qty"+i;
                    var tag5="pdate"+i;
                    var tag6="company"+i;
                    var tag7="ref"+i;
                    var itemcode=document.getElementById(tag1).value;
                    if(itemcode==null)
                    break;
                    url+="&itemcode"+i+"="+document.getElementById(tag1).value;
                    url+="&status"+i+"="+document.getElementById(tag3).value;
                    url+="&itemname"+i+"="+document.getElementById(tag2).value;
                    url+="&qty"+i+"="+document.getElementById(tag4).value;
                    url+="&pdate"+i+"="+document.getElementById(tag5).value;
                    url+="&company"+i+"="+document.getElementById(tag6).value;
                    url+="&ref"+i+"="+document.getElementById(tag7).value;
                    url+="&com"+i+"="+fillcom[i];
                    i++;
        }
        strurl=url+"&count="+counttextbox;
       

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

</head>
<body onload="documentNumber();">
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
      <h2>Openning Stock</h2>
      <div class="storycontent">
        <form id="form1" name="form1" method="post" action="">
          <table width="653" border="0">
            <tr>
              <td colspan="2">Document Number:</td>
              <td><input type="text" name="docnum" id="docnum"/></td>
            </tr>
            <tr>
              <td colspan="2">Owner:</td>
              <td><input type="text" name="owner" /></td>
            </tr>
            <tr>
            <td>Date:</td>
            <td width="889" colspan="2"><label name="label1" id="date"></label></td>
            </tr>
            <tr>
              <td colspan="3"><table width="639" border="1" cellspacing="1" cellpadding="1" id="datatable">
                <tr>
                  <td width="63">Item Code</td>
                  <td width="114">Item Name</td>
                  <td width="69">Item Status</td>
                  <td width="216">Quantity</td>
                  <td width="59">Purchase date</td>
                  <td width="85">Company</td>
                  <td width="85">Reference</td>

                </tr>
                <tr>
                    <td><input type="text" id="itemcode0" name="itemcode" onchange="filldata(this);"></td>
                  <td><input type="text" id="itemname0" name="itemname"></td>
                  <td><input type="text" id="status0" name="status"></td>
                  <td><input type="text" id="qty0" name="qty"></td>
                  <td><input type="text" id="pdate0" name="pdate"></td>
                  <td><input type="text" id="company0" name="company"></td>
                  <td><input type="text" id="ref0" name="ref"></td>
                </tr>
              </table></td>
              </tr>
            <tr>
            <td colspan="4"><table width="765" border="0">
              <tr align="center">
                  <td width="190"><input type="button" name="button" value="Submit"  onclick="validateFormOnSubmit1(form1);"/></td>
                  <td width="163"><input type="button" name="button12" value="ADD MORE" onclick="addMore();"/></td>
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
