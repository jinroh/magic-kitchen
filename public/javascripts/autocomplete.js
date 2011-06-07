$(function() {
	$.ajax({
	  url:"/tags/recipes/ingredients.json",
	  dataType: "json",
	  success: function(data) {
	    var availableTags = data;
	    function split( val ) {
    		return val.split( /,\s*/ );
    	}
    	function extractLast( term ) {
    		return split( term ).pop();
    	}
    	$( "#q" )
    		.bind( "keydown", function( event ) {
    			if ( event.keyCode === $.ui.keyCode.TAB &&
    					$( this ).data( "autocomplete" ).menu.active ) {
    				event.preventDefault();
    			}
    		})
    		.autocomplete({
    			minLength: 2,
    			source: function( request, response ) {
    				response( $.ui.autocomplete.filter(
    					availableTags, extractLast( request.term ) ) );
    			},
    			focus: function() {
    				return false;
    			},
    			select: function( event, ui ) {
    				var terms = split( this.value );
    				terms.pop();
    				terms.push( ui.item.value );
    				terms.push( "" );
    				this.value = terms.join( ", " );
    				return false;
    			}
    		}
    	);
	  }
	});
});