<%--
    Document   : report_damage
    Created on : May 10, 2010, 9:47:32 AM
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

            function ajaxFunction1() {
                if(xmlhttp) {
                    var txtname = document.getElementById("txtname");
                    xmlhttp.open("POST","../ReportDamage",true); //getname will be the servlet name
                    xmlhttp.onreadystatechange  = handleServerResponse;
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send("txtname=" + txtname.value); //Posting txtname to Servlet
                }
            }

            function handleServerResponse() {
                if (xmlhttp.readyState == 4) {
                    if(xmlhttp.status == 200) {

                        var res=xmlhttp.responseText;
                        var status=new Array();
                        status=res.split(":");

                        if(status[0]!="warn"){
                            alert(status[0]);
                        }

                        for(var i=1;i<(status.length-1);i++){
                            var opt = document.createElement("option");
                            opt.text=status[i]; opt.value = status[i];
                            document.getElementById("select1").options.add(opt);
                        }
                    }
                }
            }

            function AddItem(){
                

                        var DropDown = document.getElementById("select").length=0
                var arr=new Array();
                var op=document.getElementById("select1").value;
                arr=op.split("->");

                if(arr[0]=="New"){
                    var opt = document.createElement("option");
                    var opt1 = document.createElement("option");
                    var opt2 = document.createElement("option");
                    var opt3 = document.createElement("option");

                    opt.text = arr[0]; opt.value = arr[0];
                    opt1.text="Damaged"; opt1.value = "Damaged";
                    opt2.text="Obsolete"; opt2.value="Obsolete";
                    opt3.text="Defective"; opt3.value="Defective";

                    document.getElementById("select").options.add(opt);
                    document.getElementById("select").options.add(opt1);
                    document.getElementById("select").options.add(opt2);
                    document.getElementById("select").options.add(opt3);
                }

                if(arr[0]=="Damaged"){

                    var opt = document.createElement("option");
                    var opt1 = document.createElement("option");
                    var opt2 = document.createElement("option");
                    var opt3 = document.createElement("option");

                    opt.text = arr[0]; opt.value = arr[0];
                    opt1.text="New"; opt1.value = "New";
                    opt2.text="Obsolete"; opt2.value="Obsolete";
                    opt3.text="Defective"; opt3.value="Defective";

                    document.getElementById("select").options.add(opt);
                    document.getElementById("select").options.add(opt1);
                    document.getElementById("select").options.add(opt2);
                    document.getElementById("select").options.add(opt3);
                }
                if(arr[0]=="Obsolete"){

                    var opt = document.createElement("option");
                    var opt1 = document.createElement("option");
                    var opt2 = document.createElement("option");
                    var opt3 = document.createElement("option");

                    opt.text = arr[0]; opt.value = arr[0];
                    opt1.text="New"; opt1.value = "New";
                    opt2.text="Damaged"; opt2.value="Damaged";
                    opt3.text="Defective"; opt3.value="Defective";

                    document.getElementById("select").options.add(opt);
                    document.getElementById("select").options.add(opt1);
                    document.getElementById("select").options.add(opt2);
                    document.getElementById("select").options.add(opt3);
                }

                if(arr[0]=="Defective"){

                    var opt = document.createElement("option");
                    var opt1 = document.createElement("option");
                    var opt2 = document.createElement("option");
                    var opt3 = document.createElement("option");

                    opt.text = arr[0]; opt.value = arr[0];
                    opt1.text="New"; opt1.value = "New";
                    opt2.text="Obsolete"; opt2.value="Obsolete";
                    opt3.text="Damaged"; opt3.value="Damaged";

                    document.getElementById("select").options.add(opt);
                    document.getElementById("select").options.add(opt1);
                    document.getElementById("select").options.add(opt2);
                    document.getElementById("select").options.add(opt3);
                }

                if(arr[1]=="Lost"){
                    document.getElementById("checkbox1").defaultChecked=true;
                }
                if(arr[2]=="Unwanted"){
                    document.getElementById("checkbox2").defaultChecked=true;
                }
                if(arr[3]=="Auctioning"){
                    document.getElementById("checkbox3").defaultChecked=true;
                }

            }

            function Report() {
                if(xmlhttp) {

                    var txtname = document.getElementById("txtname");
                    var select1=document.getElementById("select1");
                    var select=document.getElementById("select");
                    var checkbox1=document.getElementById("checkbox1");
                    var checkbox2=document.getElementById("checkbox2");
                    var checkbox3=document.getElementById("checkbox3");
                    var ta_damageDescription=document.getElementById("ta_damageDescription");
                    var textfield2=document.getElementById("textfield2");
                    var textfield4=document.getElementById("textfield4");

                    var params="txtname="+txtname.value+"&select1="+select1.value+"&select="+select.value+"&checkbox1="+checkbox1.checked+"&checkbox2="+checkbox2.checked+"&checkbox3="+checkbox3.checked+"&ta_damageDescription="+ta_damageDescription.value+"&textfield2="+textfield2.value+"&textfield4="+textfield4.value;

                    xmlhttp.open("POST","../ChangeStatus",true); //getname will be the servlet name
                    xmlhttp.onreadystatechange  = handleServerResponse1;
                    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    xmlhttp.send(params); //Posting txtname to Servlet
                }
            }

            function handleServerResponse1() {
                if (xmlhttp.readyState == 4) {
                    if(xmlhttp.status == 200) {

                        var res=xmlhttp.responseText;
                        alert(res);
                        clearForm();
                        
                    }
                }
            }

            function Confirm1(){

                if(confirm('Are you sure want to report damage for this item?')){
                    Report()
                }
            }

            function validateFormOnSubmit1(){
                var reason = "";

                reason += validateEmpty(document.getElementById("txtname")," Enter an Item Code");


                reason += validateEmpty(document.getElementById("textfield4")," Enter Quantity");
                reason += validateEmpty(document.getElementById("textfield2")," Enter Cause for the change");

                if (reason != "") {
                    alert("Some mandatory fields are empty.Please\n" + reason);
                }
                else
                    Confirm1();
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

            function disableEnterKey(e)
            {
                var key;
                if(window.event)
                    key = window.event.keyCode; //IE
                else
                    key = e.which; //firefox

                return (key != 13);
            }

            function restrict(){
                if((document.getElementById("checkbox1").checked)&&(document.getElementById("checkbox2").checked)){
                    alert("You cannot mark the item both Lost and Unwanted")
                }
                else if((document.getElementById("checkbox1").checked)&&(document.getElementById("checkbox3").checked)){
                    alert("You cannot mark the item both Lost and Auctioning")
                }
                else if((document.getElementById("checkbox1").checked)&&(document.getElementById("checkbox2").checked)&&(document.getElementById("checkbox3").checked)){
                    alert("You cannot mark the item Lost, Unwanted and Auctioning")
                }
                else{
                    validateFormOnSubmit1()
                }

                function clearForm(){
                    document.getElementById("myForm").reset();
                    document.getElementById("select").length=0
                    document.getElementById("select1").length=0

                }

            }
        </script>





        <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
        <meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
        <meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
    </head>




    <body  onload="disableEnterKey()">
        <div id="hom_hea"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="85" width="1290"></div>

        <div id="con_fja">
            <div id="hom_fja">The Inventory Management System </div>
        </div>
        <div id="men"><a href="approve_damaged_items.jsp">Approve Item Status Changes</a><a href="confirm_opening_stock.jsp">Confirm Opening Stock</a><a href="approve_adjustments.jsp">Approve Item Adjustments</a><a href="add_to_auction.jsp">Approve Auctioning Items</a><a href="confirm_annual_verification.jsp">Approve Annual Verifications</a><a href="reports.jsp">Inquiries</a><a href="reports.jsp">Reports</a><a href="request_item.jsp">Request Item</a><a href="receive_item.jsp">Receive Item</a><a href="transfer_item.jsp">Lend Item</a><a href="get_lend_item.jsp">Get Lended Items</a><a href="report_damage.jsp">Change Item Status </a><a href="edit_profile.jsp">Edit Profile</a><a href="get_item_details.jsp">View Item Details</a></div>
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
                        <h2>Change Status  </h2>
                        <div class="storycontent">
                            <form name="myForm" id="myForm" action="">
                                <table width="327" border="0" cellpadding="1" cellspacing="1">

                                    <tr>
                                        <td width="148">&nbsp;</td>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td>Item Code: </td>
                                        <td colspan="2"><label>
                                                <input type="text"  name="txtname" id="txtname" onblur="ajaxFunction1();" />
                                            </label></td>
                                    </tr>


                                    <tr>

                                        <td>Item Status: </td>
                                        <td colspan="2"><select name="select1" id="select1"  >

                                            </select>  </td>
                                    </tr>
                                    <tr>
                                        <td>New Status: </td>
                                        <td colspan="2"><select name="select" id="select" onfocus="AddItem()">

                                            </select>            </td>
                                    </tr>
                                    <tr>
                                        <td>Lost: </td>
                                        <td colspan="2"><input type="checkbox" name="checkbox1" id="checkbox1"  /></td>
                                    </tr>
                                    <tr>
                                        <td>Unwanted: </td>
                                        <td colspan="2"><input type="checkbox" name="checkbox2" id="checkbox2" /></td>
                                    </tr>
                                    <tr>
                                        <td>Auctioning: </td>
                                        <td colspan="2"><input type="checkbox" name="checkbox3" id="checkbox3"  /></td>
                                    </tr>

                                    <tr>

                                        <td>Quantity: </td>
                                        <td colspan="2"><input type="text" name="textfield4" id="textfield4"  /></td>
                                    </tr>


                                    <tr>
                                        <td>Description: </td>
                                        <td colspan="2"><label>
                                                <textarea name="ta_damageDescription" id="ta_damageDescription"></textarea>
                                            </label>
                                            <label></label></td>
                                    </tr>
                                    <tr>
                                        <td>Cause for the change </td>
                                        <td colspan="2"><input type="text" name="textfield2" id="textfield2"/></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>

                                        <td width="75"><label><input name="b_cancel" type="button" id="b_cancel" value="Cancel" onclick="restrict();" />
                                            </label></td>
                                        <td width="54"><label>
                                                <input name="b_report" type="button" id="b_report" value="Report" onclick="restrict();" />
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