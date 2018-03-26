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
using System.Data.SqlClient;

/*要引用以下命名空间*/
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Mail;
 
public partial class index: System.Web.UI.Page {
	/// <summary>
	/// 发送电子邮件
	/// </summary>
	/// <param name="smtpserver">SMTP服务器</param>
	/// <param name="userName">登录帐号</param>
	/// <param name="pwd">登录密码</param>
	/// <param name="nickName">发件人昵称</param>
	/// <param name="strfrom">发件人</param>
	/// <param name="strto">收件人</param>
	/// <param name="subj">主题</param>
	/// <param name="bodys">内容</param>
	public static void sendMail(string smtpserver, string userName, string pwd, string nickName, string strfrom, string strto, string subj, string bodys, string file)
	{
		SmtpClient _smtpClient = new SmtpClient();
		_smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;//指定电子邮件发送方式
		_smtpClient.Host = smtpserver;//指定SMTP服务器
		_smtpClient.Credentials = new System.Net.NetworkCredential(userName, pwd);//用户名和密码
		//MailMessage _mailMessage = new MailMessage(strfrom, strto);
		MailAddress _from = new MailAddress(strfrom, nickName);
		MailAddress _to = new MailAddress(strto);
		MailMessage _mailMessage = new MailMessage(_from, _to);
		_mailMessage.Subject = subj;//主题
		_mailMessage.Body = bodys;//内容
		_mailMessage.Attachments.Add( new Attachment( file) );
		_mailMessage.BodyEncoding = System.Text.Encoding.Default;//正文编码
		_mailMessage.IsBodyHtml = true;//设置为HTML格式
		_mailMessage.Priority = MailPriority.Normal;//优先级
		_smtpClient.Send(_mailMessage);
	}
		public string creditContext = WebConfigurationManager.ConnectionStrings["CreditSysConnectionString"].ConnectionString;
		public string GetClientIP()
		{
			 string result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
			 if (result == null || result == String.Empty)
			 {
					result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
			 }
			 if (result == null || result == String.Empty)
			 {
					result = HttpContext.Current.Request.UserHostAddress;
			 }
			 return result;
		}	
	public int orderHaveCheck(string teamname, string teamid) {
        int orderHave = 0;
        string sql = " select * from ztPCRCopendata2017_Result where teamname = @teamname and id=@teamid and state=0";
        SqlParameter[] par = new SqlParameter[] { 
			new SqlParameter("@teamname", teamname),
			new SqlParameter("@teamid", teamid)
        };
        SqlDataReader read = ExecuteDataReader(sql, creditContext, par);
        while (read.Read()) { orderHave++;
        }
        read.Close();
        return orderHave;
    }
	public string getToken(string teamname, string teamid) {
        string token = "";
        string sql = " select top 1 token from ztPCRCopendata2017_Result where teamname = @teamname and id=@teamid and state=1 order by time desc";
        SqlParameter[] par = new SqlParameter[] { 
			new SqlParameter("@teamname", teamname),
			new SqlParameter("@teamid", teamid)
        };
        SqlDataReader read = ExecuteDataReader(sql, creditContext, par);
        while (read.Read()) { 
			token = read.GetValue(0).ToString();
        }
        read.Close();
        return token;
    }
	public string getMail(string teamname, string teamid) {
        string mail = "";
        string sql = " select top 1 ATTENmail from ztPCRCopendata2017_Result where teamname = @teamname and id=@teamid and state=1 order by time desc";
        SqlParameter[] par = new SqlParameter[] { 
			new SqlParameter("@teamname", teamname),
			new SqlParameter("@teamid", teamid)
        };
        SqlDataReader read = ExecuteDataReader(sql, creditContext, par);
        while (read.Read()) { 
			mail = read.GetValue(0).ToString();
        }
        read.Close();
        return mail;
    }

