<%@ Assembly Name="myjQueryNews, Version=1.0.0.0, Culture=neutral, PublicKeyToken=4309d3960ab7a21b" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="MyNewsWebPartUserControl.ascx.cs" Inherits="myjQueryNews.MyNewsWebPart.MyNewsWebPartUserControl" %>
<script type="text/javascript" src="_wpresources/myNewsWebPart/1.0.0.0__d423462d89d62895/scripts/jQueryNewsScript.js"></script>
<link href="_wpresources/myNewsWebPart/1.0.0.0__d423462d89d62895/styles/NewsStyleSheet.css" rel="stylesheet" type="text/css" />

<!-- Id to hold the articles loaded by the Web Service-->
<div id="News" />

<!-- News Story Template -->
<div id="NewsStory-Template" class="NewsStory" style="display: none">
    <h2></h2>
    <div class="NewsArticle" style="display: none" />
</div>
