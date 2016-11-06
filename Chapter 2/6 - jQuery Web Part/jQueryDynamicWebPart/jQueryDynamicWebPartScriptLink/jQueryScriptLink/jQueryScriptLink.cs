using System;
using System.ComponentModel;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint.WebControls;

namespace jQueryDynamicWebPartScriptLink.jQueryScriptLink
{
    [ToolboxItem(false)]
    public class jQueryScriptLink : WebPart
    {
        protected override void OnPreRender(EventArgs e)
        {
            // Register Script to page
            ScriptLink.Register(Page, "jQuery/jquery.js", false);
            base.OnPreRender(e);
        }
    }
}