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
		public string GetReferer(bool ishost)
		{
				if ( Request.UrlReferrer != null)
				{
						return  Request.UrlReferrer.ToString();
				}
				else
				{
						if (ishost)
						{
								return Request.Url.Scheme + "://" + Request.Url.Authority;
						}
						else
						{
								return "";
						}
				}
		}	
		public string orderNo;
    protected void Page_Load(object sender, EventArgs e) {
				orderNo = "";
				//orderNo = "1474953235901";
				string url = GetReferer(false);
				//url = "http://ill.digilib.sh.cn/alipay/return_url.jsp";
				if(!string.IsNullOrEmpty(url))
						url = url.Split('?')[0];
				//Page.Response.Write(url);
				if(!string.IsNullOrEmpty(Request.Form["orderNo"]) && string.IsNullOrEmpty(Request["token"]) && "http://ill.digilib.sh.cn/alipay/return_url.jsp".Equals(url))
				{
						orderNo = Request.Form["orderNo"];
						Response.Redirect("receipt.aspx?token="+orderNo);
				}
		}
}