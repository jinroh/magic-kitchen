MK.Models.Following = Backbone.Model.extend({
	base : "/home/following",
	
	url : function() {
	      if (this.isNew()) return this.base;
	      return this.base + '/' + this.id;
	    },
	
	parse : function(resp, xhr){
		this.id = this.attributes.user_id;
		return {value : true};
	},
	
	check : function(user_id){
		if(user_id) {this.attributes.user_id = user_id;}
		options ={};
		var model = this;
	    options.error = function(resp, status, xhr) {
	        if(status.status == '404') {
				model.set({value : false});
			}
	      };
	
		if(this.isNew()) { 
			options.url = this.base+"/"+this.attributes.user_id;
		}
		else {options.url = this.url();}
		//console.log(options.url);
		this.fetch(options);	
	},
	
	destroy : function(options) {
      options || (options = {});
      var model = this;
      var success = options.success;
      options.success = function(resp) {
		model.set({value : false});
		delete	model.id;
        if (success) success(model, resp);
      };
	Backbone.Model.prototype.destroy.call(this, options);
	
    },
});