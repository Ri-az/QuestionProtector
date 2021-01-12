/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$('#user').addClass('active');

$('#hometable th,td').addClass('text-center');

$('#brd1').val('Dhaka');

$('#type1').val('user');

$('#brd').val('Dhaka');

$('#type').val('user');

var alertshow="${checkadduser}";
if(alertshow=="no"){
    $('#homealert').css("display", "block");
        $('#homealert').append('<div class="alert alert-warning alert-dismissible fade in">'
                +'<a class="close" data-dismiss="alert" aria-label="close">&times;</a>'
                +'<div id="alertmsg">Can not add user</div></div>');
}

function addfunction() {

    if ($('#uname').val() == "" || $('#pwd').val() == "" || $('#brd').val() == "" || $('#city').val() == "" || $('#mbl').val() == "" || $('#email').val() == "" || $('#type').val() == "" || $('#centercode').val=="") {
        $('#homealert').css("display", "block");
        $('#homealert').append('<div class="alert alert-warning alert-dismissible fade in">'
                +'<a class="close" data-dismiss="alert" aria-label="close">&times;</a>'
                +'<div id="alertmsg">Invalid input</div></div>');
        
        return false;
    } else {
        $('#homealert').css("display","none");
        $('#homealert').empty();
        return true;
    }
}

function homeuserdelete(id){
    if(window.confirm("Do you want to delete?")){
        window.location.assign("deleteuser.show?id="+id);
    }
}

function homeuserupdate(id,username,password,board,city,phoneno,email,category,centercode){
    console.log("home user update");
    $('#tableid').val(id);
    $('#uname1').val(username);
    $('#pwd1').val(password);
    $('#brd1').val(board);
    $('#city1').val(city);
    $('#mbl1').val(phoneno);
    $('#email1').val(email);
    $('#type1').val(category);
    $('#centercode1').val(centercode);
}

function updatefunction(){
        console.log("checking true1");
    if ($('#uname1').val() == "" || $('#pwd1').val() == "" || $('#brd1').val() == "" || $('#city1').val() == "" || $('#mbl1').val() == "" || $('#email1').val() == "" || $('#type1').val() == "" || $('#centercode1').val()=="") {
        $('#homealert1').css("display", "block");
        $('#homealert1').append('<div class="alert alert-warning alert-dismissible fade in">'
                +'<a class="close" data-dismiss="alert" aria-label="close">&times;</a>'
                +'<div id="alertmsg">Invalid update input</div></div>');
        return false;
    } else {
        $('#homealert1').css("display","none");
        $('#homealert1').empty();
        console.log("checking true");
        return true;
    }
}
