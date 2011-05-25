MK.Controller = Backbone.Controller.extend({

	initialize : function(){
//-----------TAB initialization-----


//----------SEARCH Initialisation-------
		this.SearchTab = new MK.Views.Search();

		$(document).ready( function() {

			$(".reset").focus(function() {
				if ( this.value == this.placeholder) {
					this.value = "";  
				}
			});

			$(".reset").blur(function() {
				if ( this.value == this.placeholder || this.value == "") {
					this.value = this.placeholder;
				}
			});

			$("#search > form").submit(function(){
				try{
					console.log("hello");
					MK.App.SearchTab.initialize();

					if($("#q").val() != $("#q").attr("placeholder")){
						MK.App.SearchTab.Recipes.setName($("#q").val());
					}

					if($("#w").val() != $("#w").attr("placeholder")){
						var ing = $("#w").val().split(",");
						for(i=0;i<ing.length;i++){
							MK.App.SearchTab.Recipes.addWithoutIngredient({name : ing[i]});
						}
					}

					MK.App.SearchTab.Recipes.search();
					}catch(e){console.log(e);}
					return false;
				});
			});

		},

		routes: {
			"recipes"				: "selectSearchTab",    // #help
			"home"					: "selectHomeTab",
			"recipe/:id"			: "showRecipe",
			"recipe/:id/edit"		: "editRecipe"
			//"search/:query":        "search",  // #search/kiwis
			//"search/:query/p:page": "search"   // #search/kiwis/p7
		},
//----------- TAB display-----------------
		selectTab : function(name){

			$("ul.tabs li").removeClass("active"); //Remove any "active" class
			$("nav li ."+name).addClass("active"); //Add "active" class to selected tab
			$(".tab_content").hide(); //Hide all tab content
			this.closeLightbox();
			$(name+"_tab").fadeIn();

		},

		selectSearchTab : function(){
			this.selectTab("recipes");
		},

		selectHomeTab : function(){
			this.selectTab("home");
		},

		selectProfileTab : function(){
			this.selectTab("profile");
		},

//--------------LightBox---------------
		showLightbox : function(){
			// move the lightbox to the current window top + 50px
			$('#lightbox').css('top', $(window).scrollTop() + 50 + 'px');

			// display the lightbox
			$('#lightbox-shadow').show();
			$('#lightbox').show();

		},

		closeLightbox : function(){
			// hide lightbox and shadow <div/>'s
			$('#lightbox').hide();
			$('#lightbox-shadow').hide();
		}
	});