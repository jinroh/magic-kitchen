MK.Models.Recipe = Backbone.Model.extend({
	
	initialize : function(options){
		_.bindAll(this, 'addSocial', 'addAuthor');
		
		this.bind("change:id", function(event){
			if(this.id){
				this.addSocial();
			}
		});
		
		this.bind("change:user_id", function(event){
			if(this.attributes.user_id){
				this.addAuthor();
			}
		});
		
		if(this.id){
			this.addSocial();
		}
		
		if(this.attributes.user_id){
			this.addAuthor();
		}
	},
	
	addSocial : function(){
		var recipe_id = this.id;
		var recipe = this;
		
		if(!this.like){
			this.like = new MK.Models.Like();
			this.like.bind("all", function(eventName) {
				var tab = eventName.split(":",2);
				if(tab[1]){
					recipe.trigger(tab[0]+":like."+tab[1]);
				  	recipe.trigger("change");
				}
			});
			this.like.set({recipe_id : recipe_id}, {silent : true});
			this.like.check();
		}
		if(!this.histories){
			this.histories = new MK.Collection.RecipeHistory({recipe_id : recipe_id});
			this.histories.bind("all", function(eventName) {
				var tab = eventName.split(":",2);
				recipe.trigger(tab[0]+":histories"+((tab[1]) ? "."+tab[1] : ""));
				recipe.trigger("change");
			});
			//console.log(recipe_id);
			//this.histories.recipe_id = recipe_id;
			this.histories.check();
		}
		if(!this.favorite){
			this.favorite = new MK.Models.Favorite();
			this.favorite.bind("all", function(eventName) {
			  	var tab = eventName.split(":",2);
				if(tab[1]){
					recipe.trigger(tab[0]+":favorite."+tab[1]);
				  	recipe.trigger("change");
				}
			});
			this.favorite.set({recipe_id : recipe_id}, {silent : true});
			this.favorite.check();
		}
	},
	
	addAuthor : function(){
		var author_id = this.attributes.user_id;
		var recipe = this;
		
		if(!this.author){
			this.author = new MK.Models.User({id : author_id});
			this.author.bind("all", function(eventName) {
			  	var tab = eventName.split(":",2);
				if(tab[1]){
					recipe.trigger(tab[0]+":author."+tab[1]);
				  	recipe.trigger("change");
				}
			});
			this.author.fetch();
		}
	},
	
	url : function() {
	      var base = '/recipes';
	      if (this.isNew()) return base;
	      return base + '/' + this.id;
	    },
	
	toJSON : function(){
		var retour = _.clone(this.attributes);
		
		if(this.like.attributes.value){
			retour.isLiked = true;
		}
		
		if(this.favorite.attributes.value){
			retour.isFavorite = true;
		}
		
		if(this.histories){
			retour.history = this.histories.toJSON();
		}
		
		if(this.author){
			retour.author = this.author.toJSON();
		}
		
		return retour;
	}
});