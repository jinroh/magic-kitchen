MK.Models.User = Backbone.Model.extend({
	
	addSocial : function(){
		//if(this.isNew()){return false;}
		
		var author_id = this.id;
		if(!this.following){
			this.following = new MK.Models.Following();
			this.following.set({user_id : author_id}, {silent : true});
			this.following.check();
		}
		if(!this.follower){
			this.follower = new MK.Models.Follower();
			this.follower.set({user_id : author_id}, {silent : true});
			this.follower.check();
		}
	},
	
	url : function() {
	      var base = '/user';
	      return base + '/' + this.id;
	    }
});