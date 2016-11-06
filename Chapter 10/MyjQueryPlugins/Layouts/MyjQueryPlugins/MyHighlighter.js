(function ($) {
    $.fn.myHighlighter = function () {

        // 'this' does not need to be wrapped here
        // return collection after
        return this.each(function () {

            // 'this' now refers to the element and needs
            // to be wrapped as a jQuery object
            var $this = $(this);

            // Add some highlighting css
            $this.css('border', 'solid 1px red');
            $this.css('color', 'red');
            $this.css('padding', '0.3em');
        });
    };
})(jQuery);