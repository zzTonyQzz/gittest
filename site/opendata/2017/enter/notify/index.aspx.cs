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
using System.Net;
 
public partial class index: System.Web.UI.Page {
	public string USER = "";
	public string PWD = "";
	public string smsUrl = "";
	public string mailUrl = "";
    protected void Page_Load(object sender, EventArgs e) {
		if(Request.Form["username"]=="admin"&&Request.Form["pwd"]=="64376235"){
			USER = Request.Form["username"];	
			PWD = Request.Form["pwd"];	
			smsUrl = "";
			mailUrl = "";
		}
	}
}