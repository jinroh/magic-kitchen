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
				//try{
				//	console.log("hello");
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
				//	}catch(e){console.log(e);}
					return false;
				});
				
			});
//-------------LIGHTBOX VIEW initialization-----------
		this.LightBoxView = new MK.Views.LightBoxView();
		},

		routes: {
			"/recipes"				: "selectSearchTab",    // #help
			"/home"					: "selectHomeTab",
			"/profile"				: "selectProfileTab", 
			"/recipe/:id"			: "showRecipe",
			"/recipe/:id/edit"		: "editRecipe",
			"/recipes/new"			: "newRecipe"
			//"search/:query":        "search",  // #search/kiwis
			//"search/:query/p:page": "search"   // #search/kiwis/p7
		},
//----------- TAB display-----------------
		selectTab : function(name){

			$("ul.tabs li").removeClass("active"); //Remove any "active" class
			$("nav ."+name+"_link").addClass("active"); //Add "active" class to selected tab
			$(".tab_content").hide(); //Hide all tab content
			this.LightBoxView.close();
			$("#"+name).fadeIn();

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

		showRecipe: function(id){
			recipe = new MK.Models.Recipe({id : id});
			this.LightBoxView.setNewModel(recipe, "");
			recipe.fetch();
			this.LightBoxView.open();
		},
		
		editRecipe: function(id){
			recipe = new MK.Models.Recipe({id : id});
			this.LightBoxView.setNewModel(recipe, "form");
			recipe.fetch();
			this.LightBoxView.open();
		},
		
		newRecipe: function(){
			recipe = new MK.Models.Recipe();
			this.LightBoxView.setNewModel(recipe, "form");
			this.LightBoxView.open();
		}
	});