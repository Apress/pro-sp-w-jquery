<%@ Assembly Name="PluginPageProject, Version=1.0.0.0, Culture=neutral, PublicKeyToken=3d13da4dd2c932fd" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Effects.aspx.cs" Inherits="PluginPageProject.Layouts.PluginPage.Effects"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <!-- Register jQuery UI CSS -->
    <SharePoint:CssRegistration ID="CssRegistration1" Name='<% $SPUrl:/_layouts/jQueryUI/css/smoothness/jquery-ui-1.8.css%>'
        runat='server' />
    <!-- Styling the Div -->
    <style type="text/css">
        .effectDiv
        {
            height: 50px;
            width: 50px;
            border: crimson 4px solid;
            margin: 10px;
            padding: 0.3em;
            position: relative;
        }
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            // Attach click event handler
            $('.effectDiv').click(function () {

                // Get the effect name from the id
                var currentEffect = $(this).prop('id');

                // Apply the effect for 500 ms
                $(this).effect(currentEffect, 500);
            });
        });       
        
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <div class="effectDiv" id="blind">
        Blind
    </div>
    <div class="effectDiv" id="bounce">
        Bounce
    </div>
    <div class="effectDiv" id="clip">
        Clip
    </div>
    <div class="effectDiv" id="drop">
        Drop
    </div>
    <div class="effectDiv" id="explode">
        Explode
    </div>
    <div class="effectDiv" id="fade">
        Fade
    </div>
    <div class="effectDiv" id="fold">
        Fold
    </div>
    <div class="effectDiv" id="highlight">
        Highlight
    </div>
    <div class="effectDiv" id="puff">
        Puff
    </div>
    <div class="effectDiv" id="pulsate">
        Pulsate
    </div>
    <div class="effectDiv" id="shake">
        Shake
    </div>
    <div class="effectDiv" id="slide">
        Slide
    </div>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    Application Page
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My Application Page
</asp:Content>
