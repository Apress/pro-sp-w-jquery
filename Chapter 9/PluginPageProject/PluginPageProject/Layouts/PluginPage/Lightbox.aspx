<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Lightbox.aspx.cs" Inherits="PluginPageProject.Layouts.PluginPage.Lightbox"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link href="Plugins/Lightbox/css/jquery.lightbox-0.5.css" rel="stylesheet" type="text/css" />
    <script src="Plugins/Lightbox/js/jquery.lightbox-0.5.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            $('#FruitGallery a').lightBox(); // Select all links in object with FruitGallery ID

        });
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <div id="FruitGallery">
        <div>
            <a href="/Fruits/apple_large.png">
                <img src="/Fruits/apple_small.png" width="72" height="72" alt="" /></a></div>
        <div>
            <a href="/Fruits/kiwi_large.png">
                <img src="/Fruits/kiwi_small.png" width="72" height="72" alt="" /></a></div>
        <div>
            <a href="/Fruits/lemon_large.png">
                <img src="/Fruits/lemon_small.png" width="72" height="72" alt="" /></a></div>
        <div>
            <a href="/Fruits/pear_large.png">
                <img src="/Fruits/pear_small.png" width="72" height="72" alt="" /></a></div>
        <div>
            <a href="/Fruits/watermelon_large.png">
                <img src="/Fruits/watermelon_small.png" width="72" height="72" alt="" /></a></div>
    </div>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    Fruit Lightbox Page
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My Fruit Lightbox Page
</asp:Content>
