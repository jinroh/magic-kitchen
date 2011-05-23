MK.Models.User = Backbone.Model.extend({
	
	initialize : function(options){
		_.bindAll(this, 'addSocial');
		
		this.bind("change:id", function(event){
			if(this.id){
				this.addSocial();
			}
		});
		
		if(this.id){
			this.addSocial();
		}
	},
	
	url : function() {
	      var base = '/user';
	      return base + '/' + this.id;
	},
	
	addSocial : function(){
		//if(this.isNew()){return false;}
		
		var author_id = this.id;
		var user = this;
		if(!this.following){
			this.following = new MK.Models.Following();
			this.following.bind("all", function(eventName) {
				var tab = eventName.split(":",2);
				user.trigger(tab[0]+":following"+((tab[1]) ? "."+tab[1] : ""));
				user.trigger("change");
			});
			this.following.set({user_id : author_id}, {silent : true});
			this.following.check();
		}
		if(!this.follower){
			this.follower = new MK.Models.Follower();
			this.follower.bind("all", function(eventName) {
				var tab = eventName.split(":",2);
				user.trigger(tab[0]+":follower"+((tab[1]) ? "."+tab[1] : ""));
				user.trigger("change");
			});
			this.follower.set({user_id : author_id}, {silent : true});
			this.follower.check();
		}
	},
	
	toJSON : function(){
		var retour = _.clone(this.attributes);
		
		if(this.following.attributes.value){
			retour.isFollowed = true;
		}
		
		if(this.follower.attributes.value){
			retour.isFollowing = true;
		}
		
		return retour;
	}
});