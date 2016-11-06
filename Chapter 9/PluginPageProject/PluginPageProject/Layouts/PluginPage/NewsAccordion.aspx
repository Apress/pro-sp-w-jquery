<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsAccordion.aspx.cs"
    Inherits="PluginPageProject.Layouts.PluginPage.NewsAccordion" DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <SharePoint:CssRegistration ID="CssRegistration1" Name='<% $SPUrl:/_layouts/jQuery/css/smoothness/jquery-ui-1.8.css%>'
        runat='server' />
    <script type="text/javascript">

        $(document).ready(function () {
            $('#tabs').tabs();
        });
    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
        <div id="tabs">
            <ul style="overflow: hidden">
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
    News Accordion Page
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My News Accordion Page
</asp:Content>
