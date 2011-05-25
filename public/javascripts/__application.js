/* INGREDIENTS FORM
	 ingredients#new
	 ingredients#edit
*/
(function($) {	
	$.fn.autoAddingTextFields = function() {
		var t = $(this);
		var add_field = function() {
			if ($(this).val() == '') return;
			// update ingredients
			ingredients = t.children('div.ingredient').not(':hidden');
			
			// unbind last ingredient and add focusout event
			ingredients.last().children('input[type=text]')
												.unbind('keydown');
												
			// duplicate last one and bind keypress
			ingredients.last().clone().appendTo(t)
								 .find('input')
								 .attr('name', function(i, val) {
										return val.replace(/\[(\d+)\]/, function(match, n) {
											return '['+ (Number(n)+1) +']';
										});
								 })
								 .attr('id', function(i, val) {
										return val.replace(/_(\d+)_/, function(match, n) {
											return '_'+ (Number(n)+1) +'_';
										});
								 })
								 .val('')
								 .keydown(add_field);
			// add remove link to previous last ingredient
			ingredients.last().appendRemoveLink();
			// update ingredients
			ingredients = t.find('div.ingredient').not(':hidden')
		};
		var ingredients = t.find('div.ingredient').not(':hidden');
		ingredients.not(':last').appendRemoveLink();
														
		ingredients.last().children('input[type=text]')
											.keydown(add_field);
		return t;
	}
	
	$.fn.appendRemoveLink = function() {
		return $(this).each(function() {
			div = $(this);
			$('<a href="#" class="remove">×</a>').click(function(){
				$(this).removeIngredient();
				return false;
			}).appendTo(div);
		});
	}
	
	$.fn.removeIngredient = function() {
		$(this).siblings('input').val('');
		$(this).parent().hide();
	}
})(jQuery);

$(document).ready(function() {
	$('#ingredients_field').autoAddingTextFields();
	
	function split(val) {
	    return val.split(/,\s*/);
	}
	function extractLast(term) {
	    return split(term).pop();
	}

	$('#recipe_tag_list')
	.bind("keydown",
	function(event) {
	    if (event.keyCode === $.ui.keyCode.TAB &&
	    $(this).data("autocomplete").menu.active) {
	        event.preventDefault();
	    }
	})
	.autocomplete({
	    source: function(request, response) {
        $.getJSON('/tags/recipes.json', {
            q: extractLast(request.term)
        },
       	function(data) {
					response($.map( data,
						function(item) {
							return {
								label: item.tag.name,
								value: item.tag.name
							}
						})
					);
				});
	    },
	    search: function() {
	        var term = extractLast(this.value);
	        if (term.length < 1) {
	            return false;
	        }
	    },
	    focus: function() {
	    	return false;
			},
			select: function(event, ui) {
				var terms = split(this.value);
				terms.pop();
				terms.push(ui.item.value);
				terms.push('');
				this.value = terms.join(', ');
				return false;
	    }
	});
});