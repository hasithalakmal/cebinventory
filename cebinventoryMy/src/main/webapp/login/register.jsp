<%--
    Document   : index
    Created on : May 10, 2010, 9:14:31 AM
    Author     : Romesh
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<script language="javascript" type="text/javascript">
function validateFormOnSubmit(form){

    var reason = "";
    reason += validateEmpty(form.tf_firstName,"You can't leave First Name empty!");
    reason +=validateEmpty(form.tf_lastName,"You can't leave Last Name empty!");
    reason +=validateEmpty(form.tf_email,"You can't leave Email empty!");
    reason +=validateEmpty(form.tf_userName,"You can't leave username empty!");
    reason +=validateEmpty(form.tf_password,"You can't leave password empty!");
    reason +=validateEmpty(form.tf_reTypePassword,"You can't keep confirm password empty!");
    if(form.tf_password.value!=form.tf_reTypePassword.value){
        reason +="The password is not matching";
    }
    var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
    var address = form.tf_email.value;
    if(reg.test(address) == false) {
        reason +="Email is not a valid one!";
    }
    if (reason != "") {
        alert("The following corrections need to be done :\n" + reason);
        return false;
    }
    else{
        alert("User created succesfully");
        location.reload(true);
    }
}
function clearFieldColors(form){
    form.tf_password.style.background = 'White';
    form.tf_reTypePassword.style.background = 'White';
    form.tf_reTypePassword1.style.background = 'White';
}
function validateEmpty(field,err){
    var error = "";
    if (field.value.length == 0) {
        field.style.background = 'Yellow';
        error = err + "\n";
    } else {
        field.style.background = 'White';
    }
    return error;
}
function postRequest(strURL){
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
        temp = str.split(";");
        var a1=temp.length;
        var iteml=document.getElementById("coce").options.length=0;
        for(b=0;b<a1-1;b++){
            var opt= document.createElement("option");
            var tag=document.getElementById("coce");
            tag.options.add(opt);
            opt.text=temp[b];
        }
        c=1;
    }
    }
    xmlHttp.send(strURL);
}

function selectCoCe(){
    var url = "../selectCoCe";
    postRequest(url);
}

function selectSec(){
    var url="../selectSec?coce=";
    var str=document.getElementById("coce").value;
    var strurl=url+str;
    //alert(str);
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
        temp = str.split(";");
        var a1=temp.length;
        var iteml=document.getElementById("sec").options.length=0;
        for(b=0;b<a1-1;b++){
            var opt= document.createElement("option");
            var tag=document.getElementById("sec");
            tag.options.add(opt);
            opt.text=temp[b];

        }
    }
    }
    xmlHttp.send(strurl);
}






</script>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Plethora</title>
<link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
<meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
<meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-right: 125px;
}
-->
</style>
<meta http-equiv="cache-control" content="max-age=0, must-revalidate, no-cache, no-store, private">
<meta http-equiv="expires" content="-1">
<meta http-equiv="pragma" content="no-cache">
</head><body>
<div id="hom_hea"><img src="../files/header.jpg" alt="Medical" title="Plethora- Intentory management System." height="85" width="1290"></div>

<div id="con_fja">
<div id="hom_fja"> The Inventory Management System </div>
</div>
<div id="pri">
<div id="con_int">
  <div id="content">
    <!-- end header -->
    <div class="post">
      <table width="970" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="903">&nbsp;</td>
          <td width="31"><a href="../index.jsp">Back</a></td>
          <td width="9">&nbsp;</td>
          <td width="14">&nbsp;</td>
        </tr>
      </table>
      <h2>User Registration </h2>
      <div class="storycontent">
          <form id="form1" name="form1" method="post" action="../reg_user" >
          <table align="left" width="330" border="0" cellpadding="1" cellspacing="1">
            <tr>
              <td width="140">Cost Centre Number: </td>
              <td colspan="2">
                  <select name="select2"  id="coce" onclick="selectCoCe();selectSec();"  onchange="selectSec();"></select>
              </td>
            </tr>
            <tr>
              <td width="140">Section Number: </td>
              <td colspan="2">
                  <select name="select3" id="sec"></select>
              </td></tr>
            <tr>
              <td>First Name: </td>
              <td><label>
                <input name="tf_firstName" type="text" id="tf_firstName" />
                </label>
                  <label></label></td>
            </tr>
            <tr>
              <td>Last Name: </td>
              <td><label>
                <input name="tf_lastName" type="text" id="tf_lastName" />
              </label></td>
            </tr>
            <tr>
              <td>Email:</td>
              <td><label>
                <input name="tf_email" type="text" id="tf_email" />
                </label>
                  <label></label></td>
            </tr>
            <tr>
              <td>User Name: </td>
              <td><label>
                <input name="tf_userName" type="text" id="tf_userName" />
              </label></td>
            </tr>
            <tr>
              <td>Password:</td>
              <td><label>
                <input name="tf_password" type="password" id="tf_password" />
              </label></td>
            </tr>
            <tr>
              <td>Re-type Password: </td>
              <td><label>
                <input name="tf_reTypePassword" type="password" id="tf_reTypePassword" />
              </label></td>
            </tr>

            <tr>
              <td>&nbsp;</td>
              <td><label>
                <input name="b_editProfile" type="submit" id="b_editProfile" value="Register" onclick="return validateFormOnSubmit(form1)"/>
              </label></td>
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