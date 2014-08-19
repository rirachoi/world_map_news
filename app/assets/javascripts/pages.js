$(document).ready(function() {

  var countryCodeInMap;
  var countryNameLabel;

  var mapData;
  var searchData;

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

  var createArticlesBox = function(data) {
    console.log('sdfisjlsjfdsdfl');
    categoryInCountry = decodeURIComponent(data.description);
    console.log(categoryInCountry);
    $cateCountry = $('<h2>'+categoryInCountry+'</h2>').addClass('cateCountry');
    $('#'+countryCodeInMap).append($cateCountry)

    // sort by data.date!!
    data.articles.sort(function (a, b) {
      var aDate = new Date(a.publish_date);
      var bDate = new Date(b.publish_date);
      if (aDate > bDate) {
        return -1;
      } else {
        return 1;
      }
    });

    for (var d=0;d<data.articles.length;d++){
      var titleOfArticle = data.articles[d].title;
      var dateOfArticle = data.articles[d].publish_date;
      if (data.articles[d].author === undefined){
        var authorOfArticle = "Anonymous Author"
      } else {
        var authorOfArticle = data.articles[d].author
      }
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
            'title':'Read the full article'
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

      $single_article = $('<div/>')
          .addClass('single_article')
          .append($contentDiv)
          .append($sideDiv);


      $('#'+countryCodeInMap).append($single_article);
    }//end of the loop
  }// end of createArticlesBox

  showTheWorldMap();

  //getting country_code when click!
  $('#vmap').on('click', function(event){
  //// before JSON
    $('.loading_animation').fadeIn(1000);

    countryCodeInMap = event.target.id.split('_').pop();
    $('#article_container > div').hide();
    $('#'+countryCodeInMap).show();

    if ($('.jqvmap-label').text() === 'United States of America'){
      countryNameLabel = "USA"
    } else {
      countryNameLabel = $('.jqvmap-label').text();
    }

  //// getting JSON
    $.getJSON(
      'http://api.feedzilla.com/v1/articles/search.json?q='
      + encodeURIComponent(countryNameLabel)
      + '&count=5'
    ).done(function(data){

      mapData = data;

        $('.loading_animation').fadeOut(1000);
        $('.search_bar').fadeIn(1000);

      createArticlesBox(mapData);

      var $containerHeight = $('#body_container').height();
      $("html, body").animate({ scrollTop: $containerHeight / 5 }, 'slow');

    });//end of get JSON


    var doSearch = function(c){
      var userKeyword = $('#keyword').val();
      console.log(userKeyword)

      $('.loading_animation').fadeIn(1000);
      $('#article_container > div').hide();
      $('#'+countryCodeInMap).show();

      if ($('.jqvmap-label').text() === 'United States of America'){
        countryNameLabel = "USA"
      } else {
        countryNameLabel = $('.jqvmap-label').text();
      }

      $.getJSON(
        'http://api.feedzilla.com/v1/articles/search.json?q='
        + encodeURIComponent(countryNameLabel)
        + "&q="
        + userKeyword
      ).done(function(d){
        searchData = d;
        console.log('is it working?');

        $('.loading_animation').fadeOut(1000);
        $('.search_bar').fadeIn(1000);

        createArticlesBox(searchData);

        var $containerHeight = $('#body_container').height();
        $("html, body").animate({ scrollTop: $containerHeight / 2 }, 'slow');

      });//end of get json

    }

    $('.btn_search').on('click', doSearch);

    $('#keyword').on('keydown', function(event) {
      if (event.which == 13){
        doSearch();
      }
    });
  })//end of vmap click



});