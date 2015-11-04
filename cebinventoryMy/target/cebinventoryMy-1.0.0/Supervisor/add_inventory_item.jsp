<%-- 
    Document   : add_inventory_item
    Created on : May 10, 2010, 9:14:17 AM
    Author     : Isuru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Plethora</title>
  <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
  <meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
  <meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
<script language="javascript" type="text/javascript">
var c=0;


function cleartxt(){
    document.getElementById("itemcode").value="";
}


function showimage(form){



    var imagepath=document.getElementById('myimage').value;
    //document.write(imagepath);
    var tag=document.getElementById('image');
            var opt= document.createElement('img');
            opt.setAttribute('src',form.datafile1.value);
            tag.appendChild(opt);            
}




function validateFormOnSubmit(theForm){
var reason = "";

  reason += validateEmpty(theForm.select2,"please select category");
  reason += validateEmpty(theForm.select3,"please select Item type");
  reason += validateEmpty(theForm.textfield,"please generate Item code");
  reason += validateEmpty(theForm.textfield2,"please Enter name or desciption");
  reason += validateEmpty(theForm.textfield22,"please Enter price");
  reason += validateEmpty(theForm.textfield222,"please Enter value");
  reason += validateEmpty(theForm.textfield23,"please Enter serial number");
  reason += validateEmpty(theForm.vendor,"please Enter Vendor details");
  reason += validateEmpty(theForm.location,"please Enter location");
  reason += validateEmpty(theForm.textarea,"please Enter remarks");
   var cat=document.getElementById("com").value;
   if(cat=="Part of Composite Item")
  reason +=validateEmpty(theForm.select11,"please Enter Composite id");
  reason += validateEmpty(theForm.textfield25,"please Enter depreciation rate");
  reason += validateEmpty(theForm.expiry,"please enter expiry date");
  reason += validateEmpty(theForm.sstart,"please enter service start date");
  reason += validateEmpty(theForm.send,"please enter service end date");
  reason += validateEmpty(theForm.send,"please enter lead time");

        

  if (reason != "") {
    alert("Some fields need correction:\n" + reason);
    return false;
  }
  else
        submitem(theForm);
        printBarcode(theForm);

  return true;
}


function printBarcode(form){

    var url="../PrintBarcode?code="+form.textfield.value;
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



function submitem(form){


    var cate=form.select2.value;
    var type=form.select3.value;
    var itmcode=form.textfield.value;
    var namedes=form.textfield2.value;
    var price=form.textfield22.value;
    var value=form.textfield222.value;
    var snum=form.textfield23.value;
    var vendor=form.vendor.value;
    var location1=form.location.value;
    var remarks=form.textarea.value;
    var cat=document.getElementById("com").value;
    var citmcode;
   if(cat=="Part of Composite Item"){

    var str=form.select11.value;
    var temp = new Array();
    temp = str.split(":");
    citmcode=temp[0];
   }
   else
       citmcode="";
    var depreciate=form.textfield25.value;
    var critical=form.checkbox.checked;
    var capital=form.checkbox1.checked;
    var image=document.getElementById("myimage").value;
    var warranty=document.getElementById("expiry").value;
    var sdate=document.getElementById("sstart").value;
    var edate=document.getElementById("send").value;
    var leadt=document.getElementById("leadt").value;

    var strurl="../submitinventory?cat="+cate+"&type="+type+"&itemcode="+itmcode+"&namedescription="+namedes+"&price="+price+"&value="+value+"&snum="+snum+"&remarks="+remarks+"&composite="+cat+"&compositecode="+citmcode+"&depreciate="+depreciate+"&critical="+critical+"&capital="+capital+"&image="+image+"&warranty="+warranty+"&sdate="+sdate+"&edate="+edate+"&leadt="+leadt+"&vendor="+vendor+"&location="+location1;
   


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







function composite(form){

    var str=form.value;
    var vs=document.getElementById("comp").style.visibility;
    if(str=="Part of Composite Item"){
        if(vs=="hidden"){
            document.getElementById("comp").style.visibility="visible";
        }
    }
    else{
            if(vs=="visible")
            document.getElementById("comp").style.visibility="hidden";
    }

}
function gencode(){
    var cat=document.getElementById("cat").value;
    var item=document.getElementById("item").value;
    var strurl="../getcatItem?cat="+cat+"&item="+item;




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
    //document.write(str);
    document.getElementById("itemcode").value=str;

}
}
xmlHttp.send(strurl);



}

var sing=0;

function compositeid(){

    if(sing==1){
       return false;
    }
    var url="../compid";

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
    var a1=temp.length;
    //var iteml=document.getElementById("item").options.length=0;
    for(b=0;b<a1-1;b++){


         var opt= document.createElement("option");
         var tag=document.getElementById("comid");
         tag.options.add(opt);
         opt.text=temp[b];

    }
    sing=1;


}
}
xmlHttp.send(url);

}




