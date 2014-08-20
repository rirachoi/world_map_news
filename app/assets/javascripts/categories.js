$(document).ready(function(){
  $('.category_name span a').on('click', function(event){
    var cateApiId = event.target.id;
    var cateName = event.target.text();
    console.log('api_id', cateApiId);
    console.log('name', cateName)
  })
});