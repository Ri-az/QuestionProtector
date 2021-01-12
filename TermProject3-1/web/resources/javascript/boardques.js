/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('#previousquestion').addClass('active');
$('#filename').val("");

var filescount = 0;
var flist = [];

function selectedquesfiles() {

    var x = document.getElementById("filename");
    console.log("yes i get it");
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
            $('#questable').append('<thead><tr style="background-color:#ffff99;"><th class="text-center">File Name</th><th class="text-right">File Size</th></tr></thead><tbody id="questablebody"></tbody>');
            $('#uploadbtn').append('<button type="submit" class="btn btn-success">upload <span class="glyphicon glyphicon-edit"></span></button>  ');
        }
        for (var i = 0; i < filescount; i++) {
            $('#questablebody').append('<tr><td>' + flist[i].name + '</td><td  class="text-right">' + Math.round(flist[i].size / 1000) + ' KB</td></tr>');
        }
        console.log(filescount);
    }
}


function uploadquesfile() {
    if ($('#date').val() == "" || $('#subcode').val() == "" || $('board').val()=="") {
        $('#uploadalert').css("display", "block");
        $('#uploadalert').append('<div class="alert alert-warning alert-dismissible fade in">'
                + '<a class="close" data-dismiss="alert" aria-label="close">&times;</a>'
                + '<div id="alertmsg">Invalid uploadfile</div></div>');
        return false;
    } else {
        $('#uploadalert').css("display", "none");
        $('#uploadalert').empty();
        $('filename').val(flist);
        return true;
    }
}

function deletefile(id){
    if(window.confirm("Do you want to delete?")){
        window.location.assign("deleteboardques.show?id="+id);
    }
}
