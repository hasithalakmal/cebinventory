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

function viewItemlist(){

    var cat=document.getElementById("cat").value;
    var item=document.getElementById("item").value;
    var myWindow=window.open('popup1.jsp?cat='+cat+"&item="+item,'windowRef','width=600,height=300');
    if (!myWindow.opener) myWindow.opener =self;



}

function genItemcode(){

    var cat=document.getElementById("cat").value;
    var item=document.getElementById("item").value;
    var strurl="../genStockItemCode?cat="+cat+"&item="+item;




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
  reason += validateEmpty(theForm.vendor,"please enter vendor");
  reason += validateEmpty(theForm.location,"please enter location");
  reason += validateEmpty(theForm.textfield223,"please Enter remarks");
  reason += validateEmpty(theForm.textfield25,"please Enter depreciation rate");
  reason +=validateEmpty(document.getElementById("safetystock"),"Please Enter value for safety stock");
  reason +=validateEmpty(document.getElementById("reorderlevel"),"Please Enter value for reorder level");
  reason +=validateEmpty(document.getElementById("maximumstock"),"Please Enter value for maximum stock");
  reason +=validateEmpty(document.getElementById("abc"), "Please Select ABC");
  reason +=validateEmpty(document.getElementById("critical"),"Please Enter critical or not");
  reason += validateEmpty(theForm.expiry,"please enter expiry date");
  reason += validateEmpty(theForm.sstart,"please enter service start date");
  reason += validateEmpty(theForm.send,"please enter service end date");
  reason += validateEmpty(theForm.send,"please enter lead time");
  


  if (reason != "") {
    alert("Some fields need correction:\n" + reason);
    return false;
  }
  else
       submStockItem(theForm);
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

function submStockItem(form){

       // document.write(form);
    var cate=form.select2.value;
    var type=form.select3.value;
    var itmcode=form.textfield.value;
    var namedes=form.textfield2.value;
    var unit=form.unit.value;
    var price=form.textfield22.value;
    var value=form.textfield222.value;
    var vendor=form.vendor.value;
    var location1=form.location.value;
    var remarks=form.textfield223.value;
    var depreciate=form.textfield25.value;
    var image=document.getElementById("myimage").value;
    var st=document.getElementById("safetystock").value;
    var rol=document.getElementById("reorderlevel").value;
    var ms=document.getElementById("maximumstock").value;
    var abc=document.getElementById("abc").value;
    var critical=document.getElementById("critical").value;
    var warranty=document.getElementById("expiry").value;
    var sdate=document.getElementById("sstart").value;
    var edate=document.getElementById("send").value;
    var leadt=document.getElementById("leadt").value;

//document.write("isuru");

    var strurl="../submitStock?cat="+cate+"&type="+type+"&itemcode="+itmcode+"&namedescription="+namedes+"&unit="+unit+"&price="+price+"&value="+value+"&remarks="+remarks+"&depreciate="+depreciate+"&image="+image+"&safety="+st+"&rol="+rol+"&ms="+ms+"&abc="+abc+"&critical="+critical+"&warranty="+warranty+"&sdate="+sdate+"&edate="+edate+"&leadt="+leadt+"&vendor="+vendor+"&location="+location1;
   // document.write(strurl);


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
    //alert("submit data successfully");
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









function selectItem(){
    var url="../getStockItem?cat=";
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

var url = "../selectStockCat";

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
      <h2>Add Stock Item </h2>
      <div class="storycontent">
          <form name="addstock">
        <table width="335" border="0" cellpadding="1" cellspacing="1">
          <tr>
            <td width="151">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
            <td width="635" rowspan="17" id="image">&nbsp;</td>
          </tr>
          <tr>
            <td>Category: </td>
            <td colspan="2"><label>
            <select name="select2"  id="cat" onclick="selectCat();selectItem();cleartxt();"  onchange="selectItem();">
            </select>
              </label>
                <label></label></td>
          </tr>
          <tr>
            <td>Type: </td>
            <td colspan="2"><label>
             <select name="select3" id="item" onclick="cleartxt();">
             </select>
                    <input type="button" name="button1" value="Generate Item Code" onclick="genItemcode();"/>
                    <input type="button" name="button2" value="View Item List" onclick="viewItemlist();"/>
            </label></td>
          </tr>
          <tr>
            <td>Item Code: </td>
            <td colspan="2"><input name="textfield" type="text" id="itemcode"/></td>
          </tr>
          <tr>
            <td>Name/Description:</td>
            <td colspan="2"><label>
              <input name="textfield2" type="text" id="tf_name"/>
            </label></td>
          </tr>
          <tr>
            <td>Unit of Measure: </td>
            <td colspan="2"><label>
              <select name="unit" id="s_unitOfMeasure">
                  <option>Num</option>
                  <option>Kg</option>
                  <option>Pack</option>
                  <option>Meters</option>
                  <option>Liters</option>
              </select>
            </label></td>
          </tr>
          <tr>
            <td>Price:</td>
            <td colspan="2"><label>
              <input name="textfield22" type="text" id="tf_price" value="0"/>
            </label></td>
          </tr>
          <tr>
            <td>Value:</td>
            <td colspan="2"><input name="textfield222" type="text" id="tf_price2" value="0"/></td>
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
            <td colspan="2"><input type="text" name="textfield223" /></td>
          </tr>
          <tr>
            <td>Depreciation Rate:</td>
            <td colspan="2"><label>
                    <input name="textfield25" type="text" id="tf_depreciationRate"  value="0"/>
            </label></td>
          </tr>
          <tr>
            <td> Image: </td>
            <td width="72"><input type="file" name="datafile1" size="30" id="myimage" onblur="showimage(addstock);"></td>
            </tr>
            <tr>
            <td>Safety Stock:</td>
            <td colspan="2"><input type="text" id="safetystock" value="10"/></td>
          </tr>
          <tr>
          <td>Reorder Level:</td>
            <td colspan="2"><input type="text" id="reorderlevel" value="5"/></td>
          </tr>
          <tr>
          <td>Maximum Stock:</td>
            <td colspan="2"><input type="text" id="maximumstock" value="20"/></td>
          </tr>
          <tr>
          <td>ABC:</td>
          <td colspan="2"><select id="abc"><option>A</option><option>B</option><option>C</option></select></td>
          </tr>
          <tr>
          <td>Critical:</td>
          <td colspan="2"><select id="critical"><option>Yes</option><option>No</option></select></td>
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
            <td colspan="2"><label>
              <input type="button" name="buttonsubmit" value="Add Item" onclick="return validateFormOnSubmit(addstock);"/>
              </label>
                <label>
                <input type="button" name="button5" value="Print Bar Code" />
              </label></td>
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