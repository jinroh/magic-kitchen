steal(
  //	"jquery.min",  <-- ne pas charger jquery après rails.js
  "underscore",
  "jquery-ui.min",
  "json2",
  "backbone",
  "duplicateinput",
  "autocomplete",
  "ejs"
  //	"ejs_production"
)
.then(function() {
    MK = {};
    MK.Models = {};
    MK.Collection = {};
    MK.Views = {};
    //alert("d");
})
.models(
  "recipe",
  //	"like",
  //	"follower",
  //	"following",
  //	"favorite",
  "user",
  "UserInfo",
  "RecipesSearch",
  //actualy a collection
  //	"history",
  "RecipeHistory"
  //actually a collection
)
.then(
  "views/recipe",
  "views/search",
  "views/lightbox",
  "views/home",
  "views/profile",
  "controllers/controller"
)
.then(function() {

$(document).ready(function(){
	
    MK.App = new MK.Controller();
    Backbone.history.start()
    Backbone.history.saveLocation("/home");
});


    // ACCORDION :
    $(document).ready(function() {
        $("body").delegate(".accordionButton", "click", function() {
            $('.accordionButton').removeClass('on');
            $('.accordionContent').slideUp('normal');
            if ($(this).next().is(':hidden') == true) {
                $(this).addClass('on');
                $(this).next().slideDown('normal');
            }
        });
        $("body").delegate(".accordionButton", "mouseover", function() {
            $(this).addClass('over');
        });
        $("body").delegate(".accordionButton", "mouseout", function() {
            $(this).removeClass('over');
        });
        $('.accordionContent').hide();
    });

    $(document).ready(function() {
        $("body").delegate(".trigger", "mouseover", function() {
            if ($(this).next().is(':hidden') == true) {
                $('.trigger').removeClass('on');
                if ($(this).next().is(':hidden') == true) {
                    $(this).addClass('on');
                    $(this).next().slideDown('normal');
                }
            }
        });
        $('.accordContent').hide();
    });
});