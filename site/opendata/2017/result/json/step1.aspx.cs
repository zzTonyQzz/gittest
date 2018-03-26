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
	public string creditContext = WebConfigurationManager.ConnectionStrings["CreditSysConnectionString"].ConnectionString;		
    protected void Page_Load(object sender, EventArgs e) {
				Response.AppendHeader("Content-Type", "application/json");
				string ATTENname = (Request.Form["ATTENname"]);					
				string ATTENmobile = (Request.Form["ATTENmobile"]);	
				string ATTENmail = (Request.Form["ATTENmail"]);	
				//string ATTENname = NoHTML(Request.Form["ATTENname"]);					
				//string ATTENmobile = NoHTML(Request.Form["ATTENmobile"]);	
				//string ATTENmail = NoHTML(Request.Form["ATTENmail"]);	
				DateTime d1;
				d1 = DateTime.Now;
				DateTime d2;
				//d2 = new DateTime(2016,8,15,9,0,0);
				d2 = new DateTime(2017,7,11,0,0,0);
				DateTime d3;
				d3 = new DateTime(2017,8,15,0,0,0);
				TimeSpan ts4, ts5;
				ts4 = d1 - d2;
				ts5 = d3 - d1;
				if(ts4.Minutes < 0 || ts5.Minutes < 0){
					Page.Response.Write("{\"flag\":\"false\",\"errmsg\":\"" + "作品提交时间：7月11日 - 8月11日。" + "\"}");
					return;
				}
		
				if(ATTENname != Request.Form["ATTENname"] || ATTENmobile != Request.Form["ATTENmobile"] || ATTENmail != Request.Form["ATTENmail"]){
					//Page.Response.Write("非法请求");
					//return;
				}
				string html = "";
				if(!string.IsNullOrEmpty(ATTENname)&&!string.IsNullOrEmpty(ATTENmobile)){
						try {
								SqlConnection conn1 = new SqlConnection(creditContext);
								conn1.Open();
								string sqlIns = "SELECT top 1 id as teamid,teamname,ATTENname,workname_old,state from [CreditSys].[dbo].[ztPCRCopendata2017_Result] where ATTENname = N'"+ATTENname+"' and  ATTENmobile = N'"+ATTENmobile+"' order by id desc";
								SqlCommand com = new SqlCommand(sqlIns, conn1);
								SqlDataReader dr = com.ExecuteReader();								 
								int RecordCount = 0;
								while (dr.Read()) {
										RecordCount++;
										html += "{";
										for (int i = 0; i < dr.FieldCount; i++) {
												string theString;
												theString = dr.GetValue(i).ToString();
												theString = theString.Replace(">", "&gt;");  
												theString = theString.Replace("<", "&lt;");  
												//theString = theString.Replace(" ", "&nbsp;");  
												theString = theString.Replace("\"", "&quot;");  
												theString = theString.Replace("\'", "&#39;");  
												theString = theString.Replace("\\", "\\\\");//对斜线的转义  
												theString = theString.Replace("\n", "\\n");  //注意php中替换的时候只能用双引号"\n"
												theString = theString.Replace("\r", "\\r");  
												if (i == dr.FieldCount - 1)
														html += "\"" + dr.GetName(i) + "\":" + "\"" + theString + "\"";
												else
														html += "\"" + dr.GetName(i) + "\":" + "\"" + theString + "\",";
										}
										html += "},";
								}
								if (RecordCount == 0) {
										html = "{\"" + "flag" + "\":" + "\"" + "false" + "\",\""+"errmsg"+"\":"+"\""+"检验失败！"+"\"}";
										Page.Response.Write(html);
								} else {
										html = html.Substring(0, html.Length - 1);
										html = "{\"" + "flag" + "\":" + "\"" + "true" + "\",\"data\":[" + html + "]}";
										Page.Response.Write(html);
								}
								conn1.Close();							
						} catch (Exception ex) {
								html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+ex.Message+"\"}";
								Page.Response.Write(html);
								throw new Exception(ex.Message);
						}
				}else if(!string.IsNullOrEmpty(ATTENname)&&!string.IsNullOrEmpty(ATTENmail)){
						try {
								SqlConnection conn1 = new SqlConnection(creditContext);
								conn1.Open();
								string sqlIns = "SELECT top 1 id as teamid,teamname,ATTENname,workname_old,state from [CreditSys].[dbo].[ztPCRCopendata2017_Result] where ATTENname = N'"+ATTENname+"' and  ATTENmail = N'"+ATTENmail+"' order by id desc";
								SqlCommand com = new SqlCommand(sqlIns, conn1);
								SqlDataReader dr = com.ExecuteReader();								 
								int RecordCount = 0;
								while (dr.Read()) {
										RecordCount++;
										html += "{";
										for (int i = 0; i < dr.FieldCount; i++) {
												string theString;
												theString = dr.GetValue(i).ToString();
												theString = theString.Replace(">", "&gt;");  
												theString = theString.Replace("<", "&lt;");  
												//theString = theString.Replace(" ", "&nbsp;");  
												theString = theString.Replace("\"", "&quot;");  
												theString = theString.Replace("\'", "&#39;");  
												theString = theString.Replace("\\", "\\\\");//对斜线的转义  
												theString = theString.Replace("\n", "\\n");  //注意php中替换的时候只能用双引号"\n"
												theString = theString.Replace("\r", "\\r");  
												if (i == dr.FieldCount - 1)
														html += "\"" + dr.GetName(i) + "\":" + "\"" + theString + "\"";
												else
														html += "\"" + dr.GetName(i) + "\":" + "\"" + theString + "\",";
										}
										html += "},";
								}
								if (RecordCount == 0) {
										html = "{\"" + "flag" + "\":" + "\"" + "false" + "\",\""+"errmsg"+"\":"+"\""+"检验失败！"+"\"}";
										Page.Response.Write(html);
								} else {
										html = html.Substring(0, html.Length - 1);
										html = "{\"" + "flag" + "\":" + "\"" + "true" + "\",\"data\":[" + html + "]}";
										Page.Response.Write(html);
								}
								conn1.Close();							
						} catch (Exception ex) {
								html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+ex.Message+"\"}";
								Page.Response.Write(html);
								throw new Exception(ex.Message);
						}
				}else{
						html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"字段错误！"+"\"}";
						Page.Response.Write(html);
				}
    }
    public int ExecuteNonQuery(string sql, string dataStr, SqlParameter[] paras) {
        SqlConnection conn = new SqlConnection(dataStr);
        try { 
						SqlCommand cmd = PerPareCommand(sql, conn, paras);
						return cmd.ExecuteNonQuery();
        } finally {
						conn.Close();
        }
    }
    public SqlDataReader ExecuteDataReader(string sql, string dataStr, SqlParameter[] paras) {
        try {
						SqlConnection conn = new SqlConnection(dataStr);
						SqlCommand cmd = PerPareCommand(sql, conn, paras);
						return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        } catch {
						throw;
        }
    }
    private SqlCommand PerPareCommand(string sql, SqlConnection conn, params SqlParameter[] paras) {
        if (conn.State == ConnectionState.Closed)
						conn.Open();
        SqlCommand cmd = new SqlCommand(sql, conn);
        cmd.CommandType = CommandType.Text;
        if (paras != null)
						cmd.Parameters.AddRange(paras);
        return cmd;
    }		
}