using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text.RegularExpressions;
using System.Web.Configuration;
using System.Net.Mail;
using System.Net;
using System.Data.SqlClient;
 
public partial class index: System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        DateTime d1;
        d1 = DateTime.Now;
        DateTime d2;
        //d2 = new DateTime(2016,8,15,9,0,0);
        d2 = new DateTime(2017, 5, 1, 0, 0, 0);
        TimeSpan ts4, ts5;
        ts4 = d2 - d1;

        if (ts4.Minutes < 0)
        {
            Response.Redirect("deadline/", true);
        }
        else
        {
            //
        }
    }
}