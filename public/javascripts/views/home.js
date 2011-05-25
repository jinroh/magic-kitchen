MK.Views.Home = Backbone.View.extend({
	
	el: function(){return window.$("#home")},
	
	initialize : function(options){
		this.template = new EJS({url : '/javascripts/views/home.ejs'}); 
	//	passer {model : recipeinstance} en argument

		_.bindAll(this, "render")
		this.model.bind("change", this.render);
	},
	
	render : function(){
		var data = this.model.toJSON();
		//console.log(this.template.render(data));
		html = this.template.render(data)
		this.el().html(html);
		
		return this;
	}
	
	
	
});