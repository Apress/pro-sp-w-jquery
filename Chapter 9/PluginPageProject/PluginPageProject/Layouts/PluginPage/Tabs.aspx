<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tabs.aspx.cs" Inherits="PluginPageProject.Layouts.PluginPage.Tabs"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <SharePoint:CssRegistration ID="CssRegistration1" Name='<% $SPUrl:/_layouts/jQueryUI/css/smoothness/jquery-ui-1.8.css%>'
        runat='server' />
    <script type="text/javascript">

        $(document).ready(function () {
            $('#tabs').tabs();
        });
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <div id="tabs">
        <ul>
            <li><a href="#tasksTab">My Tasks</a></li>
            <li><a href="#recentDocumentsTab">My Recent Documents</a></li>
            <li><a href="#companyNewsTab">Company News</a></li>
        </ul>
        <div id="tasksTab">
                <ul>
                    <li>Task One</li>
                    <li>Task Two</li>
                    <li>Task Three</li>
                    <li>Task Four</li>
                    <li>Task Five</li>
                    <li>Task Six</li>
                </ul>
        </div>
        <div id="recentDocumentsTab">
            <p>
                Recent Documents</p>
        </div>
        <div id="companyNewsTab">
            <p>
                Company News</p>
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
