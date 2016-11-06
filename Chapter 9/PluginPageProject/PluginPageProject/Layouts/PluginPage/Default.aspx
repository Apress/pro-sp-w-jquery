<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PluginPageProject.Layouts.PluginPageProject.Default"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <SharePoint:CssRegistration Name='<% $SPUrl:/_layouts/jQueryUI/css/smoothness/jquery-ui-1.8.css%>'
        runat='server' />
    <script type="text/javascript">

        $(document).ready(function () {
            $("#MyVisitedPlaces").sortable({
                update: function (event, ui) {
                    // Retrieves list of item IDs in order
                    var placeArray = $(this).sortable('toArray');

                    // Pass the array to update method
                    UpdateData(placeArray);
                }
            });

            ExecuteOrDelayUntilScriptLoaded(GetPlaces, "sp.js");
        });

        // Global variable to hold places
        var places;
        var placeNames = new Array();

        function GetPlaces() {
            try {

                // Get the context
                var context = new SP.ClientContext.get_current();

                // Load the web object   
                this.web = context.get_web();

                //Get the 'Places Visited' list
                var list = this.web.get_lists().getByTitle('Places Visited');

                // Create new Caml Query
                var camlQuery = new SP.CamlQuery();

                //Set the CAML-Query-XML to sorty by Order Visited
                camlQuery.set_viewXml("<Query><OrderBy><FieldRef Name='Order_x0020_Visited' /></OrderBy></Query>");

                // Get all the items in the list
                places = list.getItems(camlQuery);

                // Load the web in the context and retrieve only selected columns                       
                context.load(this.places, 'Include(ID, Title, Order_x0020_Visited)');

                //Make a query call to execute the above statements
                context.executeQueryAsync(Function.createDelegate(this, this.GetPlacesOnSuccess), Function.createDelegate(this, this.GetPlacesOnFailure));
            }
            catch (e) {
                alert("An error occurred while fetching data.");
            }
        }

        function GetPlacesOnSuccess() {
            // Get the collection
            var placeCollection = this.places.getEnumerator();

            // Iterate through places
            while (placeCollection.moveNext()) {
                // Get current item
                var place = placeCollection.get_current();

                // Create new element html
                var listItemHtml = '<li>' + place.get_item('Title') + '</li>';

                // Add place names to the array
                placeNames.push(place.get_item('Title'));

                // Create new element using html
                var listItem = $(listItemHtml);

                // Set the ID
                listItem.prop('id', "Place_" + place.get_item('ID'));

                // Add Order Visited data
                listItem.data('listId', place.get_item('ID'));

                // Add Item to list
                $('#MyVisitedPlaces').append(listItem);
            }

            $("#placeNames").autocomplete({
                source: placeNames,
                select: function (event, ui) {
                    // Get the selected value
                    var selectedValue = ui.item.value;

                    // Remove highlight class from all elements
                    $('#MyVisitedPlaces>li').removeClass('ms-rteStyle-Highlight');

                    // Add highlight class for matching element
                    $('#MyVisitedPlaces>li:contains(' + selectedValue + ')').addClass('ms-rteStyle-Highlight');
                }
            });
        }

        function GetPlacesOnFailure() {
            alert("An error occurred while fetching data.");
        }

        function UpdateData(placeArray) {

            // Get the context
            var context = new SP.ClientContext.get_current();

            // Load the web object   
            this.web = context.get_web();

            //Get the 'Places Visited' list
            var list = this.web.get_lists().getByTitle('Places Visited');

            // Iterate through each item in the place array
            $.each(placeArray, function (index, element) {
                // Get the list item for the current element using the id
                var placeListId = $("#MyVisitedPlaces").children('#' + element).data('listId');

                // get the List Item using the ID
                var placeItem = list.getItemById(placeListId);

                // Set the Order Visited column to Index + 1
                // Using + 1 so it starts from 1 and not 0
                placeItem.set_item('Order_x0020_Visited', index + 1);

                // Call update on changes
                placeItem.update();
            });

            // Execute query
            context.executeQueryAsync(Function.createDelegate(this, this.OnUpdatePlaceOrderSuccess), Function.createDelegate(this, this.OnUpdatePlaceOrderFailure));
        }

        function OnUpdatePlaceOrderSuccess() {
            console.log("Place order updated successfully.");
        }

        function OnUpdatePlaceOrderFailure() {
            alert("Error occured whilst updating place order.");
        }
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <input id="placeNames" />
    <ol id="MyVisitedPlaces" />
    <!-- Container Div for the plugin -->
    <div id="showcase" class="showcase">
        <!-- Each child div in #showcase represents a slide -->
        <div class="showcase-slide">
            <!-- Put the slide content in a div with the class .showcase-content -->
            <div class="showcase-content">
                <!-- If the slide contains multiple elements you should wrap them in a div with the class
            .showcase-content-wrapper. We usually wrap even if there is only one element,
            because it looks better. -->
                <div class="showcase-content-wrapper">
                    <img src="" alt="" />
                </div>
            </div>
            <!-- Put the caption content in a div with the class .showcase-caption -->
            <div class="showcase-caption">
                The Caption
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    My Plugin Page
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My Plugin Page
</asp:Content>
