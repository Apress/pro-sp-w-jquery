/*

This file contains two examples, once you have seen example 1
then comment out the code and uncomment example 2

*/

///////////////////////
// Example 1 - Clicking the image will toggle between the two
///////////////////////

$(document).ready(function () {
    // Bind toggle event to the img element with name #myFruitImage
    // Each click will alternative between the two methods SetAppleImage and SetLemonImage
    $('#myFruitImage').toggle(SetAppleImage, SetLemonImage);
});
function SetAppleImage() {
    // Call the Set Image method passing in Apple image name
    SetImage("apple_small.png");
}
function SetLemonImage() {
    // Call the Set Image method passing in Lemon image name
    SetImage("lemon_small.png");
}
function SetImage(imageName) {
    // Call the Set Image method passing in Apple image name
    $('#myFruitImage').attr("src", "Fruits/" + imageName);
}

///////////////////////
// Example 2 - Images will rotate on the timer
///////////////////////

/*

// Global variable to track current fruit index
var currentFruit = 0;

$(document).ready(function () {

    // Check to make sure Fruits array has been created
    if (typeof Fruits != "undefined") {

        // Get the first fruit
        GetFruit();

        // Get timer to call the GetFruit method every 3 seconds
        setInterval('GetFruit()', 3000);
    } else {
        // Set imgage to the error image from the Layouts folder
        $('#myFruitImage').attr("src", "_LAYOUTS/1033/IMAGES/ERROR.GIF");
        alert("Fruits array is undefined");
    }

});

function GetFruit() {

    // If at the end of the Array then start again from 0
    if (currentFruit == Fruits.length - 1) {
        currentFruit = 0;
    }

    // Update the src attribute with the path to the fruit image
    $('#myFruitImage').attr("src", "~/Fruits/" + Fruits[currentFruit]);

    // Increment current fruit so next time it gets the next item
    currentFruit++;
}

*/