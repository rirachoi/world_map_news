
$(document).ready(function() {
  var userKeyword;
  var countryCodeInMap;
  var countryName;
  var cateApiId;
  var cateName;
  var userCateApiId;

  var mapData;
  var searchData;
  var cateData;
  var userMapData;

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

  var categoriesMenu = function(){
    $("#extruderLeft").buildMbExtruder({
        position:"right",
        width:300,
        extruderOpacity:.8,
        hidePanelsOnClose:true,
        accordionPanels:true,
        onExtOpen:function(){},
        onExtContentLoad:function(){},
        onExtClose:function(){}
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

    console.log(userKeyword);
    if(userKeyword) {
      $('#' + countryCodeInMap)
          .prepend($('<h2>NEWS FOR <span class="words">'
            + userKeyword.toUpperCase()+'</span> IN <span class="words">'
            + countryName.toUpperCase() +'</span></h2>'));
     } else if(cateName){
      $('#' + countryCodeInMap)
          .prepend($('<h2>NEWS OF <span class="words">'
            + cateName.toUpperCase()+'</span> IN <span class="words">'
            + countryName.toUpperCase() +'</span></h2>'));
     } else if (userCateApiId){
      $('#' + countryCodeInMap)
          .prepend($('<h2>NEWS OF <span class="words">'
            + userCateName.toUpperCase()+'</span> IN <span class="words">'
            + countryName.toUpperCase() +'</span></h2>'));
     } else {
      $('#'+countryCodeInMap)
          .prepend($('<h2>TOP NEWS FOR <span class="words">'
            + countryName.toUpperCase() +'</span></h2>'))
     }

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
      $artiTitle = $('<a><h3>'+titleOfArticle+'</h3></a>')
          .addClass('artiTitle')
          .attr({
            'href':originalUrl,
            'target':'_blank',
            'title':'Read the full article'
          });
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


  var doSearch = function(c){
    userKeyword = $('#keyword').val();
    console.log(userKeyword)
    $('#msg_no_result').hide();
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

      if (searchData.articles.length === 0 || undefined){
        console.log('data is wrong');
        $('#msg_no_result').fadeIn(1000);
        $('search_bar').fadeIn(1000);
        $('#keyword').val("");
      } else {
        createArticlesBox(searchData);
        $('#keyword').val("");
      }

      var $containerHeight = $('#vmap').height();
      $("html, body").animate({ scrollTop: ($containerHeight / 3) + 100 }, 'slow');

    });//end of get json
  }// end of doSearch

//////////////////////////////////////////////////////////////
/////////////////////// END OF FUNCTIONS /////////////////////
//////////////////////////////////////////////////////////////

  showTheWorldMap();
  categoriesMenu();

  $('.back_top').on('click', function(event){
    event.preventDefault();
    $("html, body").animate({ scrollTop: 0 }, 'slow');
    $('.btn_top').css({'transform':'rotateZ(360deg)'});
  });


///////// Clicked the map
  $('.pages-index #vmap').on('click', function(event){
  //// before JSON
    event.preventDefault();
    $('.pages-index .back_top').fadeIn(1000);
    $('#article_container > div').empty();
    countryCodeInMap = event.target.id.split('_').pop();
    userKeyword = '';
    cateName = '';

    //console.log(countryCodeInMap);
    $('#msg_no_result').hide();
    if (countryCodeInMap === "" || undefined ){
      alert('Please Select A Country On The Map');
      $('#keyword').hide();
      $('.btn_search').hide();
      $('#article_container > div').empty();
    } else {
      $('.loading_animation').fadeIn(1000);
      $('#article_container > div').hide();
      $('#article_container > div').empty();
      $('#'+countryCodeInMap).show();
      $('#keyword').fadeIn(1000);
      $('.btn_search').fadeIn(1000);

      var $this = $('#'+countryCodeInMap);
      countryName = $this.attr('class').split(',').shift();
      console.log(countryName)
    }

  //// getting JSON
    $.getJSON(
      'http://api.feedzilla.com/v1/articles/search.json?q='
      + encodeURIComponent(countryName)
      + '&count=5'
    ).done(function(data){

      mapData = data;

      $('.loading_animation').fadeOut(1000);
      $('.search_bar').fadeIn(1000);
      $('#extruderLeft').fadeIn(1000); //categories

      createArticlesBox(mapData);

      $('#keyword').val("");

      var $containerHeight = $('#vmap').height();
      $("html, body").animate({ scrollTop: ($containerHeight / 2) + 100 }, 'slow');

    });//end of get JSON

  })//end of vmap click

//////////// Search options

  $('.btn_search').on('click', function(event){
    event.preventDefault();
    doSearch();

  });

  $('#keyword').on('keydown', function(event) {
    if (event.which === 13){
      event.preventDefault();
      doSearch();

    }
  });

////////// Clicked categories menu
  $('#extruderLeft span').on('click', function(event){
    cateApiId = event.target.id.split('_').shift();
    cateName = event.target.id.split('_').pop();
    userKeyword = "";

    $('#msg_no_result').hide();
    $('.loading_animation').fadeIn(1000);
    $('#article_container > div').hide();
    $('#article_container > div').empty();
    $('#'+countryCodeInMap).show();

    $.getJSON(
      'http://api.feedzilla.com/v1/categories/'
      + cateApiId
      +'/articles/search.json?q='
      + countryName

      ).done(function(cd){
        cateData = cd;

      $('.loading_animation').fadeOut(1000);
      $('.search_bar').fadeIn(1000);
      $('#extruderLeft').fadeIn(1000); //categories

      createArticlesBox(cateData);

      // $('#keyword').val("");

      var $containerHeight = $('#vmap').height();
      $("html, body").animate({ scrollTop: ($containerHeight / 2) + 100 }, 'slow');

    });
  }); // end of categories menu click


////// Clicked MY NEWS CATEGORIES
  $('#user_category div').on('click', function(event){
    userCateApiId = event.target.className.split('_').shift();
    userCateName = event.target.className.split('_').pop();
    console.log(userCateApiId, userCateName);

    $('.users-mynews #vmap').fadeIn(1000);
    $('#article_container > div').empty();

  var $containerHeight = $('#vmap').height();
  $("html, body").animate({ scrollTop: ($containerHeight / 2) + 300 }, 'slow');

  });



////// Clicked MY NEWS MAP
  $('.users-mynews #vmap').on('click', function(event){
    event.preventDefault();
    $('.users-mynews .back_top').fadeIn(1000);
    countryCodeInMap = event.target.id.split('_').pop();
    console.log(countryCodeInMap);
    $('#article_container > div').empty();

    userKeyword = '';
    cateName = '';

    $('#msg_no_result').hide();
    if (countryCodeInMap === "" || undefined ){
      alert('Please Select A Country On The Map');
      $('#keyword').hide();
      $('.btn_search').hide();
      $('#article_container > div').empty();
    } else {
      $('.loading_animation').fadeIn(1000);
      $('#article_container > div').hide();
      $('#article_container > div').empty();
      $('#'+countryCodeInMap).show();
      $('#keyword').fadeIn(1000);
      $('.btn_search').fadeIn(1000);

      var $this = $('#'+countryCodeInMap);
      countryName = $this.attr('class').split(',').shift();
      console.log(countryName)
    }

     //// getting JSON
    $.getJSON(
      'http://api.feedzilla.com/v1/categories/'
      + userCateApiId
      +'/articles/search.json?q='
      + countryName
    ).done(function(data){

      userMapData = data;

      $('.loading_animation').fadeOut(1000);
      $('.search_bar').fadeIn(1000);
      //$('#extruderLeft').fadeIn(1000); //categories

      if (userMapData.articles.length === 0 || undefined){
        console.log('data is wrong');
        $('#msg_no_result').fadeIn(1000);
        $('search_bar').fadeIn(1000);
        $('#keyword').val("");
      } else{
        createArticlesBox(userMapData);
        $('#keyword').val("");
      }

      var $containerHeight = $('#vmap').height();
      $("html, body").animate({ scrollTop: ($containerHeight / 2) + 500 }, 'slow');

    });//end of get JSON

  }); //end of mynews map


});