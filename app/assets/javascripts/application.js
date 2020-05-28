// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .



function select_tag(t,id) {
    // console.log("iD", id);
    var crValue = $('#myText').val(); 
    var newValue;
    if (crValue == 'all') {
        newValue  = id;
    } else{
        newValue = crValue+","+id;
    }
    
    console.log( newValue);
    $('#myText').val(newValue);
    var e = t,
    n = e.className;
    e.className = "badge" == n ? "badge badge-pill badge-warning" : "badge";
}


function runEffect() {
    setTimeout(function(){
        var selectedEffect = 'blind';
        var options = {};
        $(".alert-success").hide(selectedEffect, options, 500)
     }, 5000);
}

