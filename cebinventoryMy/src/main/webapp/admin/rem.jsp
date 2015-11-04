<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title>Plethora</title>
  <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css"/>

  <meta http-equiv="cache-control" content="max-age=0, must-revalidate, no-cache, no-store, private">
  <meta http-equiv="expires" content="-1">
  <meta http-equiv="pragma" content="no-cache">
  <script language="javascript" type="text/javascript">
_global.str="Transfer out";
_global.un="";
function validateFormOnSubmit(form,username,cause){

    var reason = "";
    reason += validateEmpty(form.tf_userID,"Please enter the username of the employee you want to remove");

    if (reason != "") {
        alert("The following corrections need to be done :\n" + reason);
        return false;
    }
    else{
        remove(username,cause);
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

function remove(username,cause){
    
    un=username;
    var url="../remove_user?parameter=remove&userName="+username+"&cause="+cause;
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
            var table = document.getElementById("t1");

            for(var i=0; i<temp.length-1; i++){
                var temp1 = new Array();
                temp1 = temp[i].split(";");
                var row = document.createElement("tr");
                var cost_id = document.createTextNode(temp1[0]);
                var c1 = document.createElement("td");
                c1.appendChild(cost_id);

                row.appendChild(c1);
                var section_id = document.createTextNode(temp1[1]);
                var c2 = document.createElement("td");
                c2.appendChild(section_id);
                row.appendChild(c2);
                var username = document.createTextNode(temp1[2]);
                var c3 = document.createElement("td");
                c3.appendChild(username);
                row.appendChild(c3);
                var itemcode = document.createTextNode(temp1[3]);
                var c4 = document.createElement("td");
                c4.appendChild(itemcode);
                row.appendChild(c4);
                var itemname = document.createTextNode(temp1[4]);
                var c8 = document.createElement("td");
                c8.appendChild(itemname);
                row.appendChild(c8);
                var uom = document.createTextNode(temp1[5]);
                var c5 = document.createElement("td");
                c5.appendChild(uom);
                row.appendChild(c5);
                var quantity = document.createTextNode(temp1[6]);
                var c6 = document.createElement("td");
                c6.appendChild(quantity);
                row.appendChild(c6);
                var quantity = document.createTextNode(temp1[7]);
                var c7 = document.createElement("td");
                c7.appendChild(quantity);
                row.appendChild(c7);

                table.appendChild(row);

            }
            document.getElementById("l1").appendChild(document.createTextNode(owner));
        }

    }
    xmlHttp.send(url);
}


function returnItem(type){
    var url="../remove_user?parameter=return&type="+type+"&userName="+un;
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
            //alert(str);
            alert("Items are succesfully transferred to the Supervisor");
            location.reload(true);
        }
    }
    xmlHttp.send(url);
}


</script>
</head>
    <body>
<div id="hom_hea"><img src="../files/header.jpg" alt="Plethora" title="Plethora - The Inventory Management System" height="86" width="1290"/></div>
<div id="con_fja">
<div id="hom_fja">The Inventory Management System </div>
</div>
<div id="men"><a href="approve_reg.jsp">Approve user registration </a><a href="adduser.jsp">add user </a><a href="rem.jsp">remove user </a><a href="edit_profile.jsp">edit profile </a></div>
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
      <h2>Remove User</h2>
      <div class="storycontent">
        <form id="f1">
        <table  border="0">
            <tr>
              <td>Owner's Username:</td>
              <td><label>
                <input name="tf_userID" type="text" id="tf_userID" />
              </label></td>
            </tr>
            <tr>
              <td>Cause for removal: </td>
            <td colspan="2"><select name="select" id="com">
              <option>Transfer out</option>
              <option>Intredicted</option>
              <option>Retired</option>
              <option>Dead</option>
              </select></td>
            </tr>
          <tr>
              <td>&nbsp;</td>
            <td ><input type="button" name="Search" value="Remove user and View Item list" onclick="if(confirm('Are you sure you want to change the status of the user?'))remove(tf_userID.value,com.value)"  /> </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
        </form>
        <form id="f2">
        <table>

          <tr>
            <td>&nbsp;</td>
          </tr>
        </table>
        <table id="t1" width="811" border="1" cellspacing="1" cellpadding="1">
           <tr>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Cost Centre Number</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Section Number</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Username</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Code</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Item Name</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Unit of measure</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Quantity</font></td>
                <td bordercolor="#000000" bgcolor="#696969"><font color='white'>Status</font></td>

           </tr>
        </table>
            <p>&nbsp;</p>
            <table>
                <tr>
                    <td width="101">Return items :</td>
                    <td width="24">&nbsp;</td>
                  <td width="72"><input type="submit" name="approve" id="approve" value="Yes" onclick="if(confirm('Are you sure you want to return all the items?'))returnItem('Y')" /></td>
                    <td width="37">&nbsp;</td>
                    <td width="79"><input type="submit" name="reject" id="reject" value="No" onClick="if(confirm('Are you sure you don\'t want to return all the items?'))returnItem('N')" /></td>
                  <td width="179"><input name="Print" type="submit" id="Print" value="Print"></td>
                </tr>
            </table>
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