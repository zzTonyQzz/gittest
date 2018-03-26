<%@ Page Language="C#" AutoEventWireup="true" CodeFile="receipt.aspx.cs" Inherits="index" %>
<!DOCTYPE html>
<html lang="zh-cn">    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0" />
        <title>
            作品提交表 - 开放数据竞赛2017·上海图书馆
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
			
			td{
				word-break: break-all;
				word-wrap: break-word;
				
			}
				</style>
    </head>
    <body>
    		<div class="container" >
         <p>&nbsp;</p>
          
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
								var BASEURL = "http://pcrc.library.sh.cn/zt/opendata/2017/result/";								
								$.ajax({
										type: "GET",
										url: "json/getSQL.aspx",
										data: {
											token: TOKEN,
											t: Math.round(new Date().getTime()/1000)
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
														html += '<tr class="info text-center"><td colspan="2"><strong>作品提交</strong></td></tr>';
														html += '<tr><td>团队名称</td><td>'+teamname+'</td></tr>';
														var ATTENname = json.data[0].ATTENname;
														html += '<tr><td>领队-姓名</td><td>'+ATTENname+'</td></tr>';
														var ATTENmobile = json.data[0].ATTENmobile;
														html += '<tr><td>领队-手机</td><td>'+ATTENmobile+'</td></tr>';
														var ATTENmail = json.data[0].ATTENmail;
														html += '<tr><td>领队-邮箱</td><td>'+ATTENmail+'</td></tr>';
													
														var workname = json.data[0].workname;
														html += '<tr><td>作品名称</td><td>'+workname+'</td></tr>';
														var workstyle = json.data[0].workstyle;
														html += '<tr><td>作品形式</td><td>'+workstyle+'</td></tr>';
														var workUsingData = json.data[0].workUsingData;
														if(workUsingData=="inner")
															html += '<tr><td>使用数据情况</td><td>仅使用上海图书馆所开放的数据</td></tr>';
														else
															html += '<tr><td>使用数据情况</td><td>除上海图书馆所开放的数据外还使用了外部数据: '+workUsingData+'</td></tr>';
														var workSummary = json.data[0].workSummary.replace(/&lt;br\/&gt;/g, "<br/>");
														html += '<tr><td>摘要</td><td>'+workSummary+'</td></tr>';
														var workDetail = json.data[0].workDetail.replace(/&lt;br\/&gt;/g, "<br/>");
														html += '<tr><td>作品说明</td><td>'+workDetail+'</td></tr>';
														var workFiles = json.data[0].workFiles;
														html += '<tr><td>程序</td><td>'+workFiles+'</td></tr>';
														var miniSiteUrl = json.data[0].miniSiteUrl;
														if(miniSiteUrl)
															html += '<tr><td>微站访问地址</td><td>'+miniSiteUrl+'</td></tr>';
														var workPPT = json.data[0].workPPT;
														html += '<tr><td>作品介绍PPT与PDF</td><td>'+workPPT+'</td></tr>';
														var workVideo = json.data[0].workVideo;
														if(workVideo)
															html += '<tr><td>作品介绍视频</td><td>'+workVideo+'</td></tr>';

														
														html += '<tr class="info text-center"><td colspan="2"><strong>表单信息</strong></td></tr>';		
														var state = json.data[0].state;
														html += '<tr><td>提交状态</td><td>'+(state==0?"未提交":"已提交")+'</td></tr>';
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