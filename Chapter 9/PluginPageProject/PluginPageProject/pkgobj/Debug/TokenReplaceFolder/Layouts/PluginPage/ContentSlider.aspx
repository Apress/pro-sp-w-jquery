<%@ Assembly Name="PluginPageProject, Version=1.0.0.0, Culture=neutral, PublicKeyToken=3d13da4dd2c932fd" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContentSlider.aspx.cs"
    Inherits="PluginPageProject.Layouts.PluginPage.ContentSlider" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link href="/_Layouts/PluginPage/Plugins/jquery.aw-showcase/css/style.css" rel="stylesheet" type="text/css" />
    <script src="/_Layouts/PluginPage/Plugins/jquery.aw-showcase/jquery.aw-showcase.min.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#slideTemplate').hide();
            ExecuteOrDelayUntilScriptLoaded(GetFruits, "sp.js");
        });

        var fruits;

        function GetFruits() {
            try {

                // Get the context
                var context = new SP.ClientContext.get_current();

                // Load the web object   
                this.web = context.get_web();

                //Get the 'Fruits' list
                var list = this.web.get_lists().getByTitle('Fruits');

                // Get all the items in the list
                fruits = list.getItems('');

                // Load the web in the context and retrieve only selected columns                       
                context.load(this.fruits, 'Include(FileRef,Information)');

                //Make a query call to execute the above statements
                context.executeQueryAsync(Function.createDelegate(this, this.GetFruitsOnSuccess), Function.createDelegate(this, this.GetFruitsOnFailure));
            }
            catch (e) {
                alert("An error occurred while fetching data.");
            }
        }

        function GetFruitsOnSuccess() {
            // Get the collection
            var fruitCollection = this.fruits.getEnumerator();

            // Iterate through places
            while (fruitCollection.moveNext()) {
                // Get current item
                var fruit = fruitCollection.get_current();

                // Clone the Content Slide Template
                var newSlide = $('#slideTemplate').clone();

                // Remove the id
                $(newSlide).prop('id', null);
                
                // Set the Image source to the Fruit image FileRef
                $(newSlide).find('.myImage').prop('src', fruit.get_item('FileRef'));
                
                // Set the Caption text
                $(newSlide).children('.showcase-caption').text(fruit.get_item('Information'));
                
                // Show the element as template is hidden
                $(newSlide).show();

                // Add the Content Slide to the Content Slider
                $('#showcase').append(newSlide);
            }

            // Call the plugin on the Content Slider
            $("#showcase").awShowcase({
                content_width: 700,
                content_height: 470
            });
        }

        function GetFruitsOnFailure() {
            alert("An error occurred while fetching data.");
        }
        
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <!-- Content Slider Container -->
    <div id="showcase" class="showcase">
    </div>
    <!-- Content Slide Template -->
    <div id="slideTemplate" class="showcase-slide">
        <div class="showcase-content">
            <div class="showcase-content-wrapper">
                <img class='myImage' src="" alt="" />
            </div>
        </div>
        <div class="showcase-caption">
        </div>
    </div>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    Application Page
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My Application Page
</asp:Content>
