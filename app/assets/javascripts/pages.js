$(document).ready(function() {
  var countryCodeInMap;

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

  showTheWorldMap();

  //getting country_code when click!
  $('#vmap').on('click', function(event){
    countryCodeInMap = event.target.id.split('_').pop();
    console.log(countryCodeInMap);
  })

});