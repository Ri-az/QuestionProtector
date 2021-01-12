/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('#fileupload').addClass('active');
$('#filename').val("");

var var1=$.url().param("board");
if(var1!=null && var1!=""){
    console.log(var1);
    $('#brd1').val(var1);
}
else{
    console.log("var1 not found");
    $('#brd1').val("all");
}

var filescount = 0;
var flist = [];

function selectedfiles() {

    var x = document.getElementById("filename");
    if (x.files.length == 0) {
        txt = "Select one or more files.";
    } else {
        for (var i = 0; i < x.files.length; i++) {
            flist.push(x.files[i]);
            filescount = filescount + 1;
        }
        $('#filetable').empty();
        $('#uploadbtn').empty();
     
        if (filescount > 0) {
            $('#filetable').append('<thead><tr style="background-color:#ffff99;"><th class="text-center">File Name</th><th class="text-right">File Size</th></tr></thead><tbody id="filetablebody"></tbody>');
            $('#uploadbtn').append('<button type="submit" class="btn btn-success">upload <span class="glyphicon glyphicon-edit"></span></button>  ');
        }
        for (var i = 0; i < filescount; i++) {
            $('#filetablebody').append('<tr><td>' + flist[i].name + '</td><td  class="text-right">' + Math.round(flist[i].size / 1000) + ' KB</td></tr>');
        }
        
    }
}


function uploadfile() {
    if ($('#date').val() == "" || $('#subcode').val() == "" || $('board').val()=="" ||$('#time').val()=="") {
        $('#uploadalert').css("display", "block");
        $('#uploadalert').append('<div class="alert alert-warning alert-dismissible fade in">'
                + '<a class="close" data-dismiss="alert" aria-label="close">&times;</a>'
                + '<div id="alertmsg">Invalid uploadfile</div></div>');
        return false;
    } else {
        $('#uploadalert').css("display", "none");
        $('#uploadalert').empty();
        $('filename').val(flist);
        console.log("function get");
        return true;
    }
}


function deletefile(id){
    if(window.confirm("Do you want to delete?")){
        window.location.assign("deleteFile.show?id="+id);
    }
}


function searchchange(){
    var date=$('#dat').val();
    var scode=$('#scode').val();
    var mybrd=$('#brd1').val();
    //console.log(date+" "+scode+" "+mybrd);
    window.location.assign("searchfile.show?date="+date+"&scode="+scode+"&board="+mybrd);
}