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
		this.$("#filter .name_content ul").html('<li class="searched">'
				+name+'<div class="remove_search"></div></li>');
				
		var ingwith = this.Recipes.withCollection.toJSON();
		this.$("#filter .with_content ul").empty();
		for(i=0;i<ingwith.length;i++){
			html = '<li class="searched">'+ingwith[i].name+
					'<div data-ingredient ="'+ingwith[i].id+'"class="remove_search"></div></li>'
			this.$("#filter .with_content ul").append(html);
		}
		
		var ingwith = this.Recipes.withoutCollection.toJSON();
		this.$("#filter .without_content ul").empty();
		for(i=0;i<ingwith.length;i++){
			html = '<li class="searched">'+ingwith[i].name+
					'<div data-ingredient ="'+ingwith[i].id+'"class="remove_search"></div></li>'
			this.$("#filter .without_content ul").append(html);
		}
	},
	
	addAll : function(){
		this.filterUpdate();
		
		this.$("#carousel_ul").empty();
		this.Recipes.each(this.addOne);
	},
	
	addOne : function(recipe){
		var view = new  MK.Views.Recipe({model : recipe});
		//console.log(recipe);
		$(view.el).hide();
		this.$("#carousel_ul").append(view.render().el);
		$(view.el).fadeIn();
	}
});