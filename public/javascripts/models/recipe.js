MK.Models.Recipe = Backbone.Model.extend({
	
	initialize : function(options){
		_.bindAll(this, 'addSocial');
		this.bind("change", function(event){
			if(this.id){
				this.addSocial();
			}
		}); 
		this.bind("add", function(event){
			if(this.id){
				this.addSocial();
			}
		});
	},
	
	addSocial : function(){
	
		
		var recipe_id = this.id;
		var author_id = this.attributes.user_id;
		if(!this.like){
			this.like = new MK.Models.Like();
			this.like.set({recipe_id : recipe_id}, {silent : true});
			this.like.check();
		}
		if(!this.histories){
			this.histories = new MK.Collection.RecipeHistory({recipe_id : recipe_id});
			//console.log(recipe_id);
			//this.histories.recipe_id = recipe_id;
			this.histories.check();
		}
		if(!this.favorite){
			this.favorite = new MK.Models.Favorite();
			this.favorite.set({recipe_id : recipe_id}, {silent : true});
			this.favorite.check();
		}
		if(!this.author){
			this.author = new MK.Models.User({id : author_id});
			this.author.fetch();
			this.author.addSocial()
		}
	},

	
	url : function() {
	      var base = '/recipes';
	      if (this.isNew()) return base;
	      return base + '/' + this.id;
	    }
});