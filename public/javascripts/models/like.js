var Following = Backbone.Model.extend({
	url : function() {
	      var base = '/home/likes';
	      if (this.isNew()) return base;
	      return base + '/' + this.id;
	    },
	
	fetch : function(options) {
		options || (options = {});
		var error = options.error;
		var model = this;
	      options.error = function(resp, status, xhr) {
	        if(status.status == '404') model.trigger('destroy', model, model.collection, options);
	        if (error) error(model, resp);
	      };
		Backbone.Model.prototype.fetch.call(this, options);
	}
});