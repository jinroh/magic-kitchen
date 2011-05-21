var View.Search = Backbone.View.extend({
	
	initialize : function(){
		this.Recipes = new Collection.RecipesSearch();
		
		_.bindAll(this, 'addOne', 'addAll', 'render');
		
		this.Recipes.bind('add',     this.addOne);
		this.Recipes.bind('refresh', this.addAll);
		this.Recipes.bind('all',     this.render);
	},
	
	addAll : function(){
		this.Recipes.each(this.addOne);
});