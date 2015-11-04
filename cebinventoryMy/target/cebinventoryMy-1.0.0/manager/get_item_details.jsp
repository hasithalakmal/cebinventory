<%-- 
    Document   : get_item_details
    Created on : May 10, 2010, 9:46:08 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"><head>



        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Plethora</title>
        <link href="../files/styles.css" media="screen" rel="stylesheet" type="text/css">
        <meta name="description" content="Medical - Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">
        <meta name="keywords" content="Medical :. Medical is a multi-user, highly scalable, centralized Electronic Medical Record (EMR) for openERP.">


        <meta http-equiv="cache-control" content="max-age=0, must-revalidate, no-cache, no-store, private">
                        <meta http-equiv="expires" content="-1">
                        <meta http-equiv="pragma" content="no-cache">


    </head><body>
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
                        <h2>Item Details </h2>
                        <div class="storycontent">
                            <jsp:include page="/ItemDetails" flush="true"/>

                            <p>&nbsp;</p>
                        </div>
                    </div>
                    <!-- begin footer -->
                </div>
            </div>
        </div>
    </body></html>
