var RecipeHistory = Backbone.Collection.extend({
	
	initialize = function(recipe_id){
		this.recipe_id = recipe.id;
	},
	
	recipe_id: null,
	
	url : "/home/history/"+this.recipe_id,
	
});