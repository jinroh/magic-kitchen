MK.Collection.RecipeHistory = Backbone.Collection.extend({
	
	initialize : function(options){
		this.recipe_id = options.recipe_id;
	},
	
	model : MK.Models.History,
	
	recipe_id: null,
	
	url : function(){
		return "/home/history/"+this.recipe_id
	},
	
	addHistory : function(){
		var id = this.recipe_id;
		this.create({ recipe_id : id});
	},
	
	check : function(recipe_id){
		if (recipe_id) {this.recipe_id = recipe_id;}
		this.fetch();
	}
});