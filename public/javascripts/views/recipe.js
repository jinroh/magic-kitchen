MK.Views.Recipe = Backbone.View.extend({
	
	//template : new EJS({url : '/javascripts/views/recipe.ejs'}),
	
	
	tagName : "li",
	//className : "recipe",
 //	id : "",
	// 
	initialize : function(options){
		this.template = new EJS({url : '/javascripts/views/recipe.ejs'}); 
	//	passer {model : recipeinstance} en argument
		this.id = "recipe"+options.model.id;
	//TODO binder les changements sur les models
	
	},
	// 
	events : {
		"click .like_pic"		: "clickLike",
		"click .check_pic"		: "clickDone",
		"click .star_pic"		: "clickFavorite",
		"click .foll_pic"		: "clickFollow"
		"click .topp"			: "addWith",
		"click .bott"			: "addWitout"
	// 	// 	//event edit handle by route controler
	},
	
	render : function(){
		var data = this.model.toJSON();
		$(this.el).html(this.template.render(data));
		return this;
	},
	
	clickLike : function(){
		if(!this.model.like.attributes.value){
			this.model.like.save();
		}
		else{
			this.model.like.destroy();
		}
	},
	
	clickDone : function(){
		this.model.histories.addHistory();
	},
	
	clickFavorite : function(){
		if(!this.model.favorite.attributes.value){
			this.model.favorite.save();
		}
		else{
			this.model.favorite.destroy();
		}
	},
	
	clickFollow : function(){
		if(!this.model.author.following.attributes.value){
			this.model.author.following.save();
		}
		else{
			this.model.author.following.destroy();
		}
	}
	
	
});