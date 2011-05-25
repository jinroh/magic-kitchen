steal(
	//	"jquery.min",  <-- ne pas charger jquery après rails.js 
		"underscore", 
		"json2",
		"backbone",
		"ejs"
	//	"ejs_production"
		)
		.then(function(){
			MK = {};
			MK.Models = {};
			MK.Collection = {};
			MK.Views = {};
			//alert("d");
		})
		.models(
			"recipe", 
		//	"like", 
		//	"follower", 
		//	"following", 
		//	"favorite",
			"user",
			"RecipesSearch", //actualy a collection
		//	"history",
			"RecipeHistory" //actually a collection
		)
		.then(
			"views/recipe",
			"views/search"
			)
		.then(function(){
			
			MK.App = {
			    init: function() {
			        // TODO
			       // Backbone.history.start();
					this.Search = new MK.Views.Search();
			    }
			};

		MK.App.init();

		// SEARCH :

		
		$(document).ready( function() {
				$("#q").focus(function() {
					if ( this.value == "Search for what you want to cook...") {
						    this.value = "";  
				}
				});
				$("#q").blur(function() {
						if ( this.value == this.defaultvalue || this.value == "") {
						    this.value = this.defaultValue;
				}
				});
				

				$("#w").focus(function() {
					if ( this.value == "Without") {
						    this.value = "";  
				}
				});
				$("#w").blur(function() {
						if ( this.value == this.defaultvalue || this.value == "") {
						    this.value = this.defaultValue;
				}
				});
				
				$("#search > form").submit(function(){
					try{
					MK.App.Search.initialize();
					MK.App.Search.Recipes.setName($("#q").val());
					var ing = $("#w").val().split(",");
					for(i=0;i<ing.length;i++){
						MK.App.Search.Recipes.addWithoutIngredient({name : ing[i]});
					}
					MK.App.Search.Recipes.search();
				}catch(e){console.log(e)}
					return false;
				});
		});


	$(document).ready( function() {

		$('#up').click(	function() {

			// add lightbox/shadow <div/>'s if not previously added
			if($('#lightbox').size() == 0){
				var theLightbox = $('<div id="lightbox"/>');
				var theShadow = $('<div id="lightbox-shadow"/>');

				$(theShadow).click(function(e){
					closeLightbox();
				});
				$('body').append(theShadow);
				$('body').append(theLightbox);
			}


			// insert HTML content
			$('#lightbox').append($('#inner_content'));


			// move the lightbox to the current window top + 100px
			$('#lightbox').css('top', $(window).scrollTop() + 50 + 'px');

			// display the lightbox
			$('#lightbox-shadow').show();
			$('#lightbox').show();


		});
		});

		// close the lightbox
		function closeLightbox(){

			// hide lightbox and shadow <div/>'s
			$('#lightbox').hide();
			$('#lightbox-shadow').hide();

		}


		//CAROUSSEL :

		$(document).ready(function() {  
				//move the last list item before the first item. The purpose of this is if the user clicks previous he will be able to see the last item.  
				// $('#carousel_ul li:first').before($('#carousel_ul li:last'));  
				

				//when user clicks the image for sliding right  
				$("body").delegate("#right_scroll img", "click", function(){  
		  
				    //get the width of the items ( i like making the jquery part dynamic, so if you change the width in the css you won't have o change it here too ) '  
				    var item_width = $('#carousel_ul li').outerWidth() + 10;  
		  
				    //calculate the new left indent of the unordered list  
				    var left_indent = parseInt($('#carousel_ul').css('left')) - item_width; 

					var right_indent = (($("#carousel_ul").children("li").length-2)*item_width)

		  			if (left_indent >-right_indent) { 

				    //make the sliding effect using jquery's anumate function '  
				    $('#carousel_ul').animate({'left' : left_indent},{queue:false, duration:80},function(){  
				    });}

					else {	
						MK.App.Search.Recipes.loadmore();
					}
			

				});  
		  
				//when user clicks the image for sliding left  
				$("body").delegate("#left_scroll img", "click", function(){  
		  
				    var item_width = $('#carousel_ul li').outerWidth() + 10;  
		  
				    /* same as for sliding right except that it's current left indent + the item width (for the sliding right it's - item_width) */  
				    var left_indent = parseInt($('#carousel_ul').css('left')) + item_width;  
		  			
					if (left_indent <1) { 
				    $('#carousel_ul').animate({'left' : left_indent},{queue:false, duration:80},function(){  
		  
				    }); }
			
		  
				});  
		});  


		$(document).ready(function() {  
				//move the last list item before the first item. The purpose of this is if the user clicks previous he will be able to see the last item.  
				// $('#carousel_ul li:first').before($('#carousel_ul li:last'));  
				

				//when user clicks the image for sliding right  
				$("body").delegate("#right_scroll_cb img", "click", function(){  
		  
				    //get the width of the items ( i like making the jquery part dynamic, so if you change the width in the css you won't have o change it here too ) '  
				    var item_width = $('#carousel_ul_cb li').outerWidth() + 10;  
		  
				    //calculate the new left indent of the unordered list  
				    var left_indent = parseInt($('#carousel_ul_cb').css('left')) - item_width; 

					var right_indent = (($("#carousel_ul_cb").children("li").length-2)*item_width)

		  			if (left_indent >-right_indent) { 
				    //make the sliding effect using jquery's anumate function '  
				    $('#carousel_ul_cb').animate({'left' : left_indent},{queue:false, duration:80},function(){  
				    });  }
			

				});  
		  
				//when user clicks the image for sliding left  
				$("body").delegate("#left_scroll_cb img", "click", function(){  
		  
				    var item_width = $('#carousel_ul_cb li').outerWidth() + 10;  
		  
				    /* same as for sliding right except that it's current left indent + the item width (for the sliding right it's - item_width) */  
				    var left_indent = parseInt($('#carousel_ul_cb').css('left')) + item_width;  
		  			
					if (left_indent <1) { 
				    $('#carousel_ul_cb').animate({'left' : left_indent},{queue:false, duration:80},function(){  
		  
				    }); }
			
		  
				});  
		});  



		// ACCORDION :

		$(document).ready(function() {
			 
			//ACCORDION BUTTON ACTION (ON CLICK DO THE FOLLOWING)
			$("body").delegate(".accordionButton", "click", function() {

				//REMOVE THE ON CLASS FROM ALL BUTTONS
				$('.accordionButton').removeClass('on');
				  
				//NO MATTER WHAT WE CLOSE ALL OPEN SLIDES
			 	$('.accordionContent').slideUp('normal');
		   
				//IF THE NEXT SLIDE WASN'T OPEN THEN OPEN IT
				if($(this).next().is(':hidden') == true) {
			
					//ADD THE ON CLASS TO THE BUTTON
					$(this).addClass('on');
					  
					//OPEN THE SLIDE
					$(this).next().slideDown('normal');
				 } 
				  
			 });
			  
	
			/*** REMOVE IF MOUSEOVER IS NOT REQUIRED ***/
	
			//ADDS THE .OVER CLASS FROM THE STYLESHEET ON MOUSEOVER 
			$("body").delegate(".accordionButton", "mouseover", function() {
				$(this).addClass('over');		
			});

			//ON MOUSEOUT REMOVE THE OVER CLASS
			$("body").delegate(".accordionButton", "mouseout", function() {
				$(this).removeClass('over');										
			});
	
			/*** END REMOVE IF MOUSEOVER IS NOT REQUIRED ***/
	
	
			/********************************************************************************************************************
			CLOSES ALL S ON PAGE LOAD
			********************************************************************************************************************/	
			$('.accordionContent').hide();

		});




		$(document).ready(function() {

			//ACCORDION BUTTON ACTION (ON CLICK DO THE FOLLOWING)

			$("body").delegate(".trigger", "mouseover", function() {

			if($(this).next().is(':hidden') == true) {

				//REMOVE THE ON CLASS FROM ALL BUTTONS
				$('.trigger').removeClass('on');
				  
				//NO MATTER WHAT WE CLOSE ALL OPEN SLIDES
			 	$('.accordContent').slideUp('normal');
		   
				//IF THE NEXT SLIDE WASN'T OPEN THEN OPEN IT
				if($(this).next().is(':hidden') == true) {
			
					//ADD THE ON CLASS TO THE BUTTON
					$(this).addClass('on');
					  
					//OPEN THE SLIDE
					$(this).next().slideDown('normal');
				 } 

			}
			 });

	
			/*** END REMOVE IF MOUSEOVER IS NOT REQUIRED ***/
	
	
			/********************************************************************************************************************
			CLOSES ALL S ON PAGE LOAD
			********************************************************************************************************************/	
			$('.accordContent').hide();

		});


		});



