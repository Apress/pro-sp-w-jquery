$(document).ready(function () {
    // Get the Quick Launch Menu Items
    var menuItems = $('#zz17_V4QuickLaunchMenu>div>ul>li>ul')

    // Hide the Items
    menuItems.hide();

    // create element for expand\collapse icon
    // float left to keep it inline
    // Add expandCollapseMe class to use to add event handler later
    // use existing SharePoint image as image
    var expandCollapseButtonElement = $('<img style="float:left" style="cursor:hand" class="expandCollapseMe" src="/_layouts/images/TPMax2.gif">');

    // Add the new button to all menu items
    menuItems.siblings('a').before(expandCollapseButtonElement);

    // When Element is clicked
    // use on() for 1.7 or live() for 1.6
    $('.expandCollapseMe').on('click', function () {
        // Get the list contained the sub items
        var subItemMenu = $(this).siblings('ul');

        // Check Visibility
        if ($(subItemMenu).is(':visible')) {

            // Hide all items
            subItemMenu.hide();

            // Update Expand\Collapse image to Expand
            $(this).prop('src', '/_layouts/images/TPMax2.gif');
        } else {

            // Show all items
            subItemMenu.show();

            // Update Expand\Collapse image to Collapse
            $(this).prop('src', '/_layouts/images/TPMin2.gif');
        }
    });
});