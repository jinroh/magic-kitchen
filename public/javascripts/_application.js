
steal("jquery.min", 
		"underscore", 
		"json2",
		"backbone"
		)
		.models(
			"recipe", 
			"like", 
			"follower", 
			"following", 
			"favorite", 
			"RecipesSearch", //actualy a collection
			"history",
			"RecipeHistory" //actually a collection
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
