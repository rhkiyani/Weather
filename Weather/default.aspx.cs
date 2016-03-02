using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Weather
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void img_button_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect(Request.RawUrl);
        }
    }
}