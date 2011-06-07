MK.Views.LightBoxView = Backbone.View.extend({

	initialize : function(){
		this.template_form = new EJS({url :"/javascripts/templates/recipe_form.ejs"});
		this.template = new EJS({url : "/javascripts/templates/recipe_lightbox.ejs"});
		
		_.bindAll(this, "render", "submit", "renderForm");
		this.el().delegate("form#new_recipe","submit", this.submit);
		this.el().delegate("form .close_lightbox","click", function(){
			window.history.back();
			return false;
		});

	},

	setNewModel : function(model){
		delete this.model;
		this.model = model;
		this.model.bind("change", this.render);

	},

	el: function(){return window.$("#lightbox")},

	//------------------- UI interaction methods----------	
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

	submit : function(){
		var recipe = {};

		recipe.name = this.$("input#recipe_name").val();
		
		recipe.ingredients = [];
		var i = 0;
		this.$("input#recipe_ingredients__name").each(function(index){
			if($(this).val() == ""){return;} //ignore blank
			recipe.ingredients[i] = {} ;
			recipe.ingredients[i].name = $(this).val();
			i++;
		});

		recipe.content = this.$("textarea#recipe_content").val();
		
		recipe.tag_list = this.$("input#recipe_tag_list").val();

		this.model.set(recipe, {silent : true});
			
		this.inLoading();
		this.model.save(null,{
			success: function(model, response){
			MK.App.LightBoxView.outLoading().empty().render();
			},
			
			error : function(model, response){
			MK.App.LightBoxView.outLoading().showErrorMessage(response.statusText);		
			}
		});

		
		return false;
	},

	//---------------------- render methods -------------------

	render : function(){
		var data = this.model.toJSON();

		this.$("#inner_content").html(this.template.render(data));

		return this;
	},

	renderForm : function(options){
		var data = this.model.toJSON();

		//get round BUG of EJS with name
		data.name_rec = data.name;
		html =  this.template_form.render(data);
		if(options && options.isNew){ 
			html = "<h3>Add a new recipe</h3>"+html;
			}
		else{
			html = "<h3>Edit your recipe</h3>"+html;
		}
		this.$("#inner_content").html(html);

		//autocomplete initialization :
		$(".field_ingredients").autoAddingTextFields();

		return this;
	},

	empty : function(){
		this.$("#inner_content").empty();

		return this;
	},

	inLoading : function(){
		
		//disable submit
		element = this.$("#recipe_submit");
		element.data('ujs:enable-with', element.val());
		element.val(element.data('disable-with'));
		element.attr('disabled', 'disabled');
		
		//TODO something non destructive
		this.$("#inner_content").append("<p>Loading..</p>");

		return this;
	},
	
	outLoading : function(){
		//enable submit
		element = this.$("#recipe_submit");
		if (element.data('ujs:enable-with')) element.val(element.data('ujs:enable-with'));
		element.removeAttr('disabled');
		//TODO something non destructive
		return this;
	},
	
	showErrorMessage : function(statusText){
		//TODO
		statusText || (statusText = "error");
		this.$("#inner_content").append("<p>Oups : "+statusText+"</p>");
		
		return this;
	}

});