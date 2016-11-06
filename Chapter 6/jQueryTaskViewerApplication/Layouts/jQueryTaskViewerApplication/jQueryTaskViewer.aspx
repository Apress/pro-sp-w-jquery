<%@ Assembly Name="$SharePoint.Project.AssemblyFullName$" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jQueryTaskViewer.aspx.cs"
    Inherits="jQueryTaskViewerApplication.Layouts.jQueryTaskViewerApplication.jQueryTaskViewer"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script src="jQueryTaskViewerScript.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <!-- Task Content -->
    <div id="taskContent">
        <!-- Not Started Tasks -->
        <div id="notStartedTasksColumn" class="taskColumn">
            <h3>
                Not Started</h3>
            <div class="taskDiv" id="notStartedTasksDiv">
                <ul />
            </div>
        </div>
        <!-- In Progress Tasks -->
        <div id="inProgressTasksColumn" class="taskColumn">
            <h3>
                In Progress</h3>
            <div class="taskDiv" id="inProgressTasksDiv">
                <ul />
            </div>
        </div>
        <!-- Completed Tasks -->
        <div id="completedTasksColumn" class="taskColumn">
            <h3>
                Completed</h3>
            <div class="taskDiv" id="completedTasksDiv">
                <ul />
            </div>
        </div>
    </div>
    <!-- 
    Template for Task List Items
Wrapped in UL to make it eaiser to design,
Style added to make it not show on page
-->
    <ul class='hiddenTemplate'>
        <li id="TemplateListItem" class="task">
            <div class="taskDetailDiv">
                <p class='taskTitle'>
                    Title</p>
                <p class='taskDescription'>
                    Description</p>
            </div>
            <div class="moveButtonsDiv">
                <img class="moveLeftButton moveButton" src="/_layouts/images/ARRLEFTA.GIF" alt="Move Left" />
                <img class="moveRightButton moveButton" src="/_layouts/images/ARRRIGHTA.GIF" alt="Move Right" />
            </div>
        </li>
    </ul>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    Task Viewer
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My jQuery Task Viewer
</asp:Content>
