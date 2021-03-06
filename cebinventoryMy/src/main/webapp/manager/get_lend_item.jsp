<%--
    Document   : get_lend_item
    Created on : May 10, 2010, 9:46:38 AM
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

        function ajax() {
            if(xmlhttp) {

                var theDropDown = document.getElementById("select")
                        var numberOfOptions = theDropDown.options.length
                        for (i=0; i<numberOfOptions; i++) {
                            theDropDown.remove(i)
                        }

                xmlhttp.open("GET","../LendDetails",true); //getname will be the servlet name
                xmlhttp.onreadystatechange  = handle;
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(null); //Posting txtname to Servlet
            }
        }

        function handle() {
            if (xmlhttp.readyState == 4) {
                if(xmlhttp.status == 200) {
                    var res=xmlhttp.responseText;
                    var subitem=new Array();
                    subitem=res.split(":");

                    if(subitem[0]!=""){
                        alert(subitem[0])
                    }
                    for(var i=1;i<(subitem.length)-1;i++){
                        var opt = document.createElement("option");
                        opt.text=subitem[i]; opt.value = subitem[i];
                        document.getElementById("select").options.add(opt);
                    }
                }
            }
        }

        function fillForm() {
            if(xmlhttp) {
                var select = document.getElementById("select");
                xmlhttp.open("POST","../FillLendDetails",true); //getname will be the servlet name
                xmlhttp.onreadystatechange  = handleServerResponse1;
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send("select="+select.value); //Posting txtname to Servlet
            }
        }

        function handleServerResponse1() {
            if (xmlhttp.readyState == 4) {
                if(xmlhttp.status == 200) {
                    var res=xmlhttp.responseText;
                    var arr=new Array();
                    arr=res.split(":");
                    var j=1;
                    var k=0;

                    document.getElementById("textfield").value="";
                    document.getElementById("textfield2").value="";
                    document.getElementById("textfield3").textContent="";
                    document.getElementById("name").textContent="";
                    var otable=document.getElementById("myTable");

                    while(otable.rows.length>1)
                        otable.deleteRow(otable.rows.length-1);
                    document.getElementById("textfield2").textContent=arr[2];
                      
                    if(arr.length==5){
                        document.getElementById("textfield").textContent=arr[0];
                        var da=document.createTextNode(arr[1]);
                        var d=document.getElementById("textfield3");
                        d.appendChild(da);

                        var da1=document.createTextNode(arr[4]);
                        var d1=document.getElementById("name");
                        d1.appendChild(da1);
                    }

                    for(var i=0;i<arr.length;i++){

                        if(arr[i]=="Composite Item"){
                            document.getElementById("textfield").textContent=arr[i-3];
                            var da=document.createTextNode(arr[i-2]);
                            var d=document.getElementById("textfield3");
                            d.appendChild(da);

                            var da1=document.createTextNode(arr[i+1]);
                            var d1=document.getElementById("name");
                            d1.appendChild(da1);
                        }

                        if(arr[i]=="Part of Composite Item" && arr.length!=5){

                            var tbody = document.getElementById("myTable").getElementsByTagName("TBODY")[0];
                            var row = document.createElement("TR")
                            var td1 = document.createElement("TD")
                            var label1 = document.createElement('label');
                            label1.id=j+"lb";
                            label1.textContent=arr[i-3];
                            td1.appendChild(label1);

                            var td2 = document.createElement("TD")
                            var label2 = document.createElement('label');
                            label2.id=j+1+"lb";
                            label2.textContent=arr[i-2];
                            td2.appendChild(label2);

                            var td3 = document.createElement("TD")
                            var label3 = document.createElement('label');
                            label3.id=j+2+"lb";
                            label3.textContent=arr[i+1];
                            td3.appendChild(label3);

                            var td4 = document.createElement("TD")
                            var cb = document.createElement("input");
                            cb.type = "checkbox";
                            cb.id=k+"ch";
                            td4.appendChild(cb)

                            row.appendChild(td1);
                            row.appendChild(td2);
                            row.appendChild(td3);
                            row.appendChild(td4);
                            tbody.appendChild(row);
                            j=j+3;
                            k=k+1;
                        }
                    }
                }
            }
        }

        function retItem(){
            if(xmlhttp) {

                var select=document.getElementById("select");
                var textfield=document.getElementById("textfield");
                var textfield3=document.getElementById("textfield3");
                var textfield2=document.getElementById("textfield2");

                var tabl=(document.getElementById("myTable").rows.length)-1;
                var cb="";
                for(var i=0;i<tabl;i++){
                    var cb1=document.getElementById(i+"ch").checked;
                    cb=cb+cb1+":";
                }
                var labl=((document.getElementById("myTable").rows.length)-1)*3;
                var lb="";
                for(var j=1;j<labl+1;j++){
                    var lb1=document.getElementById(j+"lb").textContent;
                    lb=lb+lb1+":";
                }

                var params="select="+select.value+"&textfield="+textfield.textContent+"&textfield3="+textfield3.textContent+"&textfield2="+textfield2.textContent+"&cb="+cb+"&lb="+lb;

                xmlhttp.open("POST","../ReturnItem",true); //getname will be the servlet name
                xmlhttp.onreadystatechange  = handle1;
                xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xmlhttp.send(params); //Posting txtname to Servlet
            }
        }

        function handle1() {
            if (xmlhttp.readyState == 4) {
                if(xmlhttp.status == 200) {
                    var res=xmlhttp.responseText;
                        
                    alert(res)
                    resetForm()
                    ajax()
                }
            }
        }
        function Confirm(){

            if(confirm('Are you sure want to get back these items?')){
                retItem();
            }
        }

        function resetForm(){

            document.getElementById("myForm").reset();
            var otable=document.getElementById("myTable");
            while(otable.rows.length>1)
                otable.deleteRow(otable.rows.length-1);
            document.getElementById("textfield").textContent="";
            document.getElementById("textfield2").textContent="";
            document.getElementById("textfield3").textContent="";
            document.getElementById("name").textContent="";
            var theDropDown = document.getElementById("select")
                        var numberOfOptions = theDropDown.options.length
                        for (i=0; i<numberOfOptions; i++) {
                            theDropDown.remove(i)
                        }
        }


        </script>



        <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
        <meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
        <meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">

        <meta http-equiv="cache-control" content="max-age=0, must-revalidate, no-cache, no-store, private">
                        <meta http-equiv="expires" content="-1">
                        <meta http-equiv="pragma" content="no-cache">


    </head><body onload="ajax();">
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
                        <h2>Get Lend Item </h2>
                        <div class="storycontent">
                            <form name="myForm" id="myForm">
                                <table width="599" border="0">
                                    <tr>
                                        <td>Lend No: </td>
                                        <td colspan="2"><select name="select" id="select" onclick="fillForm();">

                                            </select> </td>
                                    </tr>
                                    <tr>
                                        <td width="158">Item Code : </td>
                                        <td colspan="2"><label name="textfield" id="textfield"  ></label></td>
                                    </tr>
                                    <tr>
                                        <td>Item Name: </td>
                                        <td colspan="2"><label name="name" id="name" ></label></td>
                                    </tr>
                                    <tr>
                                        <td>Item Status: </td>

                                        <td colspan="2"><label name="textfield3" id="textfield3"  ></label></td>
                                    </tr>
                                    <tr>
                                        <td>Borrower: </td>
                                        <td colspan="2"><label name="textfield2" id="textfield2"  ></label></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3"><table id="myTable" width="500" border="1">
                                                <tbody>
                                                    <tr>
                                                        <td width="85">Item Code </td>
                                                        <td width="89">Item Status </td>
                                                        <td width="184">Item Name </td>
                                                        <td width="124">Available</td>
                                                    </tr>
                                                </tbody>


                                            </table></td>
                                    </tr>
                                    <tr>
                                        <td><input type="button" name="Submit2" value="Cancel" onclick="resetForm()" /></td>
                                        <td width="96"><label>
                                                <input type="button" name="Submit" value="Transfer" onclick="Confirm()"  />
                                            </label></td>
                                        <td width="331"><input type="submit" name="Submit3" value="Print" /></td>
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
