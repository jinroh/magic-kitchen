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
		//Filter event :
		"click .name_content .remove_search"			: "rmName",
		"click #filter .without_content .remove_search"	: "rmWithout",
		"click #filter .with_content .remove_search"	: "rmWith",
		
		//Carroussel event:
		"click #left_scroll img"						: "moveLeft",
		"click #right_scroll img"						: "moveRight",
		
	},
	
//--------------FILTER on left Side--------------

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
	
//------------------- ADDing the recipes depending on the Model------
	addAll : function(){
		this.filterUpdate();
		this.gotoFirst();
		
		$("#carousel_ul").empty();
		this.Recipes.each(this.addOne);
	},
	
	addOne : function(recipe){
		var view = new  MK.Views.Recipe({model : recipe});
		//console.log(recipe);
		$(view.el).hide();
		$("#carousel_ul").append(view.render().el);
		$(view.el).fadeIn();
	},
	
//---------------------Carroussel engine----------------------

	moveRight : function(){
		
	    //get the width of the items ( i like making the jquery part dynamic, 
		//so if you change the width in the css you won't have o change it here too ) '  
	    //item_width = this.$('#carousel_ul li').outerWidth() + 10; 
		
		//CONSTANT :
		item_width = 280 + 10;
		
	    //calculate the new left indent of the unordered list  
	    left_indent = parseInt(this.$('#carousel_ul').css('left')) - item_width; 

		right_indent = ((this.$("#carousel_ul").children("li").length-2)*item_width)

		if (left_indent >-right_indent) { 
	    	//make the sliding effect using jquery's anumate function '  
	    	this.$('#carousel_ul').animate(	{'left' : left_indent},
											{queue:true, duration:100}
									 	);
		}

		else {	
			//we are at the end of the carroussel
			this.Recipes.loadmore();
		}	
	},
	
	moveLeft : function(){
		
		//item_width = this.$('#carousel_ul li').outerWidth() + 10; 
		
		//CONSTANT :
		item_width = 280 + 10; 

	    /* same as for sliding right except that it's current left indent + the 
		item width (for the sliding right it's - item_width) */  
	    left_indent = parseInt(this.$('#carousel_ul').css('left')) + item_width;  
		
		if (left_indent <1) { 
	    	this.$('#carousel_ul').animate({'left' : left_indent},
											{queue:true, duration:100}  
											); 
		}
		
	},
	
	gotoFirst : function(){
		this.$('#carousel_ul').animate({'left' : 0},
										{queue:true, duration:300}  
										);
	}
});