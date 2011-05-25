MK.Controller = Backbone.Controller.extend({

	initialize : function(){
//-----------TAB initialization-----

$(document).ready( function() {
	$("ul.tabs li").removeClass("active");
//	console.log("hello");
	$(".tab_content").hide(); 
	
	$("nav ."+"home"+"_link").addClass("active");
	$("#"+"home").show();
	
//	window.location.hash = "#/home";
});

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
					window.location.hash = "#/recipes"
					$(window).trigger("hashchange");
					return false;
				});
				
			});
//-------------LIGHTBOX VIEW initialization-----------
		this.LightBoxView = new MK.Views.LightBoxView();
		
//-------------Home and Profile Inititilization-------
		this.CurUserInfo = new MK.Models.UserInfo();
		
		//MAJ autommatique
		///////
		
		this.HomeTab = new MK.Views.Home({model : this.CurUserInfo});
		this.HomeTab.render();
		this.ProfileTab = new MK.Views.Profile({model : this.CurUserInfo});
		this.ProfileTab.render();
		
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
			//console.log($("#"+name).is(":visible"));
			this.LightBoxView.close();	
			if(!$("#"+name).is(":visible")){
				$("ul.tabs li").removeClass("active"); //Remove any "active" class
				$("nav ."+name+"_link").addClass("active"); //Add "active" class to selected tab
				$(".tab_content").hide(); //Hide all tab content
			
				$("#"+name).fadeIn();
			}	

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
			if(this.SearchTab.Recipes.get(id)){
				recipe = this.SearchTab.Recipes.get(id);
			}else{
				recipe = new MK.Models.Recipe({id : id});
				recipe.fetch();
			}
			this.LightBoxView.setNewModel(recipe);

			this.LightBoxView.open();
		},
		
		editRecipe: function(id){
			if(this.SearchTab.Recipes.get(id)){
				recipe = this.SearchTab.Recipes.get(id);
			}else{
				recipe = new MK.Models.Recipe({id : id});
				recipe.fetch();
			}
			
			this.LightBoxView.setNewModel(recipe);
			this.LightBoxView.renderForm().open();
		},
		
		newRecipe: function(){
			recipe = new MK.Models.Recipe();
			this.LightBoxView.setNewModel(recipe);
			this.LightBoxView.renderForm().open();
		}
	});