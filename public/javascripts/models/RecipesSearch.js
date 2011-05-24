MK.Collection.RecipesSearch = Backbone.Collection.extend({
	initialize : function(){
		this.withCollection = new Backbone.Collection();
		this.withoutCollection = new Backbone.Collection();
	},
	
	model : MK.Models.Recipe,
	
	url : "/recipes",
	
	name : "",
	withJoin : function() {
		var collection = this.withCollection.toJSON();
		var a = _.map(collection, function(ingr){
			return ingr.name;
		});
		return a.join(",");
	},
	withoutJoin : function() {
		var collection = this.withoutCollection.toJSON();
		var a = _.map(collection, function(ingr){
			return ingr.name;
		});
		return a.join(",");
	},
	page : 1,

	
	setName : function(name){
		this.name = name;
		this.page = 1;
		//this.search();
	},
	
	addWithIngredient : function(ingredient){
		this.withCollection.add(ingredient);
		this.page = 1;
		//this.search();
	},
	
	removeWithIngredient : function(ingredient){
		this.withCollection.remove(ingredient);
		this.page = 1;
		//this.search();
	},
	
	addWithoutIngredient : function(ingredient){
		this.withoutCollection.add(ingredient);
		this.page = 1;
		//this.search();
	},
	
	removeWithoutIngredient : function(ingredient){
		this.withoutCollection.remove(ingredient);
		this.page = 1;
		//this.search();
	},
	
	loadmore : function(num){
		if(!num || num < 1) {num =1;}
		for(i = 1; i < num +1; i++){
			this.page ++;
			this.search({add : true});
		}	
	},
	
	search : function(options){
		
		var requestData={
			search : this.name,
			page : this.page,
			with : this.withJoin(),
			without : this.withoutJoin()
		};
		
		var params = _.extend({
			data : requestData,
			processData : true
		}, options);
		
	//	console.log(params.add);
		this.fetch(params);
	}
	
});