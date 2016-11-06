<%@ Assembly Name="PluginPageProject, Version=1.0.0.0, Culture=neutral, PublicKeyToken=3d13da4dd2c932fd" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Widgets.aspx.cs" Inherits="PluginPageProject.Layouts.PluginPage.Widgets"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <SharePoint:CssRegistration ID="CssRegistration1" Name='<% $SPUrl:/_layouts/jQuery/css/smoothness/jquery-ui-1.8.css%>'
        runat='server' />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#myButton').button();
            $('#myProgressbar').progressbar({
                value: 84
            });
            $('#mySlider').slider();
            $('#myDatePicker').datepicker();
        });
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <div>
        <h3>
            Button</h3>
        <div>
            <a id="myButton">Anchor Button</a></div>
        <h3>
            Progress Bar</h3>
        <div>
            <div id="myProgressbar">
            </div>
        </div>
        <h3>
            Slider</h3>
        <div>
            <div id="mySlider">
            </div>
        </div>
        <h3>
            Date Picker</h3>
        <div>
            <input type="text" id="myDatePicker" /></div>
    </div>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    Application Page
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My Application Page
</asp:Content>
