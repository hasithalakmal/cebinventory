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
_global.va="he"
function formLoad(){
    
    var url="../approveReg?parameter=load";
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
                var cost_centre = document.createTextNode(temp1[0]);
                var c1 = document.createElement("td");
                c1.appendChild(cost_centre);
                row.appendChild(c1);
                var sec_no = document.createTextNode(temp1[1]);
                var c2 = document.createElement("td");
                c2.appendChild(sec_no);
                row.appendChild(c2);
                var username = document.createTextNode(temp1[2]);
                var c3 = document.createElement("td");
                c3.appendChild(username);
                row.appendChild(c3);
                var fir_name = document.createTextNode(temp1[3]);
                var c4 = document.createElement("td");
                c4.appendChild(fir_name);
                row.appendChild(c4);
                var la_name = document.createTextNode(temp1[4]);
                var c5 = document.createElement("td");
                c5.appendChild(la_name);
                row.appendChild(c5);
                var email = document.createTextNode(temp1[5]);
                var c6 = document.createElement("td");
                c6.appendChild(email);
                row.appendChild(c6);

                var sel=document.createElement("select");
                sel.setAttribute("id", "name");
                sel.setAttribute("onchange", "OnChange(this.value)");

                var opt= document.createElement("option");
                sel.options.add(opt);
                opt.text="Normal user";
                opt.value="Normal user";
                var opt= document.createElement("option");
                sel.options.add(opt);
                opt.text="Supervisor";
                opt.value="Supervisor";
                var opt= document.createElement("option");
                sel.options.add(opt);
                opt.text="Manager";
                opt.value="Manager";

                var role="error";
                var c19 = document.createElement("td");
                c19.appendChild(sel);
                row.appendChild(c19);
                var c8 = document.createElement("input");
                c8.setAttribute("type", "submit");
                c8.setAttribute("name", "Y_"+temp1[2]);
                c8.setAttribute("value", "Yes");
                c8.setAttribute("onclick", "if(confirm('Are you sure you want to approve the user?')){role(document.getElementById('name').value);update(this);}");
                
                var c9 = document.createElement("td");
                c9.appendChild(c8);
                row.appendChild(c9);
                var c10 = document.createElement("input");
                c10.setAttribute("type", "submit");
                c10.setAttribute("name", "N_"+temp1[2]);
                c10.setAttribute("value", "No");
                c10.setAttribute("onclick", "if(confirm('Are you sure want to reject the request of user?')){role(document.getElementById('name').value);update(this)}");
                var c11 = document.createElement("td");
                c11.appendChild(c10);
                row.appendChild(c11);
                table.appendChild(row);
            }
        }
    }
    xmlHttp.send(url);
}

function role(str){
    va=str;
    return str;
}

function update(button){
    var param = button.name
    var tmp = new Array();
    tmp = param.split("_")
    var url="../approveReg?parameter=approve&type="+tmp[0]+"&userName="+tmp[1]+"&userRole="+va;
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
            location.reload(true);
        }
    }
    xmlHttp.send(url);
}


</script>
</head>

<body onload="formLoad()">

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
      <h2>Approve Registration </h2>
      <div class="storycontent">
       <table id="t1" BORDER='1' bordercolor='#000000' WIDTH='700'>
            <tr>
                <td width='95' bordercolor='#000000' bgcolor='#696969'><font color='white'>Cost centre No</font></td>
                <td width='187' bordercolor='#000000' bgcolor='#696969'><font color='white'>Section No</font></td>
                <td width='191' bordercolor='#000000' bgcolor='#696969'><font color='white'>Username</font></td>
                <td width='71' bordercolor='#000000' bgcolor='#696969'><font color='white'>FirstName</font></td>
                <td width='95' bordercolor='#000000' bgcolor='#696969'><font color='white'>Last Name</font></td>
                <td width='95' bordercolor='#000000' bgcolor='#696969'><font color='white'>Email</font></td>
                <td width='95' bordercolor='#000000' bgcolor='#696969'><font color='white'>User role</font></td>
                <td colspan='2' width='200' bordercolor='#000000' bgcolor='#696969'><font color='white'>Approve</font></td>
            </tr>
       </table>
       
      </div>
    </div>
    <!-- begin footer -->
  </div>
</div>
</div>
</body></html>