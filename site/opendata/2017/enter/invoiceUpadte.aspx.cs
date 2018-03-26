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
		public string creditContext = WebConfigurationManager.ConnectionStrings["CreditSysConnectionString"].ConnectionString;
		
    protected void Page_Load(object sender, EventArgs e) {
				Response.AppendHeader("Content-Type", "application/json");
				string token = Request.Form["token"];	
				string invoice = Request.Form["invoice"];	
				string html = "";
				if(!string.IsNullOrEmpty(Request.Form["token"]) && !string.IsNullOrEmpty(Request.Form["invoice"])){
						try {
								string sql = "UPDATE [CreditSys].[dbo].[ztJZ201703payment] SET invoice = @invoice where token = @token";
								SqlParameter[] par = new SqlParameter[] {
										new SqlParameter("@invoice", invoice),
										new SqlParameter("@token", token)
								};
								ExecuteNonQuery(sql, creditContext, par);										
								html = "{\""+"flag"+"\":"+"\""+"true"+"\",\""+"info"+"\":"+"\""+"发票信息提交成功！"+"\"}";
								Page.Response.Write(html);
							
						} catch (Exception ex) {
								html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+ex.Message+"\"}";
								Page.Response.Write(html);
								throw new Exception(ex.Message);
						}
				}else{
						html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"提交错误，刷新页面后重新提交！"+"\"}";
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