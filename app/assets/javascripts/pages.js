$(document).ready(function() {

  var countryCodeInMap;
  var countryNameLabel;
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
    $('.available').css({'opacity':1});
  }

  $.ajax({
    url: '/pages',
    dataType: 'json'
  }).done(function(res){
    // if (res[0]["culture_code"] === 'ar_all'){
    //   availableCountriesList.push("#jqvmap1_ar");
    // }

    // for (var r=1;r<res.length;r++){
    //   var available = "#jqvmap1_"+res[r]["country_code"];
    //   availableCountriesList.push(available);
    //   if (res[r]["country_code"] === "uk"){
    //     availableCountriesList.push('#jqvmap1_gb');
    //     }

    // }

    showTheWorldMap();
    pickAvailableCountires();
    //console.log(availableCountriesList);
  });

  // var createArticlesBox = function(){
  //   $artiTitle = $('<h3>'+titleOfArticle+'</h3>').addClass('artiTitle');
  //   $artiSummary = $('<p>'+summaryOfArticle+'</p>').addClass('artiSummary');
  //   $artiOriginal = $('<a>Read More..</a>')
  //       .addClass('artiOriginal')
  //       .attr('href', originalUrl)
  //       .attr('target', '_blank')
  //       .attr('title', 'Read Full Content');

  //   $contentDiv = $('<div/>')
  //       .addClass('content_article')
  //       .append($artiTitle)
  //       .append($artiSummary)
  //       .append($artiOriginal);

  //   $artiAuthor = $('<h3>'+authorOfArticle+'</h3>').addClass('artiAuthor');
  //   $artiSource = $('<a>'+sourceOfArticle+'</a>')
  //       .addClass('artiSource')
  //       .attr({
  //         'href':sourceUrl,
  //         'target':'_blank',
  //         'title':'Go to the original source'
  //       });
  //   //$artiImage = $('<img>').addClass('artiImage');
  //   $sideDiv = $('<div/>')
  //       .addClass('article_info')
  //       .append($artiAuthor)
  //       .append($artiSource);

  //   $cateCountry = $('<h2>'+categoryInCountry+'</h2>').addClass('cateCountry');
  //   $artiDate = $('<p>'+dateOfArticle+'</p>').addClass('artiDate');
  //   $('#article_container')
  //       .append($cateCountry)
  //       .append($artiDate)
  //       .append($contentDiv)
  //       .append($sideDiv);
  // }

  //getting country_code when click!
  $('#vmap').on('click', function(event){
    var countryCodeInMap = event.target.id.split('_').pop();
    //console.log(countryCodeInMap);
    countryNameLabel = $('.jqvmap-label').text();
    //console.log(countryNameLabel);

    $.getJSON(
      'http://api.feedzilla.com/v1/articles/search.json?q='
      + countryNameLabel
      + '&count=5'
      , function( data ) {
          categoryInCountry = data.description;
          $cateCountry = $('<h2>'+categoryInCountry+'</h2>').addClass('cateCountry');
          $('#article_container').append($cateCountry)

          for (var d=0;d<data.articles.length;d++){
            // var articles = data.articles
            var titleOfArticle = data.articles[d].title;
            var dateOfArticle = data.articles[d].publish_date;
            var authorOfArticle = data.articles[d].author;
            var sourceOfArticle = data.articles[d].source;
            var sourceUrl = data.articles[d].source_url;
            var summaryOfArticle = data.articles[d].summary;
            var originalUrl = data.articles[d].url;

            $artiDate = $('<p>'+dateOfArticle+'</p>').addClass('artiDate');
            $artiTitle = $('<h3>'+titleOfArticle+'</h3>').addClass('artiTitle');
            $artiSummary = $('<p>'+summaryOfArticle+'</p>').addClass('artiSummary');
            $artiOriginal = $('<a>Read More..</a>')
                .addClass('artiOriginal')
                .attr({
                  'href':originalUrl,
                  'target':'_blank',
                  'title':'Read Full Content'
                });
            $contentDiv = $('<div/>')
                .addClass('content_article')
                .append($artiDate)
                .append($artiTitle)
                .append($artiSummary)
                .append($artiOriginal);

            $artiAuthor = $('<h3>'+authorOfArticle+'</h3>').addClass('artiAuthor');
            $artiSource = $('<a>'+sourceOfArticle+'</a>')
                .addClass('artiSource')
                .attr({
                  'href':sourceUrl,
                  'target':'_blank',
                  'title':'Go to the original source'
                });
            //$artiImage = $('<img>').addClass('artiImage');
            $sideDiv = $('<div/>')
                .addClass('article_info')
                .append($artiAuthor)
                .append($artiSource);

            $('#article_container')
                .append($contentDiv)
                .append($sideDiv);

          }

    })//end of getJSON

  })//end of vmap click

});