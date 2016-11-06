(function ($) {
    $.fn.myGrapher = function (columnName, options) {

        // Merge user entered options with default options
        options = $.extend({}, $.fn.myGrapher.defaultOptions, options);

        // Iterate and return selected elements
        return this.each(function () {
            // Graph each Table
            $.fn.myGrapher.graph($(this), columnName, options);
        });
    };

    // Define default values for the plugin
    $.fn.myGrapher.defaultOptions = {
        belowAverageColor: 'red',
        averageColor: 'orange',
        aboveAverageColor: 'green',
        fontColor: 'white'
    };

    // Defines graph function if user wants to use it directly
    $.fn.myGrapher.graph = function (element, columnName, options) {

        // Get the column based onthe fact the SharePoint stores the name in a Display Name
        // Attribute. Use Parent Index to get the column number
        var columnIndex = element.find('div[DisplayName="' + columnName + '"').parent().index();

        // Change from zero based index to 1
        // for use with nth-child
        var columnNumber = columnIndex + 1;

        // Get all of the Table Cells in the requested column by index
        var tableCells = element.find('tr.ms-itmhover>td:nth-child(' + columnNumber + ')');

        // Array to help work out the average value
        var numbers = [];

        // Iterate through each unit sold value
        tableCells.each(function () {
            if ($(this).text() != "") {
                var number = parseInt($(this).text());
                numbers.push(number);
            }
        });

        // Get the most popular product unit count using
        // JavaScript method on the numbers array
        var largest = Math.max.apply(Math, numbers);

        // Iterate through each Table Cell for item
        tableCells.each(function () {

            // Create a new empty div
            var div = $('<div/>');

            // get the number of the table cell
            var number = parseInt($(this).text());

            // Work out the average compared to largest
            // number of units sold
            var average = parseInt(number / largest * 100);

            // Set CSS properties on the new div
            div.css('font-weight', 'bolder');
            div.css('color', options.fontColor);

            // Set width to average % to give
            // div a graph look
            div.css('width', average + '%');

            // Switch to set color based on
            // Comparison to the average
            switch (true) {
                case (average >= 75):
                    div.css('background-color', options.aboveAverageColor);
                    break;
                case (average >= 25):
                    div.css('background-color', options.averageColor);
                    break;
                default: div.css('background-color', options.belowAverageColor);
                    break;
            }

            // Wrap the existing contents of the td
            // with the new formatted div
            $(this).wrapInner(div);
        });
    };

})(jQuery);