MK.Views.Profile = Backbone.View.extend({
	
	el: function(){return window.$("#profile")},
	
	initialize : function(options){
		this.template = new EJS({url : '/javascripts/views/profile.ejs'}); 
	//	passer {model : recipeinstance} en argument

		_.bindAll(this, "render")
		this.model.bind("change", this.render);
	},
	
	render : function(){
		var data = this.model.toJSON();
		//console.log(this.template.render(data));
		$(this.el).html(this.template.render(data));
		
		return this;
	}
	
	
	
});