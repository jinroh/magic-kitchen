var RecipeHistory = Backbone.Collection.extend({
	
	initialize : function(recipe_id){
		this.recipe_id = recipe_id;
	},
	
	model : History,
	
	recipe_id: null,
	
	url : function(){
		return "/home/history/"+this.recipe_id
	},
	
	addHistory : function(){
		var id = this.recipe_id;
		this.create({ recipe_id : id});
	},
	
	check : function(recipe_id){
		this.recipe_id = recipe_id;
		this.fetch();
	}
});