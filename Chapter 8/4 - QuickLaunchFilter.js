$(document).ready(function () {
    QuickLaunchFilter();
});

function QuickLaunchFilter() {
    // Select the QuickLaunch Div
    var div = $('#zz17_V4QuickLaunchMenu>div');

    // Find all of the Subitems in the menu
    var menuItems = div.find('ul>li>ul>li')

    // Create Textbox to perform the filtering
    var tb = $('<input type="text" name="find" />');

    // Attach handler on the key up event
    tb.keyup(function () {
        
        // Read the text boxes value
        var typedText = $(this).val();

        // find all of the spans which contain the entered text
        // The 'contains' method is Case Sensitive
        var matching = menuItems.find('span.menu-item-text:contains("' + typedText + '")');
        
        // Hide all of the menu items first
        menuItems.hide();

        // Show the list item for span which contain
        // the matching text
        matching.closest('li').show();
    });

    // Add the textbox as the first item
    // in the div element
    div.children(':first').before(tb);
}