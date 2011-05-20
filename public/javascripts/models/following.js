var Following = Backbone.Model.extend({
 	new : true,
	
	url : function() {
	      var base = '/home/following';
	      if (this.isNew()) return base;
	      return base + '/' + this.id;
	    },
	
	isNew : function(){
		return this.new;
	},
	
	parse : function(resp, xhr){
		this.new = false;
		return {value : true};
	},
	
	fetch : function(options) {
		options || (options = {});
		var error = options.error;
		var model = this;
	    options.error = function(resp, status, xhr) {
	        if(status.status == '404') {
				model.set({value : false});
				model.new = true;
			}
	        if(error) error(model, resp);
	      };
		this.new = false;
		Backbone.Model.prototype.fetch.call(this, options);
	},
	
	destroy : function(options) {
      options || (options = {});
      var model = this;
      var success = options.success;
      options.success = function(resp) {
		model.set({value : false});
       model.new = true
        if (success) success(model, resp);
      };
	Backbone.Model.prototype.destroy.call(this, options);
	
    },
});