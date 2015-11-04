<%-- 
    Document   : transfer_item
    Created on : May 10, 2010, 9:48:34 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head>



        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plethora</title>


        <script type="text/javascript">




            function getXMLObject()  //XML OBJECT
            {
                var xmlHttp = false;
                try {
                    xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")  // For Old Microsoft Browsers
                }
                catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Microsoft.XMLHTTP")  // For Microsoft IE 6.0+
                    }
                    catch (e2) {
                        xmlHttp = false   // No Browser accepts the XMLHTTP Object then false
                    }
                }
                if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
                    xmlHttp = new XMLHttpRequest();        //For Mozilla, Opera Browsers
                }
                return xmlHttp;  // Mandatory Statement returning the ajax object created
            }

            var xmlhttp = new getXMLObject(); //xmlhttp holds the ajax object

            function ajaxFunction() {
                if(xmlhttp) {
                    
                    xmlhttp.open("GET","../GetTransItem",true); //getname will be the servlet name
                    xmlhttp.onreadystatechange  = handleServerResponse;
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(null); //Posting txtname to Servlet
                }
            }

            function handleServerResponse() {
                if (xmlhttp.readyState == 4) {
                    if(xmlhttp.status == 200) {
                        var res=xmlhttp.responseText;
                        var da=document.createTextNode(res);
                        var d=document.getElementById("textfield4");
                        d.appendChild(da);
                    }
                }
            }

            function getStatus(){
                if(xmlhttp) {
                    var textfield = document.getElementById("textfield");
                    xmlhttp.open("POST","../TransferItem",true); //getname will be the servlet name
                    xmlhttp.onreadystatechange  = handleServerResponse1;
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send("textfield="+textfield.value); //Posting txtname to Servlet
                }
            }

            function handleServerResponse1() {
                if (xmlhttp.readyState == 4) {
                    if(xmlhttp.status == 200) {
                       
                        var res=xmlhttp.responseText;
                        var subitem=new Array();
                        subitem=res.split(":");
                    
                        if(subitem[0]!="warn"){
                            alert(subitem[0])
                            document.getElementById("textfield").value="";
                        }

                        var da=document.createTextNode(subitem[1]);
                        var d=document.getElementById("status");
                        d.appendChild(da);
                        if(subitem[0]=="warn"){

var da1=document.createTextNode(subitem[2]);
                        var d1=document.getElementById("name");
                        d1.appendChild(da1);

                            var j=3;
                            for(var i=0;i<(subitem.length-3)/3;i++){
                                var tbody = document.getElementById("myTable").getElementsByTagName("TBODY")[0];
                                var row = document.createElement("TR")

                                var td1 = document.createElement("TD")
                                var label1 = document.createElement('label');
                                label1.id=j+"lb";
                                label1.textContent=subitem[j];
                                td1.appendChild(label1);
                            
                                var td2 = document.createElement("TD")
                                var label2 = document.createElement('label');
                                label2.id=j+1+"lb";
                                label2.textContent=subitem[j+1];
                                td2.appendChild(label2);

                                var td3 = document.createElement("TD")
                                var label3 = document.createElement('label');
                                label3.id=j+2+"lb";
                                label3.textContent=subitem[j+2];
                                td3.appendChild(label3);
                            
                                var td4 = document.createElement("TD")
                                var cb = document.createElement("input");
                                cb.type = "checkbox";
                                cb.id=i+"ch";
                                td4.appendChild(cb)

                                row.appendChild(td1);
                                row.appendChild(td2);
                                row.appendChild(td3);
                                row.appendChild(td4);
                                tbody.appendChild(row);
                                j=j+3;
                            }
                        }
                    }
                }
            }

            function Transfer(){
                
                if(xmlhttp) {

                    var textfield4=document.getElementById("textfield4");
                    var textfield=document.getElementById("textfield");
                    var status=document.getElementById("status");
                    var textfield2=document.getElementById("textfield2");
                    
                    var tabl=(document.getElementById("myTable").rows.length)-1;
                    var cb="";
                    for(var i=0;i<tabl;i++){
                        var cb1=document.getElementById(i+"ch").checked;
                        cb=cb+cb1+":";
                    }
                    var labl=((document.getElementById("myTable").rows.length)-1)*3;
                    var lb="";
                    for(var j=3;j<labl+3;j++){
                        var lb1=document.getElementById(j+"lb").textContent;
                        lb=lb+lb1+":";
                    }
                             
                    var params="textfield4="+textfield4.textContent+"&textfield="+textfield.value+"&status="+status.value+"&textfield2="+textfield2.value+"&cb="+cb+"&lb="+lb;

                    xmlhttp.open("POST","../TransItem",true); //getname will be the servlet name
                    xmlhttp.onreadystatechange  = handleServerResponse2;
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(params); //Posting txtname to Servlet
                }
            }

            function handleServerResponse2() {
                if (xmlhttp.readyState == 4) {
                    if(xmlhttp.status == 200) {
                        var res=xmlhttp.responseText;
                        alert(res);
                        location.reload(true);
                    }
                }
            }

            function getName(){

                if(xmlhttp) {

                    var textfield2=document.getElementById("textfield2");
                    var params="textfield2="+textfield2.value;

                    xmlhttp.open("POST","../ShowName",true); //getname will be the servlet name
                    xmlhttp.onreadystatechange  = handleServerResponse3;
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(params); //Posting txtname to Servlet
                }
            }

            function handleServerResponse3() {
                if (xmlhttp.readyState == 4) {
                    if(xmlhttp.status == 200) {
                        var res=xmlhttp.responseText;
                        var name=new Array();
                        name=res.split(":");
                       
                       if(name[0]!="warn"){
                           alert(name[0]);
                           document.getElementById("borrower").textContent="";
                          // document.getElementById("borrower").style.background = 'Yellow';
                       }
                       else{
                       var da=document.createTextNode(name[1]);
                        var d=document.getElementById("borrower");
                        d.appendChild(da);
                       }
                }
                    }
                }
       
            function Confirm(){
                if(confirm('Are you sure want to transfer this item?')){
                    Transfer();
                }
            }

            function validateFormOnSubmit(theForm){
                var reason = "";
                reason += validateEmpty(theForm.textfield," Enter an Item Code");
                reason += validateEmpty(theForm.textfield2," Enter a Borrower");

                if (reason != "") {
                    alert("Some mandatory fields are empty.Please\n" + reason);
                }
                else
                    Confirm();
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

            function resetForm(){

                document.getElementById("myForm").reset();
                var otable=document.getElementById("myTable");
                while(otable.rows.length>1)
                    otable.deleteRow(otable.rows.length-1);
                document.getElementById("status").textContent="";
                document.getElementById("name").textContent="";
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
            

        </script>



        <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
        <meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
        <meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">

    <meta http-equiv="cache-control" content="max-age=0, must-revalidate, no-cache, no-store, private">
                        <meta http-equiv="expires" content="-1">
                        <meta http-equiv="pragma" content="no-cache">


    </head><body onload="ajaxFunction();disableEnterKey()">
        <div id="hom_hea"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="85" width="1290"></div>

        <div id="con_fja">
            <div id="hom_fja">The Inventory Management System </div>
        </div>
        <div id="men"><a href="request_item.jsp">request item</a><a href="receive_item.jsp">receive item</a><a href="transfer_item.jsp">lend item</a><a href="get_lend_item.jsp">Get lend  item</a><a href="report_damage.jsp">Change status </a><a href="edit_profile.jsp">edit profile</a><a href="get_item_details.jsp">Item details</a></div>
        <div id="pri">
            <div id="con_int">
                <div id="content">
                    <!-- end header -->
                    <div class="post">
                        <table width="970" height="21" border="0" cellpadding="1" cellspacing="1">
                            <tr>
                                <td width="892">&nbsp;</td>
                                <td width="44"><a href="../logout">Logout</a></td>
                                <td width="9">&nbsp;</td>
                                <td width="12">&nbsp;</td>
                            </tr>
                        </table>
                        <h2>Lend Item </h2>
                        <div class="storycontent">
                            <form name="myForm" id="myForm">
                                <table width="599" border="0">
                                    <tr>
                                        <td>Lend No: </td>
                                        <td colspan="2"><label name="textfield4" id="textfield4" ></label></td>
                                    </tr>
                                    <tr>
                                        <td width="158">Item Code : </td>
                                        <td colspan="2"><label>
                                                <input type="text" name="textfield" id="textfield" onchange="getStatus()"/>
                                            </label></td>
                                    </tr>
                                    <tr>
                                        <td>Item Name: </td>
                                        <td colspan="2"><label name="name" id="name" ></label></td>
                                    </tr>
                                    <tr>
                                        <td>Item Status: </td>
                                        <td colspan="2"><label name="status" id="status" ></label></td>
                                    </tr>
                                    <tr>
                                        <td>Borrower: </td>
                                        <td colspan="2"><label>
                                                <input type="text" name="textfield2" id="textfield2" onchange="getName()"/>
                                            </label></td>
                                    </tr>
                                    <tr>
                                        <td>Borrower's Name: </td>
                                        <td colspan="2"><label name="borrower" id="borrower" ></label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3"><table id="myTable" width="500" border="1">
                                                <tbody>
                                                    <tr>
                                                        <td width="85">Item Code </td>
                                                        <td width="89">Item Name </td>
                                                        <td width="184">Item Status </td>
                                                        <td width="124">Available</td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td><input type="button" name="Submit2" value="Cancel" onclick="resetForm()" /></td>
                                        <td width="96"><label>
                                                <input type="button" name="Submit" value="Transfer" onclick="validateFormOnSubmit(myForm)"/>
                                            </label></td>
                                        <td width="331"><input type="button" name="Submit3" value="Print" /></td>
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