MK.Views.Search = Backbone.View.extend({
	
	el : '#carousel_ul',
	
	initialize : function(){
		this.Recipes = new MK.Collection.RecipesSearch();
		
		_.bindAll(this, 'addOne', 'addAll');
		
		this.Recipes.bind('add',     this.addOne);
		this.Recipes.bind('refresh', this.addAll);
	//	this.Recipes.bind('all',     this.render);
	},
	
	addAll : function(){
		this.Recipes.each(this.addOne);
	},
	
	addOne : function(recipe){
		var view = new  MK.Views.Recipe({model : recipe});
		console.log(recipe);
		$(this.el).append(view.render().el);
	}
});