    protected void Page_Load(object sender, EventArgs e) {
				Response.AppendHeader("Content-Type", "application/json");
				string teamname = Request.Form["teamname"];
				string teamid = Request.Form["teamid"];
				string html = "";
				DateTime d1;
				d1 = DateTime.Now;
				DateTime d2;
				//d2 = new DateTime(2016,8,15,9,0,0);
				d2 = new DateTime(2017,8,12,0,0,0);
				DateTime d3;
				d3 = new DateTime(2017,8,15,0,0,0);
				TimeSpan ts4, ts5;
				ts4 = d1 - d2;
				ts5 = d3 - d1;				
				if(!string.IsNullOrEmpty(Request.Form["teamid"]) && orderHaveCheck(teamname,teamid)==1){
						try {
							if(1==1||(!string.IsNullOrEmpty(Request.Form["workname"])&&!string.IsNullOrEmpty(Request.Form["workstyle"])&&!string.IsNullOrEmpty(Request.Form["workSummary"])&&!string.IsNullOrEmpty(Request.Form["workDetail"])&&!string.IsNullOrEmpty(Request.Form["workPPTUrl"])&&!string.IsNullOrEmpty(Request.Form["workUsingData"]))) {
									datapost();
							}else{
									html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"缺少必要字段！"+"\"}";
									Page.Response.Write(html);
							}
						} catch (Exception ex) {
								html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+ex.Message+"\"}";
								Page.Response.Write(html);
								throw new Exception(ex.Message);
						}
				}else{
						html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"您已提交过作品，请勿重复提交！"+"\"}";
						Page.Response.Write(html);
				}
    }
		public void datapost() {
			string teamname = Request.Form["teamname"];	
			string teamid = Request.Form["teamid"];	

			string workname = Request.Form["workname"];	
			string workstyle = Request.Form["workstyle"];	
			string workUsingData = Request.Form["workUsingData"];	
			string workSummary = Request.Form["workSummary"];	
			string workDetail = Request.Form["workDetail"];	
			string workFiles = Request.Form["workFiles"];	
			string workFilesUrl = Request.Form["workFilesUrl"];	
			string workLogo = Request.Form["workLogo"];	
			string workLogoUrl = Request.Form["workLogoUrl"];	
			string miniSiteUrl = Request.Form["miniSiteUrl"];	
			string workPPT = Request.Form["workPPT"];	
			string workPPTUrl = Request.Form["workPPTUrl"];	
			string workVideo = Request.Form["workVideo"];	
			string workVideoUrl = Request.Form["workVideoUrl"];		

			string ip = GetClientIP();
			string time = System.DateTime.Now.ToString();
			string html = "";
			try{
					string sql = "UPDATE [CreditSys].[dbo].[ztPCRCopendata2017_Result] SET workname = @workname,workstyle = @workstyle,workUsingData = @workUsingData,workSummary = @workSummary,workDetail = @workDetail,workFiles = @workFiles,workFilesUrl = @workFilesUrl,workLogo = @workLogo,workLogoUrl = @workLogoUrl,miniSiteUrl = @miniSiteUrl,workPPT = @workPPT,workPPTUrl = @workPPTUrl,workVideo = @workVideo,workVideoUrl = @workVideoUrl,ip = @ip,time = @time,state = @state where teamname = @teamname and id=@teamid and state=0";
					SqlParameter[] par = new SqlParameter[] {
						new SqlParameter("@teamname", teamname),							
						new SqlParameter("@teamid", teamid),
						
						new SqlParameter("@workname", workname),
						new SqlParameter("@workstyle", workstyle),
						new SqlParameter("@workUsingData", workUsingData),
						new SqlParameter("@workSummary", workSummary),
						new SqlParameter("@workDetail", workDetail),
						new SqlParameter("@workFiles", workFiles),
						new SqlParameter("@workFilesUrl", workFilesUrl),
						new SqlParameter("@workLogo", workLogo),
						new SqlParameter("@workLogoUrl", workLogoUrl),
						new SqlParameter("@workPPT", workPPT),
						new SqlParameter("@workPPTUrl", workPPTUrl),
						new SqlParameter("@miniSiteUrl", miniSiteUrl),
						new SqlParameter("@workVideo", workVideo),
						new SqlParameter("@workVideoUrl", workVideoUrl),


						new SqlParameter("@ip", ip),
						new SqlParameter("@time", time),
						new SqlParameter("@state", "1")
					};
					ExecuteNonQuery(sql, creditContext, par);
					string token = getToken(teamname, teamid);
					if(token == ""){
						html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"写入数据库失败！bad token"+"\"}";
					}else{
						html = "{\""+"flag"+"\":"+"\""+"true"+"\",\""+"teamname"+"\":"+"\""+teamname+"\",\""+"token"+"\":"+"\""+token+"\",\""+"workname"+"\":"+"\""+workname+"\"}";
					}
													
				try
				{

					//因为Web 是多线程环境，避免甲产生的文件被乙下载去，所以档名都用唯一 
					string fileNameWithOutExtention = token.ToString();
					string hqxuUrl = "http://pcrc.library.sh.cn/zt/opendata/2017/result/receiptSimple.aspx?token="+token;
					//执行wkhtmltopdf.exe 
					Process p = System.Diagnostics.Process.Start(@"C:\Program Files (x86)\wkhtmltopdf\bin\wkhtmltopdf.exe", "--page-size A4 --viewport-size 920x1024 --header-left 作品提交表  --header-right 上海图书馆2017开放数据应用开发竞赛 --footer-center 上海图书馆 "+hqxuUrl + @" D:\shlib\pcrc\zt\opendata\2017\api\results\" + fileNameWithOutExtention + ".pdf");

					//若不加这一行，程序就会马上执行下一句而抓不到文件发生意外：System.IO.FileNotFoundException: 找不到文件 ''。 
					p.WaitForExit();						

					//发送邮件
					//发送邮件
					string email = "";
					email = getMail(teamname, teamid);					
					//email = "525160324@qq.com";
					sendMail("ps.libnet.sh.cn","opendata","opendata2017","2017开放数据应用开发竞赛委员会","opendata@libnet.sh.cn",email,"2017开放数据应用开发竞赛 - 作品提交回执","您好，已收到您提交的作品。附件为您提交的作品表单，请查收。如有相关问题，请联系 zyzhang@libnet.sh.cn 。谢谢！",@"D:\shlib\pcrc\zt\opendata\2017\api\results\" + fileNameWithOutExtention + ".pdf");
					

					//email = "zyzhang@libnet.sh.cn";
					email = "zyzhang@libnet.sh.cn";
					sendMail("ps.libnet.sh.cn","opendata","opendata2017","2017开放数据应用开发竞赛委员会","opendata@libnet.sh.cn",email,"管理员存根:"+teamname+" 作品提交表","管理员您好，现已收到【"+teamname+","+getMail(teamname, teamid)+"】提交的作品。附件为提交的作品表单，请查收。如有相关问题，请联系 zyzhang@libnet.sh.cn 。谢谢！",@"D:\shlib\pcrc\zt\opendata\2017\api\results\" + fileNameWithOutExtention + ".pdf");


				} catch (Exception ex2)
				{
					//Response.Write(ex2);
					//Response.Write("<br/>");

				}



			}	catch (Exception ex) { throw new Exception(ex.Message);
				html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"写入数据库失败！"+"\"}";
        	}
				
			Page.Response.Write(html);
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