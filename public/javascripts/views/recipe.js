MK.Views.Recipe = Backbone.View.extend({
	
	tagName : "",
	className : "",
	id : "",
	
	initialize : function(){
		//passer {model : recipeinstance} en argument
		//TODO binder les changements sur les models
		
	},
	
	events : {
		"click .like-button"		: "clickLike",
		"click .done-button"		: "clickDone",
		"click .favorite-button"	: "clickFavorite",
		"click .follow-button"		: "clickFollow"
		//event edit handle by route controler
	},
	
	clikLike : function(){
		if(!this.model.like.attribute.value){
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
		if(!this.model.favorite.attribute.value){
			this.model.favorite.save();
		}
		else{
			this.model.favorite.destroy();
		}
	},
	
	clickFollow : function(){
		if(!this.model.user.following.attribute.value){
			this.model.user.following.save();
		}
		else{
			this.model.user.following.destroy();
		}
	}
	
	
});