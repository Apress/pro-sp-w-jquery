<%@ Assembly Name="jQueryTaskViewerApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=1561419465dfbf90" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jQueryTaskViewer.aspx.cs"
    Inherits="jQueryTaskViewerApplication.Layouts.jQueryTaskViewerApplication.jQueryTaskViewer"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <link href="style.css" rel="stylesheet" type="text/css" />
    <script src="jQueryTaskViewerScript.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <div id="newTaskDiv">
        <input id="newTaskTitle" class="newTask" type="text" maxlength="50" />
        <input type="button" class="newTask" id="addTaskButton" value="Add New Task" />
    </div>
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
            <div class="deleteDiv">
                <span class="deleteButton delete">x</span> <span class="confirmDelete" style="display: none">
                    Are you sure?<span class="yesDeleteButton delete">Yes</span><span class="noDeleteButton delete">No</span></span>
            </div>
            <div class="taskDetailDiv">
                <p class='taskTitle'>
                    Title</p>
                <p class='taskDescription'>
                    Description</p>
            </div>
            <div class="editDiv" style="display: none">
                <p>
                    <input class="editTaskTitle edit" type="text" maxlength="50" />
                </p>
                <p>
                    <textarea class="editTaskDescription edit" rows="4" cols="30"></textarea></p>
                <span class="editTaskSaveButton editButton">Save</span> <span class="editTaskCancelButton editButton">
                    Cancel</span>
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
