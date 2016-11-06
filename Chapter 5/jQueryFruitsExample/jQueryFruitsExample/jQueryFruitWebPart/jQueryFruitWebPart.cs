using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Web.UI;
using System.Web.UI.WebControls.WebParts;
using Microsoft.SharePoint;

namespace jQueryFruitsExample.jQueryFruitWebPart
{
    [ToolboxItemAttribute(false)]
    public class jQueryFruitWebPart : WebPart
    {
        // Visual Studio might automatically update this path when you change the Visual Web Part project item.
        private const string _ascxPath = @"~/_CONTROLTEMPLATES/jQueryFruitsExample/jQueryFruitWebPart/jQueryFruitWebPartUserControl.ascx";

        protected override void CreateChildControls()
        {
            Control control = Page.LoadControl(_ascxPath);
            Controls.Add(control);
        }

        protected override void OnLoad(EventArgs e)
        {
            base.OnPreRender(e);
            LoadFruitArray();
        }

        private void LoadFruitArray()
        {
            // Get the Page Client Script Manager
            var cs = Page.ClientScript;

            // Try and get the Fruit List from the current Web
            var fruitList = SPContext.Current.Web.Lists.TryGetList("Fruits");

            // If list not found then return
            if (fruitList == null) return;

            var fruits = new List <string>();

            // Query to select just the image names from the list with _small in the name
            var query = new SPQuery
            {
                Query = "<Where>" +
                "<Contains>" +
                "<FieldRef Name='NameOrTitle' />" +
                "<Value Type='Text'>_small</Value>" +
                "</Contains>" +
                "</Where>",
                ViewFields = "<FieldRef Name='NameOrTitle' />",
                ViewFieldsOnly = true
            };

            var fruitListItems = fruitList.GetItems(query); 

            // Iterate through each list item
            foreach (SPListItem item in fruitListItems)
            {
                // Add the Item Name i.e. 'apple_small.jpg'
                fruits.Add(string.Format("'{0}'", item.Name));
            }

            // Combine all array elements as comma delimited
            var fruitItems = string.Join(",", fruits.ToArray());

            // Register Fruit array to the page Client Script Manager
            cs.RegisterArrayDeclaration("Fruits", fruitItems);
        }

    }
}
