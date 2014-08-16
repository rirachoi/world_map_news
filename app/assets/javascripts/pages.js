$(document).ready(function() {
  var countryCodeInMap;
  var availableCountriesList = [];

  var showTheWorldMap = function(){
    $('#vmap').vectorMap({
      map: 'world_en',
      backgroundColor: '#333333',
      color: '#ffffff',
      hoverOpacity: 0.7,
      selectedColor: '#666666',
      enableZoom: true,
      showTooltip: true,
      values: sample_data,
      scaleColors: ['#C8EEFF', '#006491'],
      normalizeFunction: 'polynomial'

    });
  }

  var isAvailable = function(){
    for(var a=0;a<availableCountriesList.length;a++){
      $(availableCountriesList[a]).attr('class','available');
    }
  }

  var pickAvailableCountires = function(){
    $('.available').css({'fill':'red'});
  }

  $.ajax({
    url: '/pages',
    dataType: 'json'
  }).done(function(res){



    // if (res[0]["culture_code"] === 'ar_all'){
    //   availableCountriesList.push("#jqvmap1_ar");
    // }

    for (var r=1;r<res.length;r++){
      var available = "#jqvmap1_"+res[r]["country_code"];
      availableCountriesList.push(available);
    }

    showTheWorldMap();
    isAvailable();
    pickAvailableCountires();

    console.log(availableCountriesList);
  });




  //getting country_code when click!
  $('#vmap').on('click', function(event){
    var countryCodeInMap = event.target.id.split('_').pop();
    console.log(countryCodeInMap);


  })

});