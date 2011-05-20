var Recipe = Backbone.Model.extend({
	url : function() {
	      var base = '/recipes';
	      if (this.isNew()) return base;
	      return base + '/' + this.id;
	    }
});