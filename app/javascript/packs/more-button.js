$(document).on("turbolinks:load", function () {
  $(".btn-more").each(function () {
    $(this).click(function(){
      $(this).prev().css("display", "flex");
      $(this).hide();
      $(this).prev().show();
    });
  });
  $(".times").each(function () {
    $(this).click(function(){
      console.log('1')
      $(this).parent().hide();
      $(this).parent().next().show();
      console.log('12')
    });
  })
});

