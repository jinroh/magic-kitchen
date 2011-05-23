
steal(
	//	"jquery.min",  <-- ne pas charger jquery après rails.js 
		"underscore", 
		"json2",
		"backbone",
	//	"ejs"
		"ejs_production"
		)
		.then(function(){
			MK = {};
			MK.Models = {};
			MK.Collection = {};
			MK.Views = {};
			//alert("d");
		})
		.models(
			"recipe", 
			"like", 
			"follower", 
			"following", 
			"favorite",
			"user",
			"RecipesSearch", //actualy a collection
			"history",
			"RecipeHistory" //actually a collection
		)
		.then(
			"views/recipe"
			)
		.then(function(){
			var App = {
			    Views: {},
			    Controllers: {},
			    init: function() {
			        // TODO
			        Backbone.history.start();
			    }
			};
		});
