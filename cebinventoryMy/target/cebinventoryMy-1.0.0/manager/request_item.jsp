<%-- 
    Document   : request_item
    Created on : May 10, 2010, 9:47:59 AM
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
                    xmlhttp.open("GET","../GetReqItem",true); //getname will be the servlet name
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
                        var d=document.getElementById("textfield3");
                        d.appendChild(da);
                    }
                }
            }

            function Request() {
                if(xmlhttp) {
                  
                    var textfield3=document.getElementById("textfield3");
                    var textarea2=document.getElementById("textarea2");
                    var textfield2=document.getElementById("textfield2");
                    var textarea=document.getElementById("textarea");

                    var params="textfield3="+textfield3.textContent+"&textarea2="+textarea2.value+"&textfield2="+textfield2.value+"&textarea="+textarea.value;

                    if(textarea2.value.length==0 || textfield2.value.length==0){
                        alert("Some mandatory fields are empty. Please fill the empty fields");
                    }
                    else{
                        xmlhttp.open("POST","../RequestItem",true); //getname will be the servlet name
                        xmlhttp.onreadystatechange  = handleServerResponse1;
                        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xmlhttp.send(params); //Posting txtname to Servlet
                    }
                }
            }

            function handleServerResponse1() {
                if (xmlhttp.readyState == 4) {
                    if(xmlhttp.status == 200) {
                        
                        var res=xmlhttp.responseText;
                        alert(res);
                        resetForm();
                        document.getElementById("textfield3").textContent="";
                        ajaxFunction();
                    }
                }
            }

            function resetForm(){
                document.getElementById("myForm").reset();
            }

            function Confirm(){

                if(confirm('Are you sure want to request this item?')){
                    Request()
                }
            }

            function validateFormOnSubmit(theForm){
                var reason = "";

                reason += validateEmpty(theForm.textarea2,"please enter a Required Item");
                reason += validateEmpty(theForm.textfield2,"please enter a Quantity");

                if (reason != "") {
                    alert("Some mandatory fields are empty.\n" + reason);
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


        </script>






        <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
        <meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
        <meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">

    <meta http-equiv="cache-control" content="max-age=0, must-revalidate, no-cache, no-store, private">
                        <meta http-equiv="expires" content="-1">
                        <meta http-equiv="pragma" content="no-cache">


    </head><body onload="ajaxFunction()">
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
                        <h2>Request Item </h2>
                        <div class="storycontent">
                            <form name="myForm" id="myForm" action="">
                                <table width="275" border="0">
                                    <tr>
                                        <td>Request Number: </td>
                                        <td><label name="textfield3" id="textfield3" ></label></td>
                                    </tr>
                                    <tr>
                                        <td width="121">Item required: </td>
                                        <td width="144"><textarea name="textarea2" id="textarea2"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td>Quantity:</td>
                                        <td><input type="text" name="textfield2" id="textfield2" /></td>
                                    </tr>
                                    <tr>
                                        <td>Remarks:</td>
                                        <td><textarea name="textarea" id="textarea"></textarea></td>
                                    </tr>
                                    <tr>
                                        <td><input type="button" name="Submit2" value="Cancel" onclick="resetForm()"/></td>
                                        <td><input type="button" name="Submit" value="Request" onclick="validateFormOnSubmit(myForm)"/></td>
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