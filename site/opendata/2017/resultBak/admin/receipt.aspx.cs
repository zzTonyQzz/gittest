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

	public string hqxuNo;
	public string USER = "";
	public string PWD = "";
    protected void Page_Load(object sender, EventArgs e) {
				
				hqxuNo = Request["token"];
				if(Request["username"]=="admin"&&Request["pwd"]=="64376235"){
						USER = Request["username"];	
						PWD = Request["pwd"];	
				}else{
					Response.Redirect("http://pcrc.library.sh.cn/zt/opendata/2017/result/receipt.aspx?token="+hqxuNo);
				}
		}
}