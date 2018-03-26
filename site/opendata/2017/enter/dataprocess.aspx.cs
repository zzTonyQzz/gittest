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
	public int orderHaveCheck(string token, string teamname, string ATTENname) {
        int orderHave = 0;
        string sql = " select * from ztPCRCopendata2017 where (token=@token) OR (teamname = @teamname and ATTENname=@ATTENname)";
        SqlParameter[] par = new SqlParameter[] { 
			new SqlParameter("@token", token),
			new SqlParameter("@teamname", teamname),
			new SqlParameter("@ATTENname", ATTENname)
        };
        SqlDataReader read = ExecuteDataReader(sql, creditContext, par);
        while (read.Read()) { orderHave++;
        }
        read.Close();
        return orderHave;
    }
	public string apikeyGet(string name,string email,string organization,string phone) {
        string responseStr = "";
        string baseUrl = "http://data.library.sh.cn/jp/key/save";
        string url = baseUrl;
        HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
        string s = "name=" + name + "&email=" + email + "&organization=" + organization + "&phone=" + phone + "&aim=2017开放数据竞赛";
		//Page.Response.Write(s + "<br />");
        byte[] requestBytes = System.Text.Encoding.UTF8.GetBytes(s);
        req.Method = "POST";
        req.ContentType = "application/x-www-form-urlencoded";
        //req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/56.0.2924.87 Safari/537.36";
        req.ContentLength = requestBytes.Length;
        req.AllowAutoRedirect = false;
        req.Timeout = 1000 * 10;
		try
        {
            Stream requestStream = req.GetRequestStream();
            try
            {
                requestStream.Write(requestBytes, 0, requestBytes.Length);
                HttpWebResponse res = (HttpWebResponse)req.GetResponse();				
                //Page.Response.Write(res.StatusCode + "<br />");
                StreamReader sr = new StreamReader(res.GetResponseStream(), System.Text.Encoding.UTF8);
                string backstr = sr.ReadToEnd();
				responseStr = backstr;
                //Page.Response.Write(responseStr + "<br />");
                sr.Close();
                res.Close();
                requestStream.Close();
                requestStream = null;                
            }
            catch
            {
                responseStr ="-1#apikey接口出错";
            }
        }
        catch (Exception ex2)
        {
            //Response.Write(ex2);     
            responseStr ="-1#apikey接口出错";
        }
        return responseStr;
    }
    protected void Page_Load(object sender, EventArgs e) {
				Response.AppendHeader("Content-Type", "application/json");
				string token = Request.Form["token"];
				string teamname = Request.Form["teamname"];
				string ATTENname = Request.Form["ATTENname"];
				string html = "";
				if(!string.IsNullOrEmpty(Request.Form["token"]) && orderHaveCheck(token,teamname,ATTENname)==0){
						try {
							if(!string.IsNullOrEmpty(Request.Form["teamname"])&&!string.IsNullOrEmpty(Request.Form["ATTENname"])&&!string.IsNullOrEmpty(Request.Form["ATTENmail"])) {
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
						html = "{\""+"flag"+"\":"+"\""+"false"+"\",\""+"errmsg"+"\":"+"\""+"您已提交过相同队名报名表！"+"\"}";
						Page.Response.Write(html);
				}
    }
		public void datapost() {
				string token = Request.Form["token"];	
				string teamname = Request.Form["teamname"];	
				string nation = Request.Form["nation"];	
				string province = Request.Form["province"];	
				string ATTENname = Request.Form["ATTENname"];	
				string ATTENcompany = Request.Form["ATTENcompany"];	
				string ATTENmobile = Request.Form["ATTENmobile"];	
				string ATTENmail = Request.Form["ATTENmail"];	
				string teammembernums = Request.Form["teammembernums"];	
				string entryreason = Request.Form["entryreason"];	
				string accessfrom = Request.Form["accessfrom"];	
				string workname = Request.Form["workname"];	
				string workstyle = Request.Form["workstyle"];	
				string workidea = Request.Form["workidea"];	
				string workhadkey = Request.Form["workhadkey"];	
				string teammemberlist = Request.Form["teammemberlist"];	
				string training = Request.Form["training"];	
				string workenvironment = Request.Form["workenvironment"];	
				string ip = GetClientIP();
				string workkey = "";
				string time = System.DateTime.Now.ToString();
				string html = "";
				string apistr;
				try{
						if(workhadkey=="0"){
							apistr = apikeyGet(teamname+"-"+ATTENname,ATTENmail,ATTENcompany,ATTENmobile);
							if(apistr.Split('#')[0]=="0"){
								workkey = apistr;
							}else{
								workkey = apistr+"#"+"http://data.library.sh.cn/jp/key/";
							}
							if (workkey==""||workkey=="0")
									workkey = "0#申请成功，请至邮箱查询Key！";
						}else{
							apistr = "-1";
							workkey = "请使用您之前申请的Key！";
						}
							
						
						string sql = "INSERT INTO [CreditSys].[dbo].[ztPCRCopendata2017]([teamname],[nation],[province],[ATTENname],[ATTENcompany],[ATTENmobile],[ATTENmail],[teammembernums],[teammemberlist],[entryreason],[accessfrom],[workname],[workstyle],[workenvironment],[workidea],[workhadkey],[workkey],[training],[token],[ip],[time],[state]) VALUES (@teamname,@nation,@province,@ATTENname,@ATTENcompany,@ATTENmobile,@ATTENmail,@teammembernums,@teammemberlist,@entryreason,@accessfrom,@workname,@workstyle,@workenvironment,@workidea,@workhadkey,@workkey,@training,@token,@ip,@time,@state)";
						SqlParameter[] par = new SqlParameter[] {
								new SqlParameter("@teamname", teamname),
								new SqlParameter("@nation", nation),
								new SqlParameter("@province", province),
								new SqlParameter("@ATTENname", ATTENname),
								new SqlParameter("@ATTENcompany", ATTENcompany),
								new SqlParameter("@ATTENmobile", ATTENmobile),
								new SqlParameter("@ATTENmail", ATTENmail),
								new SqlParameter("@teammembernums", teammembernums),
								new SqlParameter("@teammemberlist", teammemberlist),
								new SqlParameter("@entryreason", entryreason),
								new SqlParameter("@accessfrom", accessfrom),
								new SqlParameter("@workname", workname),
								new SqlParameter("@workstyle", workstyle),
								new SqlParameter("@workenvironment", workenvironment),
								new SqlParameter("@workidea", workidea),
								new SqlParameter("@workhadkey", workhadkey),
								new SqlParameter("@workkey", workkey),
								new SqlParameter("@training", training),
								new SqlParameter("@token", token),
								new SqlParameter("@ip", ip),
								new SqlParameter("@time", time),
								new SqlParameter("@state", "0")
						};
						ExecuteNonQuery(sql, creditContext, par);
						if (apistr.Split('#')[0]=="0")
						{		
							
							html = "{\""+"flag"+"\":"+"\""+"true"+"\",\""+"teamname"+"\":"+"\""+teamname+"\",\""+"ATTENname"+"\":"+"\""+ATTENname+"\",\""+"token"+"\":"+"\""+token+"\",\""+"workkey"+"\":"+"\""+workkey+"\"}";
						}						
						else{
							html = "{\""+"flag"+"\":"+"\""+"true"+"\",\""+"teamname"+"\":"+"\""+teamname+"\",\""+"ATTENname"+"\":"+"\""+ATTENname+"\",\""+"token"+"\":"+"\""+token+"\",\""+"workkey"+"\":"+"\"申请失败，请自行申请 http://data.library.sh.cn/jp/key/\"}";
						}										
					try
					{
						
						//因为Web 是多线程环境，避免甲产生的文件被乙下载去，所以档名都用唯一 
						string fileNameWithOutExtention = token.ToString();
						string hqxuUrl = "http://pcrc.library.sh.cn/zt/opendata/2017/enter/receiptSimple.aspx?token="+token;
						//执行wkhtmltopdf.exe 
						Process p = System.Diagnostics.Process.Start(@"C:\Program Files (x86)\wkhtmltopdf\bin\wkhtmltopdf.exe", "--page-size A4 --viewport-size 920x1024 --header-left 报名表  --header-right 上海图书馆2017开放数据应用开发竞赛 --footer-center 上海图书馆 "+hqxuUrl + @" D:\shlib\pcrc\zt\opendata\2017\api\receipts\" + fileNameWithOutExtention + ".pdf");

						//若不加这一行，程序就会马上执行下一句而抓不到文件发生意外：System.IO.FileNotFoundException: 找不到文件 ''。 
						p.WaitForExit();						

						//发送邮件
						//发送邮件
						string email = ATTENmail;
						sendMail("ps.libnet.sh.cn","opendata","opendata2017","2017开放数据应用开发竞赛委员会","opendata@libnet.sh.cn",email,"2017开放数据应用开发竞赛 - 报名回执","您好，已收到您报名参加2017开放数据应用开发竞赛。附件为您的报名资料，请查收。如有相关问题，请联系 zyzhang@libnet.sh.cn 。谢谢！",@"D:\shlib\pcrc\zt\opendata\2017\api\receipts\" + fileNameWithOutExtention + ".pdf");
						
						email = "zyzhang@libnet.sh.cn";
						sendMail("ps.libnet.sh.cn","opendata","opendata2017","2017开放数据应用开发竞赛委员会","opendata@libnet.sh.cn",email,"管理员存根:"+teamname+" 团队报名表","您好，已收到您报名参加2017开放数据应用开发竞赛。附件为您的报名资料，请查收。如有相关问题，请联系 zyzhang@libnet.sh.cn 。谢谢！",@"D:\shlib\pcrc\zt\opendata\2017\api\receipts\" + fileNameWithOutExtention + ".pdf");
						
						
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