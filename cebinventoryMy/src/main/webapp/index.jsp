<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>



        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
            <title>Plethora</title>


            <script type="text/javascript">
            function validateFormOnSubmitlogin(form){

                var reason="";
                reason+=validateEmpty(form.textfield,"Please Enter username");

                if (reason !="") {
                    alert("The following corrections need to be done :\n" + reason);
                    return false;
                }

            }
            function clearFieldColors(form){
                form.textfield.style.background = 'White';
                form.textfield2.style.background = 'White';
               // form.tf_reTypePassword1.style.background = 'White';
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

                function ajaxFunctionLogin() {

                    if(xmlhttp) {

                        var textfield=document.getElementById("textfield");
                        var textfield2=document.getElementById("textfield2");

                        var params="textfield="+textfield.value+"&textfield2="+textfield2.value;

                        xmlhttp.open("POST","Log",true); //getname will be the servlet name
                        xmlhttp.onreadystatechange  = handleServerResponseLogin;
                        xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                        xmlhttp.send(params); //Posting txtname to Servlet
                    }
                }

                function handleServerResponseLogin() {
                    if (xmlhttp.readyState == 4) {
                        if(xmlhttp.status == 200) {
                            var res=xmlhttp.responseText;
                            var redirect=new Array();
                            redirect=res.split(":");

                            if(redirect[0]=="warn"){
                                window.location=redirect[1];
                            }
                            else{
                                alert(redirect[0]);
                                var d=document.getElementById("warn1").textContent="";
                                var textfield=document.getElementById("textfield").value="";
                                var textfield2=document.getElementById("textfield2").value="";

                            }
                        }
                    }
                }

            </script>

            <link href="files/styles.css" media="screen" rel="stylesheet" type="text/css">
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
                            <div id="hom_hea"><img src="files/header.jpg" alt="Medical" title="Plethora- Intentory management System." height="85" width="1290"></div>

                            <div id="con_fja">
                                <div id="hom_fja"> The Inventory Management System </div>
                            </div>
                            <div id="pri">
                                <div id="con_int">
                                    <div id="content">
                                        <!-- end header -->
                                        <div class="post">
                                            <h2>Login  </h2>
                                            <div class="storycontent">
                                                <form id="form1" method="" >
                                                    <p>&nbsp;</p>
                                                    <table align="left" width="258" border="0">
                                                        <tr>
                                                            <td width="74">Username: </td>
                                                            <td width="174" colspan="2"><input type="text" name="textfield" id="textfield" /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Password:</td>
                                                            <td colspan="2"><input type="password" name="textfield2" id="textfield2"/></td>
                                                        </tr>
                                                        <tr>
                                                            <td>&nbsp;</td>
                                                            <td width="25"><input name="b_login" type="button" id="b_login" value="Login" onclick="ajaxFunctionLogin();" /></td>
                                                            <td><label name="warn1" id="warn1" ></label></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="3">Click <a href="login/register.jsp">here</a> to Register </td>
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