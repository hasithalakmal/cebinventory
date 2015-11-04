
function validateFormOnSubmit(form){

  var reason = "";
  reason +=validateEmpty(form.coce,"You can not leave centre no empty!");
  reason +=validateEmpty(form.sec,"You can not leave section no empty!")
  reason +=validateEmpty(form.firname,"You can not leave First Name empty!");
  reason +=validateEmpty(form.laname,"You can not leave Last Name empty!");
  reason +=validateEmpty(form.email,"You can not keep email empty!");
  reason +=validateEmpty(form.password,"You can not keep password empty!");
  reason +=validateEmpty(form.newPassword,"You have to retype the password");
  if(form.password.value!=form.newPassword.value){
          reason +="The password not matching";
      }

  var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
  var address = form.email.value;
  if(reg.test(address) == false) {
     reason +="Email is not a valid one!";
  }


  if (reason != "") {
    alert("The following corrections need to be done :\n" + reason);
    return false;
  }
  else {
      alert("The user's details are edited");
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