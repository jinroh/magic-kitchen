MK.Views.LightBoxView = Backbone.View.extend({
	
	initialize : function(){
		this.template_form = new EJS({url :"/javascripts/templates/recipe_form.ejs"});
		this.template = new EJS({url : "/javascripts/templates/recipe_lightbox.ejs"});
	},
	
	setNewModel : function(model){
		delete this.model;
		this.model = model;
		
		_.bindAll(this, "render", "submit", "renderForm")
		this.model.bind("change", this.render);
		this.el().delegate("form#new_recipe","submit", this.submit);
		this.el().delegate("form .close_lightbox","click", function(){
			//console.log("hello");
			window.history.back();
			return false;
		});
		
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
		//	console.log(data.name);
		//get round BUG of EJS with name
		data.name_rec = data.name; 
		this.$("#inner_content").html(this.template_form.render(data));
		$(".field_ingredients").autoAddingTextFields();
    return this;
	},
	
	submit : function(){
		var recipe = {};
		
		recipe.name = this.$("input#recipe_name").val();
		recipe.ingredients = [];
		var i = 0;
		this.$("input#recipe_ingredients__name").each(function(index){
			if($(this).val() == ""){return;}
			recipe.ingredients[i] = {} ;
			recipe.ingredients[i].name = $(this).val();
			i++;
			});
		
		recipe.content = this.$("textarea#recipe_content").val();
		//console.log(recipe.content);
		recipe.tag_list = this.$("input#recipe_tag_list").val();
		
		this.model.set(recipe, {silent : true});
		try{this.model.save(null,{success: function(model, response){
			MK.App.LightBoxView.render();
		//	console.log("helllo");
			}
			
		});
		}catch(e){//console.log(e);
			}
		return false;
	}

	
});