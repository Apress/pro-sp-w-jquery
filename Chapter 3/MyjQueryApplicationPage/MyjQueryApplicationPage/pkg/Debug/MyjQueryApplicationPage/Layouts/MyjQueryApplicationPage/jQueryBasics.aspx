<%@ Assembly Name="MyjQueryApplicationPage, Version=1.0.0.0, Culture=neutral, PublicKeyToken=eb7dd59c9f27deac" %>
<%@ Import Namespace="Microsoft.SharePoint.ApplicationPages" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls"
    Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="asp" Namespace="System.Web.UI" Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Assembly Name="Microsoft.Web.CommandUI, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jQueryBasics.aspx.cs" Inherits="MyjQueryApplicationPage.Layouts.MyjQueryApplicationPage.jQueryBasics"
    DynamicMasterPageFile="~masterurl/default.master" %>

<asp:Content ID="PageHead" ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#liTwo').children().andSelf().css('background-color', 'lightgrey');

            $('#myListItem').add('#myParagraph').css('background-color', 'lightblue');
        });

    </script>
</asp:Content>
<asp:Content ID="Main" ContentPlaceHolderID="PlaceHolderMain" runat="server">
    <ol>
        <li id="myListItem">Item One</li>
        <li id="liTwo">Item Two
            <ul>
                <li>Item Two Level two </li>
            </ul>
        </li>
        <li id="liThree">Item Three
            <ul>
                <li>Item Two Level two </li>
            </ul>
        </li>
    </ol>

    <p id="myParagraph">I am some text</p>
</asp:Content>
<asp:Content ID="PageTitle" ContentPlaceHolderID="PlaceHolderPageTitle" runat="server">
    jQuery Basics
</asp:Content>
<asp:Content ID="PageTitleInTitleArea" ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea"
    runat="server">
    My jQuery Basics Page
</asp:Content>
