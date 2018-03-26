using System.Net;
using System.IO;
using System;
using System.Web;
using System.Text;

public partial class _Default: System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
		string mobile;
		mobile = Request.Form["mobile"];
		string scontent;
		scontent = HttpUtility.UrlEncode(Request.Form["scontent"], System.Text.Encoding.GetEncoding("GB2312"));
		Response.AppendHeader("Content-Type", "application/json");
        WebRequest request = WebRequest.Create("http://10.1.31.137/stsms/member/m_sms_s_out.jsp?oktype=comfree&scontent="+scontent+"&mobile="+mobile+"&smstype=00200032");
        request.Credentials = CredentialCache.DefaultCredentials;
        HttpWebResponse response = (HttpWebResponse) request.GetResponse();
        Stream dataStream = response.GetResponseStream();
        StreamReader reader = new StreamReader(dataStream,Encoding.GetEncoding("gb2312"));
        string responseFromServer = reader.ReadToEnd();
        reader.Close();
        dataStream.Close();
        response.Close();
		Page.Response.Write("{\"flag\":\"true\",\"msg\":\"" + responseFromServer + "\",\"mobile\":\"" + mobile + "\",\"scontent\":\"" + scontent + "\"}");
    }
}