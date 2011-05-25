MK.Controller = Backbone.Controller.extend({
	
	initialize : function(){
		
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
   // "help":                 "help",    // #help
   // "search/:query":        "search",  // #search/kiwis
   // "search/:query/p:page": "search"   // #search/kiwis/p7
  }

});