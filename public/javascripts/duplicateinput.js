(function($) {
    $.fn.autoAddingTextFields = function() {
        var t = $(this);

        var add_field = function() {
            if ($(this).val() == '') return;
            ingredients = t.children('div.ingredient').not(':hidden');
            ingredients.last().children('input[type=text]')
                       .unbind('keydown');
            ingredients.last().clone().appendTo(t)
                       .find('input')
                       .attr('name', function(i, val) {
                          return val.replace(/[(d+)]/, function(match, n) {
                            return '[' + (Number(n) + 1) + ']';
                          });
                        })
                       .attr('id', function(i, val) {
                          return val.replace(/_(d+)_/, function(match, n) {
                            return '_' + (Number(n) + 1) + '_';
                          });
                        })
                       .val('')
                       .keydown(add_field);
            ingredients.last().appendRemoveLink();
            ingredients = t.find('.ingredient').not(':hidden');
        };

        var ingredients = t.find('.ingredient');
        ingredients.not(':last').appendRemoveLink();
        ingredients.last().children('input[type=text]')
                   .keydown(add_field);

        return t;
    }

    $.fn.appendRemoveLink = function() {
        return $(this).each(function() {
            div = $(this);
            $('<a href="#" class="remove">×</a>').click(function() {
                $(this).removeIngredient();
                return false;
            }).appendTo(div);
        });
    }

    $.fn.removeIngredient = function() {
        $(this).siblings('input').val('');
        $(this).parent().hide();
    }
})( jQuery );