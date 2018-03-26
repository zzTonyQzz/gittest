﻿using System;
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
		public string creditContext = WebConfigurationManager.ConnectionStrings["CreditSysConnectionString"].ConnectionString;
		public int successNums() {
				int orderHave = 0;
				string sql = "SELECT id from[ztPCRCopendata2017_Result] where state = N'1' order by id asc";
				SqlParameter[] par = new SqlParameter[] {					
				};
				SqlDataReader read = ExecuteDataReader(sql, creditContext, par);
				while (read.Read()) {
						orderHave++;
				}
				read.Close();
				return orderHave;
		}		
		
    protected void Page_Load(object sender, EventArgs e) {
				Response.AppendHeader("Content-Type", "application/json");
				string token = Request["token"];	
				string html = "";
				if(!string.IsNullOrEmpty(Request["token"])){
						try {
								
								SqlConnection conn1 = new SqlConnection(creditContext);
								conn1.Open();
								string sqlIns = "SELECT top 1 * from [CreditSys].[dbo].[ztPCRCopendata2017_Result] where token = N'"+token+"' order by id desc";
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
												theString = theString.Replace("\t", "&nbsp;");
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
										html = "{\"" + "flag" + "\":" + "\"" + "true" + "\",\"" + "successNums" + "\":" + "\"" + successNums().ToString() + "\",\"data\":[" + html + "]}";
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