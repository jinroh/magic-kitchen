var Follower = Backbone.Model.extend({
	base : "/home/followers",
	
	url : function() {
	      if (this.isNew()) return this.base;
	      return this.base + '/' + this.id;
	    },
	
	parse : function(resp, xhr){
		this.id = this.attributes.follower_id;
		return {value : true};
	},
	
	check : function(follower_id){
		if(follower_id) {this.attributes.follower_id = follower_id;}
		options ={};
		var model = this;
	    options.error = function(resp, status, xhr) {
	        if(status.status == '404') {
				model.set({value : false});
			}
	      };
	
		if(this.isNew()) { 
			options.url = this.base+"/"+this.attributes.follower_id;
		}
		else {options.url = this.url();}
		console.log(options.url);
		this.fetch(options);	
	},
});