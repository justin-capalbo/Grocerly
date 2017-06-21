/* Place all the behaviors and hooks related to the matching controller here.
   All this logic will automatically be available in application.js.
   You can use CoffeeScript in this file: http://coffeescript.org/ */
$(document).ready(function() {

  //Delete mode
  $('.btn-delete-mode').click(function() {
    $('.btn-delete').toggle();
    var normalMode = $('.btn-delete').is(":visible");
    if (normalMode)
      $(this).html("Done deleting");
    else
      $(this).html("Delete items");
  });

})
