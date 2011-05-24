MK.Models.Recipe = Backbone.Model.extend({

	
	url : function() {
	      var base = '/recipes';
	      if (this.isNew()) return base;
	      return base + '/' + this.id;
	    },

//-------- AUTHOR ----------

	followAuthor : function(){
		
		if(!this.attributes.author){
			return false;
		};
		
		var model = this;
		var author = _.clone(this.attributes.author);
		
		var options = {}
		options.url = "/home/following";
		options.success = function(resp){
				author.is_followed = true;
				model.set({author : author});
		      };
		
		var id = this.attributes.author.id;
		Backbone.sync("create", new Backbone.Model({user_id : id}), options);
		
	},
	
	unfollowAuthor : function(){
		
		
		if(!this.attributes.author){
			return false;
		};
		
		var model = this;
		var author = _.clone(this.attributes.author);
		
		var options = {}
		options.url = "/home/following/"+this.attributes.author.id;
		options.success = function(resp){
				author.is_followed = false;
				model.set({author : author});
		      };
		
		Backbone.sync("delete", null , options);
		
	},
	
//--------LIKE---------
	like : function(){
		
		if(!this.attributes.id){
			return false;
		};
		
		var model = this;
		
		var options = {}
		options.url = "/home/likes";
		options.success = function(resp){
				model.set({is_liked : true});
		      };
		
		var id = this.attributes.id;
		Backbone.sync("create", new Backbone.Model({recipe_id : id}), options);		
	},
	
	unlike : function(){
		
		if(!this.attributes.id){
			return false;
		};
		
		var model = this;
		
		var options = {}
		options.url = "/home/likes/"+this.attributes.id;
		options.success = function(resp){
				model.set({is_liked : false});
		      };
		
		Backbone.sync("delete", null , options);
		
	},
	
//-------FAVORITE------
	addtoFavorites : function(){
		if(!this.attributes.id){
			return false;
		};
		
		var model = this;
		
		var options = {}
		options.url = "/home/favorites";
		options.success = function(resp){
				model.set({is_favorite : true});
		      };
		
		var id = this.attributes.id;
		Backbone.sync("create", new Backbone.Model({recipe_id : id}), options);
	},
	
	removefromFavorites : function(){
		if(!this.attributes.id){
			return false;
		};
		
		var model = this;
		
		var options = {}
		options.url = "/home/favorites/"+this.attributes.id;
		options.success = function(resp){
				model.set({is_favorite : false});
		      };
		
		Backbone.sync("delete", null , options);
		
	},
	
//-------HISTORY--------
	addtoHistory : function(){
		
		if(!this.attributes.id){
			return false;
		};
		
		var model = this;
		var history = _.clone(this.attributes.history);
		
		var options = {}
		options.url = "/home/history";
		options.success = function(resp){
				history.unshift(resp);
				model.set({history : history});
		      };
		
		var id = this.attributes.id;
		Backbone.sync("create", new Backbone.Model({recipe_id : id}), options);
	}
});