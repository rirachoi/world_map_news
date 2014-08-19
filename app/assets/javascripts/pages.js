$(document).ready(function() {

  var countryCodeInMap;
  var userKeyword;
  var countryName;

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


//////////////////////////////////////////////////////////////
/////////////////////// END OF FUNCTIONS /////////////////////
//////////////////////////////////////////////////////////////

  showTheWorldMap();

  //getting country_code when click!
  $('#vmap').on('click', function(event){
  //// before JSON
    $('.loading_animation').fadeIn(1000);
    countryCodeInMap = event.target.id.split('_').pop();
    $('#article_container > div').hide();
    $('#article_container > div').empty();
    $('#'+countryCodeInMap).show();

    var $this = $('#'+countryCodeInMap);
    countryName = $this.attr('class');
    console.log(countryName)


  //// getting JSON
    $.getJSON(
      'http://api.feedzilla.com/v1/articles/search.json?q='
      + encodeURIComponent(countryName)
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
      userKeyword = $('#keyword').val();
      console.log(userKeyword)

      $('.loading_animation').fadeIn(1000);
      $('#article_container > div').hide();
      $('#article_container > div').empty();
      $('#'+countryCodeInMap).show();

      $.getJSON(
        'http://api.feedzilla.com/v1/articles/search.json?q='
        + encodeURIComponent(countryName)
        + "&q="
        + encodeURIComponent(userKeyword)
      ).done(function(d){
        searchData = d;
        $('.loading_animation').fadeOut(1000);
        $('.search_bar').fadeIn(1000);

        if (searchData === null || undefined){
          console.log('data is null');
        } else {

          createArticlesBox(searchData);
        }

        var $containerHeight = $('#body_container').height();
        $("html, body").animate({ scrollTop: $containerHeight / 2 }, 'slow');

      });//end of get json
    }// end of doSearch

    $('.btn_search').on('click', function(event){
      event.preventDefault();
      $('#' + countryCodeInMap)
            .prepend($('<h2>'+ userKeyword+' In '+ countryName +'</h2>'));
      $('#keyword').empty();
      doSearch();
    });

    $('#keyword').on('keydown', function(event) {
      // event.preventDefault();
      if (event.which === 13){
        event.preventDefault();
        $('#' + countryCodeInMap)
            .prepend($('<h2>'+ userKeyword+' In '+ countryName +'</h2>'));
        $('#keyword').empty();
        doSearch();
      }
    });


  })//end of vmap click

});