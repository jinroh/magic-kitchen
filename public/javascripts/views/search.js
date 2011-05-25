MK.Views.Search = Backbone.View.extend({
	
	el: function(){return window.$("#recipes")},
	
	initialize : function(){
		
		this.Recipes = new MK.Collection.RecipesSearch();
		
		_.bindAll(this, 'addOne', 'addAll');
		
		this.Recipes.bind('add',     this.addOne);
		this.Recipes.bind('refresh', this.addAll);
	//	this.Recipes.bind('all',     this.render);
	},
	
	events : {
		"click .name_content .remove_search"			: "rmName",
		"click #filter .without_content .remove_search"	: "rmWithout",
		"click #filter .with_content .remove_search"	: "rmWith",
	},
	
	rmName : function(event){
		//alert("hello");
		this.Recipes.setName("");
		this.Recipes.search();
	},
	
	rmWithout : function(event){
		cid = $(event.target).data("ingredient");
		ing = this.Recipes.withoutCollection.getByCid(cid);
		this.Recipes.removeWithoutIngredient(ing);
		console.log(ing);
		this.Recipes.search();
	},
	
	rmWith : function(event){
		cid = $(event.target).data("ingredient");
		ing = this.Recipes.withCollection.getByCid(cid);
		this.Recipes.removeWithIngredient(ing);
		console.log(ing);
		this.Recipes.search();
	},
	
	filterUpdate : function(){
		if(this.Recipes.name && this.Recipes.name!=""){
			name = this.Recipes.name;
			$("#filter .name_content ul").html('<li class="searched">'
				+name+'<div class="remove_search"></div></li>');
			}
		else{ $("#filter .name_content ul").empty();}
				
		var ingwith = this.Recipes.withCollection.models;
		$("#filter .with_content ul").empty();
		for(i=0;i<ingwith.length;i++){
			html = '<li class="searched">'+ingwith[i].attributes.name+
					'<div data-ingredient ="'+ingwith[i].cid+'"class="remove_search"></div></li>'
			$("#filter .with_content ul").append(html);
		}
		
		var ingwith = this.Recipes.withoutCollection.models;
		$("#filter .without_content ul").empty();
		for(i=0;i<ingwith.length;i++){
			html = '<li class="searched">'+ingwith[i].attributes.name+
					'<div data-ingredient ="'+ingwith[i].cid+'"class="remove_search"></div></li>'
			$("#filter .without_content ul").append(html);
		}
	},
	
	addAll : function(){
		this.filterUpdate();
		
		$("#carousel_ul").empty();
		this.Recipes.each(this.addOne);
	},
	
	addOne : function(recipe){
		var view = new  MK.Views.Recipe({model : recipe});
		//console.log(recipe);
		$(view.el).hide();
		$("#carousel_ul").append(view.render().el);
		$(view.el).fadeIn();
	}
});