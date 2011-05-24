MK.Views.Search = Backbone.View.extend({
	
	el : '#recipes',
	
	initialize : function(){
		this.Recipes = new MK.Collection.RecipesSearch();
		
		_.bindAll(this, 'addOne', 'addAll');
		
		this.Recipes.bind('add',     this.addOne);
		this.Recipes.bind('refresh', this.addAll);
	//	this.Recipes.bind('all',     this.render);
	},
	
	filterUpdate : function(){
		var name = this.Recipes.name || "non";
		this.$("#filter > .searched_name").html(name);
	},
	
	addAll : function(){
		this.filterUpdate();
		this.$("#carousel_ul").empty();
		this.Recipes.each(this.addOne);
	},
	
	addOne : function(recipe){
		var view = new  MK.Views.Recipe({model : recipe});
		console.log(recipe);
		this.$("#carousel_ul").hide().append(view.render().el).fadeIn();
	}
});