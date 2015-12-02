$('document').ready(function() {
  $(".display_checkbox").bind('change', function(){
    $( this ).parent().submit();
  });
});
