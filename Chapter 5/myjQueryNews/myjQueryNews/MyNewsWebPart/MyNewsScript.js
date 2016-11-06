$(document).ready(function () {

    // Load News Articles
    LoadAllNewsArticles();

    // Bind the click event of the News Header to load the article
    $('.NewsStory>.NewsStoryHeader').live('click', function () {
        var article = $(this).find('.NewsArticle');

        // If News Story is visible then hide it
        if (article.is(':visible')) {
            article.hide();
        } else {
            // If the News Article has not been loaded then load it
            if (article.is(':empty')) {
                // Load the article, pass in the article element
                LoadArticle(article);
            }

            // Hide all of the other articles
            $('.NewsArticle').hide();

            // Show the News Article
            article.show();
        }

    });
});

function LoadAllNewsArticles() {
    // URL of the List Data Web Service being passed in the list name News
    var taskUrl = "/_vti_bin/ListData.svc/News/";

    // Use Ajax method to call Web Service
    $.ajax({
        type: "GET",
        url: taskUrl,
        dataType: 'json',
        success: function (data) {

            //Iterate through each News Item returned
            $.each(data.d.results, function (i, result) {

                // Clone the hidden Template News Story
                var newsClone = $('#NewsStory-Template').clone();

                // Remove ID as not needed and don't want duplicats
                newsClone.removeAttr('id');

                // Set the text of the H2 element to the Title of the news story
                newsClone.find('.NewsStoryHeader').text(result.Title);

                // Stored the News Item id into the jQuery Data object of the element
                newsClone.data("articleId", result.Id);

                // Show the Element as the template is hidden by default
                newsClone.show();

                // Append the News Story to the News Div
                $('#News').append(newsClone);
            });
        },
        error: function () {
            alert("Error");
        }
    });
}

function LoadArticle(articleElement) {
    // Retrieve the Article ID from the parent element Data object
    var id = articleElement.parent().data("articleId");

    // Build the URL to retrieve the Body of the news story
    var taskUrl = "/_vti_bin/ListData.svc/News(" + id + ")/Body";

    // Use the GetJson Method to obtain the Body form the RestFul Web Service 
    $.getJSON(taskUrl, function (data) {
        // Apend the Article body to the Article Element which was passed in as a parameter
        articleElement.append($(data.d.Body));
    });
}
