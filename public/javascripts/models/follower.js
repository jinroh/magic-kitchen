var Follower = Backbone.Model.extend({
	url : function() {
	      var base = '/home/follower';
	      return base + '/' + this.id;
	    },
		parse : function(resp, xhr){
			return {value : true};
		},

		fetch : function(options) {
			options || (options = {});
			var error = options.error;
			var model = this;
		    options.error = function(resp, status, xhr) {
		        if(status.status == '404') {
					model.set({value : false});
				}
		        if(error) error(model, resp);
		      };
			Backbone.Model.prototype.fetch.call(this, options);
		}
});