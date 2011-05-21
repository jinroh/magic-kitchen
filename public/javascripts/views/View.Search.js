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
	},
	
	addOne : function(recipe){
		var like = new Models.Like();
		like.check(recipe.attributes.recipe_id);
		
		var histories = new RecipeHistory();
		histories.check(recipe.attributes.recipe_id);
		
		var favorite = new Favorite();
		favorite.check(recipe.attributes.recipe_id);
		
		var user = new User({id : recipe.attributes.user_id});
		
		
		var view = new View.Recipe({model: todo});
		this.$("#todo-list").append(view.render().el);
	}
});