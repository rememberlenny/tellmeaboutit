// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });

(function($){
  console.log('Ran');
  $('.generate-id').on('click', function(e){
    e.preventDefault();
    console.log('Clicked generate-id');
    var $field = $('.id-field');
    if($field.disabled != true){
      $.getJSON( "/generate", function( data ) {
        var uid = data;
        console.log('Grabbed /generate');
        $field.html(uid);
        $field.prop('disabled', true);
      });
    }
  });
})(jQuery);
