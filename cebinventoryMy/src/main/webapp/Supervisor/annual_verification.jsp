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
  var count=0;
  var inc=0;
  var date;
  var tabc;
  var current=new Array();


function validateFormOnSubmit1(theForm){

  var reason = "";

    reason += validateEmpty(theForm.vno,"please Enter Verification number");
    reason += validateEmpty(theForm.owner,"please Enter owner");


   var d;
   for(d=0;d<tabc;d++){

        var tag1="cqty"+d;



            var cqty=document.getElementById(tag1);



            var message=validatetable(cqty,"Please Enter Avaialble Quantity");

            reason +=message;
            if(message!=""){

                break;
            }

   }

   var e;

  for(e=0;e<inc;e++){


       var tag1="itcqty"+e;



            var cqty=document.getElementById(tag1);



            var message=validatetable(cqty,"Please Enter Available Qty");

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
     submitverify();

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

function validatetable(aq,err){

    var error="";

    if (aq.value.length == 0) {
        aq.style.background = 'Yellow';
        error = err+".\n";
    }

   else {
        aq.style.background = 'White';


    }
    return error;


}



  function insertafter(newChild,refChild) {
 refChild.parentNode.insertBefore(newChild,refChild.nextSibling);
}


function autoset(mval){

        
        
    var iden=mval.id;
    if(iden.charAt(0)=='i'){

        var length=iden.length;
        var last_char=iden.charAt(length-1);
        var rqty=document.getElementById("itrqty"+last_char).value;
        document.getElementById("itcqty"+last_char).value=rqty;

  }
        else{
        var length=iden.length;
        var last_char=iden.charAt(length-1);
        var rqty=document.getElementById("rqty"+last_char).value;
        document.getElementById("cqty"+last_char).value=rqty;

        }


}
var seq;
function appendnext(myvalue){



        var rqty;
        var cqty;
        var iden=myvalue.id;

        if(iden.charAt(2)=='t'){


        var length=iden.length;
        var last_char=iden.charAt(length-1);
        rqty=document.getElementById("itrqty"+last_char).value;
        cqty=document.getElementById("itcqty"+last_char).value;

        }
        else{
        var length=iden.length;
        var last_char=iden.charAt(length-1);
        rqty=document.getElementById("rqty"+last_char).value;
        cqty=document.getElementById("cqty"+last_char).value;
        seq=last_char;
        
        }
        if(cqty==null | cqty==""){
            return false;
        }
        else if(parseFloat(rqty)>parseFloat(cqty)){

                    if(confirm("Are you sure remaining Items are Exist")){
                    var opt= document.createElement('tr');
                        opt.setAttribute("id", "txt"+inc);
                        opt.setAttribute("onchange", "appendnext(this);");
                        var tag1=document.createElement('td');
                        var ta1=document.createElement('input');
                        ta1.setAttribute("type", "text");
                        ta1.setAttribute("id", "itcode"+inc);
                        ta1.setAttribute("value", document.getElementById("itemcode"+seq).value);
                        tag1.appendChild(ta1);
                        var tag2=document.createElement('td');
                        var ta2=document.createElement('input');
                        ta2.setAttribute("type", "text");
                        ta2.setAttribute("id", "itstatus"+inc);
                        ta2.setAttribute("value", document.getElementById("status"+seq).value);
                        tag2.appendChild(ta2);
                        var tag3=document.createElement('td');
                        var ta3=document.createElement('input');
                        ta3.setAttribute("type", "text");
                        ta3.setAttribute("id", "itname"+inc);
                        ta3.setAttribute("value", document.getElementById("itemname"+seq).value);
                        tag3.appendChild(ta3);
                        var tag4=document.createElement('td');
                        var ta4=document.createElement('input');
                        ta4.setAttribute("type", "text");
                        ta4.setAttribute("id", "itremarks"+inc);
                        ta4.setAttribute("value", document.getElementById("remarks"+seq).value);
                        tag4.appendChild(ta4);
                        var tag5=document.createElement('td');
                        var ta5=document.createElement('input');
                        ta5.setAttribute("type", "text");
                        ta5.setAttribute("id", "itrqty"+inc);
                        ta5.setAttribute("value", parseFloat(rqty)-parseFloat(cqty));
                        tag5.appendChild(ta5);
                        var tag6=document.createElement('td');
                        var ta6=document.createElement('input');
                        ta6.setAttribute("type", "text");
                        ta6.setAttribute("id", "itcqty"+inc);
                        tag6.appendChild(ta6);
                        var tag7=document.createElement('td');
                        var ta7=document.createElement('input');
                        ta7.setAttribute("type", "checkbox");
                        ta7.setAttribute("id", "itcheckbox"+inc);
                        ta7.setAttribute("onclick", "autoset(this);");
                        tag7.appendChild(ta7);
                        var tag8=document.createElement('td');
                        var se=document.createElement('select');
                        se.setAttribute("id", "itse"+inc)
                        var op1=document.createElement('option');
                        se.options.add(op1);
                        op1.text="No Change";
                        var op2=document.createElement('option');
                        se.options.add(op2);
                        op2.text="Defective";
                        var op3=document.createElement('option');
                        se.options.add(op3);
                        op3.text="Damaged";
                        var op4=document.createElement('option');
                        se.options.add(op4);
                        op4.text="Obsolete";
                        tag8.appendChild(se);

                opt.appendChild(tag1);
                opt.appendChild(tag2);
                opt.appendChild(tag3);
                opt.appendChild(tag4);
                opt.appendChild(tag5);
                opt.appendChild(tag6);
                opt.appendChild(tag7);
                opt.appendChild(tag8);

                insertafter(opt,myvalue);
                inc+=1;
        }
        }
}
  function filltable(){
          
            if(count==0){
            var owner=document.getElementById("owner").value;
            var strURL="../fillTable?owner="+owner;
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
                        opt.setAttribute("onchange", "appendnext(this);")
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
                        ta3.setAttribute("id", "itemname"+b);
                        ta3.setAttribute("value", temp1[2]);
                        tag3.appendChild(ta3);
                        var tag4=document.createElement('td');
                        var ta4=document.createElement('input');
                        ta4.setAttribute("type", "text");
                        ta4.setAttribute("id", "remarks"+b);
                        ta4.setAttribute("value", temp1[3]);
                        tag4.appendChild(ta4);
                        var tag5=document.createElement('td');
                        var ta5=document.createElement('input');
                        ta5.setAttribute("type", "text");
                        ta5.setAttribute("id", "rqty"+b);
                        ta5.setAttribute("value", temp1[4]);
                        tag5.appendChild(ta5);
                        var tag6=document.createElement('td');
                        var ta6=document.createElement('input');
                        ta6.setAttribute("type", "text");
                        ta6.setAttribute("id", "cqty"+b);
                        tag6.appendChild(ta6);
                        var tag7=document.createElement('td');
                        var ta7=document.createElement('input');
                        ta7.setAttribute("type", "checkbox");
                        ta7.setAttribute("id", "checkbox"+b);
                        ta7.setAttribute("onclick", "autoset(this);")
                        tag7.appendChild(ta7);
                        var tag8=document.createElement('td');
                        var se=document.createElement('select');
                        se.setAttribute("id", "se"+b)
                        var op1=document.createElement('option');
                        se.options.add(op1);
                        op1.text="No Change";
                        var op2=document.createElement('option');
                        se.options.add(op2);
                        op2.text="Defective";
                        var op3=document.createElement('option');
                        se.options.add(op3);
                        op3.text="Damaged";
                        var op4=document.createElement('option');
                        se.options.add(op4);
                        op4.text="Obsolete";
                        tag8.appendChild(se);

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

function verifinum(){


var strurl="../verifiNum";

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
    document.getElementById("vno").value=str;
    var currentTime = new Date();
var month = currentTime.getMonth() + 1;
var day = currentTime.getDate();
var year = currentTime.getFullYear();
var str=year+"/"+month+"/"+day;
date=str;
}
}
xmlHttp.send(strurl);

}

function submitverify(){

    
    var vno=document.getElementById("vno").value;
    var owner=document.getElementById("owner").value;

    var url="../submitVerification?owner="+owner+"&vno="+vno+"&date="+date;
    var a=0;
    while(a<tabc){


                    var tag1="itemcode"+a;
                    var tag2="status"+a;
                    var tag3="itemname"+a;
                    var tag4="remarks"+a;
                    var tag5="rqty"+a;
                    var tag6="cqty"+a;
                    var tag7="se"+a;
                    url+="&itemcode"+a+"="+document.getElementById(tag1).value;
                    url+="&status"+a+"="+document.getElementById(tag2).value;
                    url+="&itemname"+a+"="+document.getElementById(tag3).value;
                    url+="&remarks"+a+"="+document.getElementById(tag4).value;
                    url+="&rqty"+a+"="+document.getElementById(tag5).value;
                    url+="&cqty"+a+"="+document.getElementById(tag6).value;
                    url+="&newstatus"+a+"="+document.getElementById(tag7).value;
                    a++;
        }
        var c=0;
        while(c<inc){

                    var tag1="itcode"+c;
                    var tag2="itstatus"+c;
                    var tag3="itname"+c;
                    var tag4="itremarks"+c;
                    var tag5="itrqty"+c;
                    var tag6="itcqty"+c;
                    var tag7="itse"+c;
                    url+="&itcode"+c+"="+document.getElementById(tag1).value;
                    url+="&itstatus"+c+"="+document.getElementById(tag2).value;
                    url+="&itname"+c+"="+document.getElementById(tag3).value;
                    url+="&itremarks"+c+"="+document.getElementById(tag4).value;
                    url+="&itrqty"+c+"="+document.getElementById(tag5).value;
                    url+="&itcqty"+c+"="+document.getElementById(tag6).value;
                    url+="&itnewstatus"+c+"="+document.getElementById(tag7).value;
                    c++;
        }

        var strurl=url+"&row="+a+"&subrow="+c;
       
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
    </head><body onload="verifinum();">
<div id="hom_hea"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="85" width="1290"></div>

<div id="con_fja">
<div id="hom_fja">The Inventory Management System</div>
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
      <h2>Annual Verification </h2>
      <div class="storycontent">
        <form id="form1" name="form1" method="post" action="">
          <table width="653" border="0">
            <tr>
              <td width="132">Verification Number: </td>
              <td width="511"><input type="text" name="vno" id="vno"/></td>
            </tr>
            <tr>
              <td>Owner:</td>
              <td><input type="text" name="owner" id="owner" /><input type="button" value="OK" onclick="filltable();" /></td>
            </tr>
            <tr>
                <td colspan="2"><table width="639" border="1" cellspacing="1" cellpadding="1" id="fillhere">
                <tr>
                  <td width="63">Item Code </td>
                  <td width="69">Item Status </td>
                  <td width="114">Item Name </td>
                  <td width="216">Remarks</td>
                  <td>Reserved QTY</td>
                  <td>Current QTY</td>
                  <td width="59">Available</td>
                  <td width="85">New Status </td>
                </tr>
              </table></td>
              </tr>
            
          </table>
          </form>
        <p>&nbsp;</p>
        <table width="640" border="0">
          <tr>
            <td width="135">&nbsp;</td>
            <td width="137"><input type="submit" name="button2" value="Submit" onclick="submitverify();"/></td>
            <td width="81">&nbsp;</td>
            <td width="269"><input type="submit" name="button3" value="Print" /></td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>
