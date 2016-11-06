(function ($) {

    $.latestListData = function (listName, options) {

        // Merge user entered options with default options
        this.userOptions = $.extend({}, $.latestListData.defaultOptions, options);

        // Get the current context
        this.context = new SP.ClientContext.get_current();

        // Load the web object   
        this.web = this.context.get_web();

        // Get the list
        this.list = this.web.get_lists().getByTitle(listName);

        // Get the latest created items but limit to user provided
        // row count
        var query = '<View>' +
                    '<RowLimit>' + this.userOptions.rowCount + '</RowLimit>' +
                    '<Query>' +
                        '<OrderBy>' +
                            '<FieldRef Name="Created" Ascending="False" />' +
                        '</OrderBy>' +
                    '</Query>' +
                    '</View>';

        // Build Caml Query
        var camlQuery = new SP.CamlQuery();
        camlQuery.set_viewXml(query);

        // Get all the items in the list matching query
        this.listItems = this.list.getItems(camlQuery);

        // Load items but only get columns supplied by user
        this.context.load(this.listItems, 'Include(' + this.userOptions.fieldNames.join(',') + ')');

        var success = Function.createDelegate(this, getLoadListItemsSuccess);
        var failure = Function.createDelegate(this, this.userOptions.onError);

        //Make a query call to execute the above statements
        // On success go to private method, otherwise call passed in function
        this.context.executeQueryAsync(success, failure);
    };

    // Callback from Client Object Model
    function getLoadListItemsSuccess() {
        var base = this;

        // Variable for list data
        var data = [];

        // Get the collection
        var itemCollection = this.listItems.getEnumerator();

        // Iterate through items
        while (itemCollection.moveNext()) {

            // Load the current item in iteration
            var item = itemCollection.get_current();

            // Create new object to hold item information
            var newItem = {};

            // Iterate through each user defined field
            $(base.userOptions.fieldNames).each(function () {
                // Set property of item based on list item
                newItem[this] = item.get_item(this);
            });

            // Add Item to the data array
            data.push(newItem);

        }

        // Call the users function passing in retrieved data
        base.userOptions.onSuccess.call(this, data);
    }

    // Create Default Success Method
    $.latestListData.onGetItemsSuccess = function (data) {
        var base = this;
        
        var listInformation = "";

        // Iterate through each item to build a list
        // of items in the SharePoint List
        $(data).each(function () {

            var item = this;

            // Iterate through each user defined field
            $(base.userOptions.fieldNames).each(function () {
                // Set property of item based on list item
                listInformation += this + ": " + item[this] + "\n";
            });
            listInformation += "\n";
        });

        alert(listInformation);
    };

    // Error handler
    $.latestListData.onGetItemsFailed = function (sender, args) {
        alert('Request failed. ' + args.get_message() + '\n' + args.get_stackTrace());
    };

    // Define default values for the plugin
    $.latestListData.defaultOptions = {
        rowCount: 3,
        fieldNames: ['Title'],
        onSuccess: $.latestListData.onGetItemsSuccess,
        onError: $.latestListData.onGetItemsFailed
    };

})(jQuery);

