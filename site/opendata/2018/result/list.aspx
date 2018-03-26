<%@ Page Language="C#" AutoEventWireup="true" CodeFile="list.aspx.cs" Inherits="index" %>
<!DOCTYPE html>
<html lang="zh-cn">    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0" />
        <title>
            参赛作品提交表·汇总清单 - 开放数据竞赛2017·上海图书馆
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
        		<h2 class="text-center" id="title"align="">参赛作品提交表 - 汇总清单</h2>       
        		<h3 class="text-center" id="subTitle">开放数据竞赛2017</h3> 	
        		
      		</div>   
          <div class="table-responsive">
              <table class="table table-bordered table-striped">
                  <colgroup>
                  	  <col class="col-xs-1">
                      <col class="col-xs-3">
                      <col class="col-xs-3">  
                      <col class="col-xs-3">
                      <col class="col-xs-1"> 
                      <col class="col-xs-1">                  
                  </colgroup>
                  <thead>
                      <tr>
                      		<th class="text-center">序号</th>
                          <th>团队名称</th>                            
                          <th>作品名称</th>
                          <th>作品类型</th>                       
                          <th>IP</th> 
                          <th>查看详情</th>                        
                      </tr>
                  </thead>
                  <tbody id="List">
                      
                  </tbody>
              </table>
          </div>          
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">登录</h4>
              </div>
              <div class="modal-body">
                  <form class="form-horizontal" onsubmit="return false;" role="form" id="hqxuForm" action="list.aspx" method="post">
                    <div class="form-group">
                      <label for="username" class="col-sm-2 control-label">*用户名</label>
                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="username" name="username" placeholder="用户名">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="pwd" class="col-sm-2 control-label">*密码</label>
                      <div class="col-sm-10">
                        <input type="password" class="form-control" id="pwd" name="pwd" placeholder="密码">
                      </div>
                    </div>
                    <div class="modal-footer">
                      <button id="Submit" type="submit" class="btn btn-primary">登录</button>
                    </div>
                	</form>
              </div>
            </div>
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
								var USER = "<%= USER %>"?"<%= USER %>":false;
								var PWD = "<%= PWD %>"?"<%= PWD %>":false;
								var SUC_CNT = 0;
								var SUC_ONLY_CNT = 0;
								var UNSUC_CNT = 0;
								var validator = $("#hqxuForm").validate({
									debug: true,
									rules: {
											username: {
												required: true,
												minlength: 2
											},
											pwd: {
												required: true,
												minlength: 2
											}
									},
									errorPlacement: function(error, element) {
											if (element.is(":radio")||element.is(":checkbox")){
													error.css("display","block").appendTo(element.parent().parent()); //将错误信息添加当前元素的父结点后面 
											}
											else
													error.insertAfter(element);
									},
									submitHandler:function(form){											
											form.submit();
									}
								});
								if(USER&&PWD){
									var mailList = "";
										$.ajax({
												type: "POST",
												url: "json/getList.aspx",
												data: {
														user: USER,
														pwd: PWD
												},
												timeout: 10000,
												dataType: 'json',
												error: function (XMLHttpRequest, textStatus, errorThrown) {
													console.log(errorThrown);
													//alert(json.errmsg);
												},
												success: function (json) {
														if (json.flag === "true") {
																var html = '';
																$.each(json.data,function(index,element){
																		var teamname = element.teamname;
																		var ATTENname = element.ATTENname;
																		
																		var workname = element.workname;
																		if(!workname)
																			workname = element.workname_old;
																		var workstyle = element.workstyle;
																		if(!workstyle)
																			workstyle = element.workstyle_old;
																		var token = element.token;
																		var ip = element.ip;
																		var className = "";
																		var ATTENmail = element.ATTENmail;																	
																		var state = element.state;
																		mailList += ATTENmail+";";
																		if(state==1){
																			className = "success";
																			SUC_CNT = SUC_CNT + 1;
																		}else{
																			className = "";
																			UNSUC_CNT++
																		}																
																		
																		html += '<tr class="'+className+'"><td class="text-center">'+(index+1)+'</td><td>'+teamname+'</td><td>'+workname+'</td><td>'+workstyle+'</td><td>'+ip+'</td><td class="text-center"><a class="btn btn-primary btn-xs" href="admin/receipt.aspx?token='+token+'&username='+USER+'&pwd='+PWD+'" target="_blank">查看</a></td></tr>';
																});
																$("#List").html(html);
																$("#subTitle").html('开放数据竞赛2017<br /><br /><small><a class="btn btn-default" href="mailto:'+mailList+'">给全体领队放送邮件</a></small><br /><br /><small><button class="btn " type="button" id="showAll">全部表单</button>&nbsp;<button class="btn btn-success" type="button" id="showSuc">已提交作品队伍 <span class="badge">'+SUC_CNT+'</span></button></small>');
																$("#showSuc").click(
																	function(){
																			$("#List tr").show();
																			$("#List tr:not(.success)").hide();
																	});
																$("#showSucOnly").click(
																	function(){
																			$("#List tr").show();
																			$("#List tr:not(.info)").hide();
																	});
																$("#showAll").click(
																	function(){
																			$("#List tr").show();																			
																	});
														} else {
																alert(json.errmsg);
														}
												}
										});								
								}else{
										$("#myModal").modal("show");									
								}
						});
        </script>
    </body>

</html>