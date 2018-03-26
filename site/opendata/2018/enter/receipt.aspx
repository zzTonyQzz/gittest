<%@ Page Language="C#" AutoEventWireup="true" CodeFile="receipt.aspx.cs" Inherits="index" %>
<!DOCTYPE html>
<html lang="zh-cn">    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0" />
        <title>
            报名表 - 开放数据竞赛2017·上海图书馆
        </title>
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media
        queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file://
        -->
        <!--[if lt IE 9]>
            <script src="js/html5shiv.min.js">
            </script>
            <script src="js/respond.min.js">
            </script>
        <![endif]-->
        <style>
				.error {
					color: #F00;
				}
				</style>
    </head>
    <body>
    		<div class="container">
          <div class="projects-header page-header">
        		<h2 class="text-center">报名表 - 开放数据竞赛2017<br/><small>回执单</small></h2> 
        		    
        		<p class="text-center"><a href="../api/receiptGet.aspx?token=<%= hqxuNo %>" class="btn btn-primary">下载回执单</a></p>  		
      		</div>   
          <div class="table-responsive">
              <table class="table table-bordered table-striped">
                  <colgroup>
                      <col class="col-xs-2">
                      <col class="col-xs-10">                      
                  </colgroup>
                  <thead>
                      <!--<tr>
                          <th>KEY</th>
                          <th>VALUE</th>                          
                      </tr>-->
                  </thead>
                  <tbody id="List">
                      
                  </tbody>
              </table>
          </div>         
        </div>

             
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery-1.8.2.min.js">
        </script>
        <script src="js/bootstrap.min.js">
        </script>
        <script src="js/jquery.validate.min.js"></script>
        <script src="js/messages_zh.js"></script>

        <!-- Include all compiled plugins (below), or include individual files
        as needed -->
        <script>	
						var GetQueryString = function(name) {
								var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
								var r = window.location.search.substr(1).match(reg);
								if (r != null) return r[2];
						}							
						$(document).ready(function(e) {
								var TOKEN = "<%= orderNo %>"?"<%= orderNo %>":GetQueryString("token");
								var BASEURL = "http://pcrc.library.sh.cn/zt/opendata/2017/enter/";								
								$.ajax({
										type: "GET",
										url: "getSQL.aspx",
										data: {
												token: TOKEN
										},
										timeout: 10000,
										dataType: 'json',
										error: function (XMLHttpRequest, textStatus, errorThrown) {
												alert("获取数据失败，请刷新页面！");
										},
										success: function (json) {
												if (json.flag === "true") {
														var html = '';
														var teamname = json.data[0].teamname;
														//$("input[name='userName']").val((username));
														html += '<tr class="info text-center"><td colspan="2"><strong>团队</strong></td></tr>';
														html += '<tr><td>团队名称</td><td>'+teamname+'</td></tr>';
														var nation = json.data[0].nation;
														html += '<tr><td>国家</td><td>'+nation+'</td></tr>';
														var province = json.data[0].province;
														html += '<tr><td>省/直辖市/自治区</td><td>'+province+'</td></tr>';
														var ATTENname = json.data[0].ATTENname;
														html += '<tr><td>领队-姓名</td><td>'+ATTENname+'</td></tr>';
														var ATTENcompany = json.data[0].ATTENcompany;
														html += '<tr><td>领队-单位</td><td>'+ATTENcompany+'</td></tr>';
														var ATTENmobile = json.data[0].ATTENmobile;
														html += '<tr><td>领队-手机</td><td>'+ATTENmobile+'</td></tr>';
														var ATTENmail = json.data[0].ATTENmail;
														html += '<tr><td>领队-邮箱</td><td>'+ATTENmail+'</td></tr>';
														var teammembernums = json.data[0].teammembernums;
														html += '<tr><td>团队人数</td><td>'+teammembernums+'</td></tr>';
														var teammemberlist = eval(json.data[0].teammemberlist.replace(/&quot;/g,"\""));
														var teamStr = "";
														$.each(teammemberlist,function(index,element){
															var tips = "";
															if(element.type=="在校生"){
																tips = element.tips.split("#")[0] + ",&nbsp;" + element.tips.split("#")[1] + "学位,&nbsp;" + element.tips.split("#")[2] + "专业" 
															}else{
																tips = element.tips.split("#")[0] + ",&nbsp;" + element.tips.split("#")[1] + ""
															}
															teamStr += element.name+",&nbsp;"+element.age+" 岁,&nbsp;"+element.type+" ("+tips+")<br />"													
														})
														html += '<tr><td>团队成员</td><td>'+teamStr+'</td></tr>';
														var entryreason = json.data[0]["entryreason"].replace(/&lt;br\/&gt;/g, "<br/>");	;
														html += '<tr><td>参赛原因</td><td>'+entryreason+'</td></tr>';
														var accessfrom = json.data[0]["accessfrom"];
														html += '<tr><td>竞赛消息来源</td><td>'+accessfrom+'</td></tr>';
														html += '<tr class="info text-center"><td colspan="2"><strong>作品</strong></td></tr>';
														var workname = json.data[0].workname;														
														html += '<tr><td>作品名称</td><td>'+workname+'</td></tr>';
														var workstyle = json.data[0].workstyle;														
														html += '<tr><td>作品形式</td><td>'+workstyle+'</td></tr>';
														var workenvironment = json.data[0].workenvironment;														
														html += '<tr><td>运行环境</td><td>'+workenvironment+'</td></tr>';
														var workidea = json.data[0].workidea.replace(/&lt;br\/&gt;/g, "<br/>");													
														html += '<tr><td>作品创意</td><td>'+workidea+'</td></tr>';
														var workhadkey = json.data[0].workhadkey;
														var workkey = json.data[0].workkey;	
														if(workkey.split("#")[0]=="1")
															workkey = "申请失败或之前已申请，请自行重新申请："+workkey.split("#")[1]
														if(workkey.split("#")[0]=="0")
															workkey = workkey.split("#")[1]
														html += '<tr><td>apiKey</td><td>'+workkey+'</td></tr>';
														html += '<tr class="info text-center"><td colspan="2"><strong>培训</strong></td></tr>';
														var training = json.data[0].training;	
														if(training.split("#").length>1)
														   training = training.split("#")[0]+"&nbsp;,"+training.split("#")[1]+"&nbsp;人"
														html += '<tr><td>培训</td><td>'+training+'</td></tr>';
														html += '<tr class="info text-center"><td colspan="2"><strong>表单信息</strong></td></tr>';					
														var time = json.data[0].time;
														html += '<tr><td>提交时间</td><td>'+time+'</td></tr>';
														var ip = json.data[0].ip;
														html += '<tr><td>提交IP</td><td>'+ip+'</td></tr>';											
														$("#List").html(html);														
												} else {
														alert(json.errmsg);
												}
										}
								});								
						});
        </script>
    </body>

</html>