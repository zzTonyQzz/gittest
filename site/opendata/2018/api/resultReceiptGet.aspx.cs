using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/*要引用以下命名空间*/
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Mail;

public partial class index : System.Web.UI.Page
{
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
    protected void Page_Load(object sender, EventArgs e)
    {
		try
            {
			string token;
			token = Request["token"];
			//因为Web 是多线程环境，避免甲产生的文件被乙下载去，所以档名都用唯一 
			string fileNameWithOutExtention = Guid.NewGuid().ToString();
			string hqxuUrl = "http://pcrc.library.sh.cn/zt/opendata/2017/result/receiptSimple.aspx?token="+token;
			//执行wkhtmltopdf.exe 
			Process p = System.Diagnostics.Process.Start(@"C:\Program Files (x86)\wkhtmltopdf\bin\wkhtmltopdf.exe", "--page-size A4 --viewport-size 920x1024 --header-left 作品提交表  --header-right 上海图书馆2017开放数据应用开发竞赛 --footer-center 上海图书馆 "+hqxuUrl + @" D:\shlib\pcrc\zt\opendata\2017\api\temp\" + fileNameWithOutExtention + ".pdf");

			//若不加这一行，程序就会马上执行下一句而抓不到文件发生意外：System.IO.FileNotFoundException: 找不到文件 ''。 
			p.WaitForExit();


			//把文件读进文件流 
			FileStream fs = new FileStream(@"D:\shlib\pcrc\zt\opendata\2017\api\temp\" + fileNameWithOutExtention + ".pdf", FileMode.Open);
			byte[] file = new byte[fs.Length];
			fs.Read(file, 0, file.Length);
			fs.Close();

			//Response给客户端下载 
			Response.Clear();
			Response.AddHeader("content-disposition", "attachment; filename=" + fileNameWithOutExtention + ".pdf");//强制下载 
			Response.ContentType = "application/octet-stream";
			Response.BinaryWrite(file);
			
			//发送邮件
			string email = "hqxu@libnet.sh.cn";
			//sendMail("ps.libnet.sh.cn","opendata","opendata2017","2017开放数据应用开发竞赛委员会","opendata@libnet.sh.cn",email,"2017开放数据应用开发竞赛 - 报名回执","您好，已收到您报名参加2017开放数据应用开发竞赛。附件为您的报名资料，请查收。如有相关问题，请联系 zyzhang@libnet.sh.cn 。谢谢！",@"D:\shlib\pcrc\zt\opendata\2017\api\temp\" + fileNameWithOutExtention + ".pdf");
		} catch (Exception ex2)
		{
			Response.Write(ex2);
			Response.Write("<br/>");
			
		}

    }
}