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
using System.Text;
 
public partial class index: System.Web.UI.Page {
		public string creditContext = WebConfigurationManager.ConnectionStrings["CreditSysConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e) {
				Response.AppendHeader("Content-Type", "application/json");
				string orderNo = Request["orderNo"];				
				string tradeStatus = Request["tradeStatus"];
				string totalFee = Request["totalFee"];
				string tradeNo = Request["tradeNo"];
				string time = System.DateTime.Now.ToString();
				string html = "";
				//string url = Request.UrlReferrer.ToString();
				string ip;
				//ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();
				if(Request.ServerVariables["HTTP_VIA"]!=null) // using proxy
				{ 
					 ip=Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();  // Return real client IP.
				}
				else// not using proxy or can't get the Client IP
				{ 
					 ip=Request.ServerVariables["REMOTE_ADDR"].ToString(); //While it can't get the Client IP, it will return proxy IP.
				}				
				if(tradeStatus=="TRADE_SUCCESS" && ("218.1.116.98".Equals(ip) || "10.1.31.57".Equals(ip))){
						//string[] sArray = orderNo.Split('_'); 
						//orderNo = sArray[1];
						try {
								string sql = "UPDATE [CreditSys].[dbo].[ztJZ201703payment] SET [alipayId] = @tradeStatus,[totalFee] = @totalFee,[tradeNo] = @tradeNo, [tradeTime] = @tradeTime where token = @orderNo";
								SqlParameter[] par = new SqlParameter[] {
										new SqlParameter("@tradeStatus", tradeStatus),
										new SqlParameter("@totalFee", totalFee),
										new SqlParameter("@tradeNo", tradeNo),
										new SqlParameter("@orderNo", orderNo),
										new SqlParameter("@tradeTime",time)
								};
								ExecuteNonQuery(sql, creditContext, par);									
							
								SqlConnection conn1 = new SqlConnection(creditContext);
								conn1.Open();
								string sqlIns = "SELECT top 1 * from [CreditSys].[dbo].[ztJZ201703payment] where token = N'"+orderNo+"' order by id desc";
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
												theString = theString.Replace(" ", "&nbsp;");  
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
										html = "{\"" + "flag" + "\":" + "\"" + "false" + "\",\""+"errmsg"+"\":"+"\""+"没有找到相应表单！"+"\"}";
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
						if(orderNo!="" && orderNo != null ){
								try {
										string sql = "UPDATE [CreditSys].[dbo].[ztJZ201703payment] SET [tradeNo] = @tradeNo where token = @orderNo";
										SqlParameter[] par = new SqlParameter[] {
												new SqlParameter("@tradeNo", ip),
												new SqlParameter("@orderNo", orderNo)
										};
										ExecuteNonQuery(sql, creditContext, par);	
								} catch (Exception ex) {
										throw new Exception(ex.Message);
								}
						}
						html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"交易失败！"+"\",\""+"ipFrom"+"\":"+"\""+ip+"\",\""+"orderNo"+"\":"+"\""+orderNo+"\"}";
						Page.Response.Write(html);
				}
    }
    public int ExecuteNonQuery(string sql, string dataStr, SqlParameter[] paras) {
        SqlConnection conn = new SqlConnection(dataStr);
        try { SqlCommand cmd = PerPareCommand(sql, conn, paras); return cmd.ExecuteNonQuery();
        } finally { conn.Close();
        }
    }
    public SqlDataReader ExecuteDataReader(string sql, string dataStr, SqlParameter[] paras) {
        try { SqlConnection conn = new SqlConnection(dataStr); SqlCommand cmd = PerPareCommand(sql, conn, paras); return cmd.ExecuteReader(CommandBehavior.CloseConnection);
        } catch { throw;
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