<%--
    Document   : adjustment
    Created on : Jun 30, 2010, 1:44:34 PM
    Author     : Isuru
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
  <script language="javascript" type="text/javascript">

      var count=0;
      var tabc;


  function filltable(){


      <% String cat=request.getParameter("cat");

            String item=request.getParameter("item");
        %>
            var cat="<%=cat%>";
            var item="<%=item%>"
           if(count==0){
            var strURL="../fillTablepopup?cat="+cat+"&item="+item;
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
                    temp = str.split("%");
                    var a1=temp.length;
                    var b;
                    for(b=0;b<a1-1;b++){
                    var temp1=new Array();
                    temp1=temp[b].split(":");
                        var root=document.getElementById("fillhere");
                        var opt= document.createElement('tr');
                        opt.setAttribute("id", "text"+b);
                        var tag1=document.createElement('td');
                        var ta1=document.createElement('input');
                        ta1.setAttribute("type", "text");
                        ta1.setAttribute("id", "itemcode"+b);
                        ta1.setAttribute("value", temp1[0]);
                        ta1.setAttribute("size","10");
                        tag1.appendChild(ta1);
                        var tag2=document.createElement('td');
                        var ta2=document.createElement('input');
                        ta2.setAttribute("type", "text");
                        ta2.setAttribute("id", "itemname"+b);
                        ta2.setAttribute("value",temp1[1]);
                        tag2.appendChild(ta2);
                        var tag3=document.createElement('td');
                        var ta3=document.createElement('input');
                        ta3.setAttribute("type", "text");
                        ta3.setAttribute("id", "price"+b);
                        ta3.setAttribute("value", temp1[2]);
                        ta3.setAttribute("size","10")
                        tag3.appendChild(ta3);
                        var tag10=document.createElement('td');
                        var ta10=document.createElement('input');
                        ta10.setAttribute("type", "checkbox");
                        ta10.setAttribute("id", "check"+b);
                        ta10.setAttribute("size","10");
                        tag10.appendChild(ta10);


                opt.appendChild(tag1);
                opt.appendChild(tag2);
                opt.appendChild(tag3);
                opt.appendChild(tag10);
                root.appendChild(opt);


            }
                    tabc=b;
                    count+=1;
            }

                }

                    xmlHttp.send(strURL);
            }

}

function usesamebatch(form1){

    var a=0;
    var x=0;
    while(a<tabc){


                    var tag1="itemcode"+a;
                    var tag2="itemname"+a;
                    var tag10="check"+a;
                    var check=document.getElementById(tag10).checked;

                 if(check==true){

                    opener.document.getElementById("itemcode").value=document.getElementById(tag1).value;
                    opener.document.getElementById("tf_name").value=document.getElementById(tag2).value;
                    break

        }
                            a++;

}

                    self.close();
}


function newbatch(form1){

    var a=0;
    var x=0;
   var str="";
    while(a<tabc){


                    var tag1="itemcode"+a;
                    var tag2="itemname"+a;
                    var tag10="check"+a;
                    var check=document.getElementById(tag10).checked;

                 if(check==true){
                    str=document.getElementById(tag1).value;
                    opener.document.getElementById("tf_name").value=document.getElementById(tag2).value;
                    break

        }
                            a++;

}

                    var temp = new Array();
                    temp = str.split("/");
                    str=temp[0]+"/"+temp[1]+"/"+temp[2]+"/"+temp[3];
                    
                    var i;
                    var b;
                    var point=0;
                    for(i=0;i<tabc;i++){


                     var str1=str+"/"+i;
                     for(b=0;b<tabc;b++){
                     var tag1="itemcode"+b;
                     if(str1==document.getElementById(tag1).value){
                     break;
                     }

                    }
                   
                    if(b==tabc){
                    opener.document.getElementById("itemcode").value=str+"/"+i;
                    break;
                    }
                    

}
                    if(i==tabc)
                        opener.document.getElementById("itemcode").value=str+"/"+i;
                    self.close();
}
function cancelwindow(){
    self.close();
}
</script>
</head><body onload="filltable();">
<div id="hom_hea"><img src="../files/header.jpg" alt="Medical" title="Medical .- The Universal Electronic Medical Record and Hospital Information System." height="85" width="1290"></div>
<div id="con_fja">
<div id="hom_fja">The Inventory Management System </div>
</div>
<div id="men"></div>
<div id="pri">
<div id="con_int">
  <div id="content">
    <!-- end header -->
    <div class="post">
      <table width="970" border="0" cellspacing="1" cellpadding="1">
        <tr>
          <td width="891">&nbsp;</td>
          <td width="44"></td>
          <td width="9">&nbsp;</td>
          <td width="13">&nbsp;</td>
        </tr>
      </table>
      <h2></h2>
       <div class="storycontent">
           <form id="form1" name="form1" method="post" action="">
        <table width="710" border="0" cellpadding="1" cellspacing="1">
          <!--DWLayoutTable-->
          
           <tr>
            <td>&nbsp;</td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td height="1" colspan="3">
             <table border="1" id="fillhere">
               <tr>
                <td>Item Code</td>
                <td>Item Name</td>
                <td>Price</td>
                <td>Select</td>
               </tr>
             </table></td>
            </tr>
          <tr>
            <td width="129"><input name="button20" type="button" value="Use Same Batch" onclick="usesamebatch(form1);"/></td>
            <td width="131"><input name="button21" type="button" value="Creat New Batch" onclick="newbatch(form1);"/></td>
            <td width="440"><input name="button22" type="button" value="Cancel" onclick="cancelwindow();"/></td>
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
