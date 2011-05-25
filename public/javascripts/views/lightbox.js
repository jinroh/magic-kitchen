MK.Views.LightBoxView = Backbone.View.extend({
	
	initialise : function(){
		this.template_form = new EJS({url :"/javascripts/views/recipe_form.ejs"});
		this.template = new EJS({url : "/javascripts/views/recipe_lightbox.ejs"});
	},
	
	setNewModel : function(model){
		delete this.model;
		this.model = model;
		
		_.bindAll(this, "render", "submit", "renderForm")
		this.model.bind("change", this.render);
		this.el().delegate("form#new_recipe","submit", this.submit);
	},
	
	el: function(){return window.$("#lightbox")},
	
	open : function(){
		// move the lightbox to the current window top + 50px
		$('#lightbox').css('top', $(window).scrollTop() + 50 + 'px');

		// display the lightbox
		$('#lightbox-shadow').show();
		$('#lightbox').show();

	},

	close : function(){
		// hide lightbox and shadow <div/>'s
		$('#lightbox').hide();
		$('#lightbox-shadow').hide();
	},
	
	render : function(){
		var data = this.model.toJSON();
		//console.log(this.template.render(data));
		this.$("#inner_content").html(this.template.render(data));
		return this;
	},
	
	renderForm : function(){
		var data = this.model.toJSON();
		//console.log(this.template.render(data));
		this.$("#inner_content").html(this.template_form.render(data));
		return this;
	};
	
	submit : function(){
		var recipe = {};
		
		recipe.name = this.$("input#recipe_name").val();
		recipe.ingredients = [];
		this.$("input#recipe_ingredients__name").each(function(index){
			recipe.ingredients[index] = {} ;
			recipe.ingredients[index].name = $(this).val();
			});
		
		recipe.content = this.$("input#recipe_content").val();
		recipe.tag_list = this.$("input#recipe_tag_list").val();
		
		this.model.set(recipe);
		this.model.save({success : function(){console.log(this)}});
	}

	
});