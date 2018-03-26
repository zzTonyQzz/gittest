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
	/// <summary>
    /// 过滤标记
    /// </summary>
    /// <param name="NoHTML">包括HTML，脚本，数据库关键字，特殊字符的源码 </param>
    /// <returns>已经去除标记后的文字</returns>
    public static string NoHTML(string Htmlstring)
    {
        if (Htmlstring == null)
        {
            return "";
        }
        else
        {
            //删除脚本
            Htmlstring = Regex.Replace(Htmlstring, @"<script[^>]*?>.*?</script>", "", RegexOptions.IgnoreCase);
            //删除HTML
            Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"([\r\n])[\s]+", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"-->", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"<!--.*", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(quot|#34);", "\"", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(amp|#38);", "&", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(lt|#60);", "<", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(gt|#62);", ">", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(nbsp|#160);", " ", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(iexcl|#161);", "\xa1", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(cent|#162);", "\xa2", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(pound|#163);", "\xa3", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&(copy|#169);", "\xa9", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, @"&#(\d+);", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "xp_cmdshell", "", RegexOptions.IgnoreCase);

            //删除与数据库相关的词
            Htmlstring = Regex.Replace(Htmlstring, "select", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "insert", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "delete from", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "count''", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "drop table", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "truncate", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "asc", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "mid", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "char", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "xp_cmdshell", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "exec master", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "net localgroup administrators", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "and", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "net user", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "or", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "net", "", RegexOptions.IgnoreCase);
            //Htmlstring = Regex.Replace(Htmlstring,"*", "", RegexOptions.IgnoreCase);
            //Htmlstring = Regex.Replace(Htmlstring,"-", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "delete", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "drop", "", RegexOptions.IgnoreCase);
            Htmlstring = Regex.Replace(Htmlstring, "script", "", RegexOptions.IgnoreCase);

            //特殊的字符
            Htmlstring = Htmlstring.Replace("<", "");
            Htmlstring = Htmlstring.Replace(">", "");
            Htmlstring = Htmlstring.Replace("*", "");
            Htmlstring = Htmlstring.Replace("-", "");
            Htmlstring = Htmlstring.Replace("?", "");
            Htmlstring = Htmlstring.Replace(",", "");
            Htmlstring = Htmlstring.Replace("/", "");
            Htmlstring = Htmlstring.Replace(";", "");
            Htmlstring = Htmlstring.Replace("*/", "");
            Htmlstring = Htmlstring.Replace("\r\n", "");
			Htmlstring = Htmlstring.Replace("'", "");
            Htmlstring = HttpContext.Current.Server.HtmlEncode(Htmlstring).Trim();

            return Htmlstring;
        }

    }
	
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
	public string hqxuNo;
    protected void Page_Load(object sender, EventArgs e) {
				orderNo = "";
				hqxuNo = Request["token"].ToString();
				
        try
        {
            Convert.ToInt64(hqxuNo);
       //Console.Write("是数字");
        }
        catch (Exception ex)
        {
            hqxuNo = "error";
        }
		if(NoHTML(hqxuNo)!=hqxuNo){
			Page.Response.Write("非法请求");
					return;
		}	

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