function selectItem(){
    var url="../selectItem?cat=";
    var str=document.getElementById("cat").value;
    var strurl=url+str;

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
    var a1=temp.length;
    var iteml=document.getElementById("item").options.length=0;
    for(b=0;b<a1-1;b++){


         var opt= document.createElement("option");
         var tag=document.getElementById("item");
         tag.options.add(opt);
         opt.text=temp[b];

    }
    
    
}
}
xmlHttp.send(strurl);
}


function postRequest(strURL){

if(c==1){
        return false;
 }
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
    temp = str.split(":");
    var a1=temp.length;
    for(b=0;b<a1-1;b++){
         var opt= document.createElement("option");
         var tag=document.getElementById("cat");
         tag.options.add(opt);
         opt.text=temp[b];
    }
    
    c=1;
}
}
xmlHttp.send(strURL);
}



function selectCat(){

var url = "../selectCat";

postRequest(url);
               

}


</script>
    </head>
    <body>
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
      <h2>Add Inventory Item </h2>
      <div class="storycontent">
          <form name="addinv" action="">
        <table width="1008" border="0" cellpadding="1" cellspacing="1">
          <tr>
            <td width="151">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td width="635" rowspan="17" id="image">&nbsp;</td>
          </tr>
          <tr>
            <td>Category: </td>
            <td colspan="2">
            <select name="select2"  id="cat" onclick="selectCat();selectItem();cleartxt();"  onchange="selectItem();">
            </select>
            </td>
            </tr>
          <tr>
            <td>Item: </td>
            <td colspan="2">
             <select name="select3" id="item" onclick="cleartxt();">
             </select>
                <br>
              <input type="button" name="button" value="Generate Item Code" onclick="gencode();"/></td>
            </tr>
          <tr>
            <td>Item Code:</td>
            <td colspan="2"><input type="text" name="textfield" id="itemcode"/></td>
            </tr>
          <tr>
            <td>Item type: </td>
            <td colspan="2"><select name="select" id="com" onclick="composite(this);">
              <option>Part of Composite Item</option>
              <option>Composite Item</option>
              <option>Non Composite Item</option>
              </select></td>
            </tr>
          <tr>
            <td>Name/Description:</td>
            <td colspan="2"><input type="text" name="textfield2" /></td>
            </tr>
          <tr>
            <td>Price:</td>
            <td colspan="2"><input type="text" name="textfield22" value="0"/></td>
            </tr>
          <tr>
            <td>Value:</td>
            <td colspan="2"><input type="text" name="textfield222" /></td>
            </tr>
          <tr>
            <td>Serial Number: </td>
            <td colspan="2"><input type="text" name="textfield23" value="-----"/></td>
            </tr>
            <tr>
            <td>Vendor: </td>
            <td colspan="2"><input type="text" name="vendor" value="ABC"/></td>
            </tr>
            <tr>
            <td>Location: </td>
            <td colspan="2"><input type="text" name="location" value="--"/></td>
            </tr>
          <tr>
            <td>Remarks:</td>
            <td colspan="2"><textarea name="textarea"></textarea></td>
            </tr>
          <tr id="comp" style="visibility:visible">
            <td>Composite Item Code :</td>
            <td colspan="2"><select name="select11" id="comid" onclick="compositeid();"></select></td>
            </tr>
          <tr>
            <td>Depreciation Rate:</td>
            <td colspan="2"><input type="text" name="textfield25" value="0"/></td>
            </tr>
          
          <tr>
            <td> Image: </td>
            <td width="72"><input type="file" name="datafile1" size="30" id="myimage" onblur="showimage(addinv);"></td>
            </tr>
           <tr>
            <td>Critical Item: </td>
            <td colspan="2"><input type="checkbox" name="checkbox" value="1" /></td>
            </tr>
            <tr>
            <td>Capital Item: </td>
            <td colspan="2"><input type="checkbox" name="checkbox1" value="1" /></td>
            </tr>
            <tr>
            <td>Warranty Expiry date: </td>
            <td width="72"><input type="text" name="expiry" id="expiry" value="2010-5-20"></td>
            </tr>
           <tr>
            <td>Service Start Date:</td>
            <td colspan="2"><input type="text" name="sstart" id="sstart" value="2010-5-20" /></td>
            </tr>
            <tr>
            <td>Service End Date:</td>
            <td colspan="2"><input type="text" name="send" id="send" value="2010-5-20" /></td>
            </tr>
            <tr>
            <td>Lead Time:</td>
            <td colspan="2"><input type="text" name="leadt" id="leadt" value="10"/></td>
            </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input type="button" name="buttonsubmit" value="Add Item" onclick="return validateFormOnSubmit(addinv);"/>              <input type="button" name="button8" value="Print Bar Code" /></td>
            <td>&nbsp;</td>
          </tr>
        </table>
          </form>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </div>
    </div>
    </div>
</div>
</div>
</body></html>
