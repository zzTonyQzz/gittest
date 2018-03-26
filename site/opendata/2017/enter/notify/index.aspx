<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>
<!DOCTYPE html>
<html lang="zh-cn">    
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0" />
        <title>
            邮件/短信 通知 - 开放数据竞赛2017·上海图书馆
        </title>
        <!-- Bootstrap -->
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <script src="../js/jquery-1.8.2.min.js">
        </script>
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
		.print { page-break-after:always;}
		.alert-dismissable, .alert-dismissible {
		padding-right: 10px;
		}
		#mobileArray {
			border:1px solid #ccc;
			min-height: 200px;
		}
		#mobileArray button{
			float:left;
			display: inline;
			margin: 5px;
		}
		#mobileArray button span{
			margin-left: 5px;
		}
		</style>
	   <script type="text/javascript">
		function keypress() {
			var text1 = $("#scontent").val();
			var len;
			var chineseRegex = /[^\x00-\xff]/g;
			if (text1.replace(chineseRegex, '**').length >= 120) {
				document.getElementById('scontent').value = subString(text1, 120, 1);
				len = 0
			} else {
				len = 120 - text1.replace(chineseRegex, '**').length
			}
			var show = '你还可以输入' + len + '个字符（' + Math.floor(len / 2) + '个汉字或' + len + '个字母）';
			document.getElementById('pinglun').innerText = show
			//console.log(text1);
		}
		$(document).ready(function(e) {

			
			$("#listGetTotal").on("click",function(){
				$("#mobileArray").empty();
				$.get("jsonp/CafeteriaUserList.aspx",{
					},
				function(json){
					if(json.flag=="true"){
						var verfiyNumbers=0;
						alert("共有用户 "+json.data.length+" 人");
						//console.log(json.data[0].mobile);
						var partten = /^1[3,5]\d{9}$/;
						$.each(json.data,function(index,element){
							if(partten.test(element.mobile)){
								var html = '<button class="btn btn-primary btn-sm" type="button"><span class="mobileNumber" data-ctid="'+element.ct_id+'" data-ctname="'+element.name+'">'+element.mobile+'</span><span>'+element.name+'</span><span class="badge">X</span></button>';
								$("#mobileArray").append(html);
								verfiyNumbers++;
							}
						});
						$("#mobileArray").append('<div class="clearfix"></div>');
						$("#mobileArray button .badge").on("click",function(){
							$(this).parent().remove();
						});
						alert("有效手机号码总数："+verfiyNumbers);
					}else{
						alert("没有用户数据！");
					}
				});
			});
			$("#send").on("click",function(){
				$("#mobileArray button").each(function(index, element) {
					var mobielNumber = $(element).find(".mobileNumber").text();
					var scontent = $("#scontent").val();
					if($(element).find(".mobileNumber").data("ctid")){
						//scontent= $(element).find(".mobileNumber").data("ctname")+"("+$(element).find(".mobileNumber").data("ctid")+"):"+scontent;
					}
					var thisItem = $(element);
					console.log(scontent)
					$.ajax({
						type: "POST",
						url: "json/etextNew.aspx",
						data: {
							"mobile":mobielNumber,
							"scontent":scontent
						},
						timeout: 10000,
						dataType: 'json',
						async:false,
						error: function(XMLHttpRequest, textStatus, errorThrown) {
							alert("系统出错，请刷新页面重试！");
						},
						success: function(json) {
							var msg=json.msg;
							var mobile=json.mobile;
							if(msg=="发送成功！"){
								$(thisItem).removeClass("btn-danger");
								$(thisItem).addClass("btn-success");

							}else{
								$(thisItem).removeClass("btn-success");
								$(thisItem).addClass("btn-danger");

							}

						}
					});

				});

			});
		});

	</script>
    </head>
    <body>
		<div class="container">
		<h3 class="text-center">发送短信</h3>
		<div class="form-group">
			<label for="disabledSelect">发送列表</label>

			<div id="mobileArray">

			</div>
		</div>
		<div class="form-inline">
			<div class="form-group">
				<label class="sr-only" for="exampleInputAmount">
					Amount (in dollars)
				</label>
				<div class="input-group">
					<div class="input-group-addon">
						添加手机号
					</div>
					<input type="text" class="form-control" id="mobile" placeholder="">
					<div class="input-group-addon">
						回车添加
					</div>
				</div>
			</div>
			<button type="submit" class="btn btn-primary" id="listGet" >
				调用订单列表mobile
			</button>
			<button type="submit" class="btn btn-primary" id="listGetTotal">
				调用餐厅所有用户mobile
			</button>
		</div>

		<div class="form-group">
			<label for="disabledSelect">短信文本</label>
			<textarea class="form-control" rows="3" id="scontent" onKeyUp="keypress()" onblur="keypress()"></textarea>
			<label id="pinglun" style="color:#999">你还可以输入120个字符（60个汉字或120个字母）</label>
		</div>
		<button class="btn btn-primary" id="send">发送！</button>
		</div>    
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">登录</h4>
              </div>
              <div class="modal-body">
                  <form class="form-horizontal" onsubmit="return false;" role="form" id="hqxuForm" action="index.aspx" method="post">
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
        <script src="../js/bootstrap.min.js">
        </script>
        <script src="../js/jquery.validate.min.js"></script>
        <script src="../js/messages_zh.js"></script>
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
								if(USER&&PWD){
									
								}else{
									$("#myModal").modal("show");									
								}
							$("#mobile").keydown(function(e) {
				if (e.keyCode == 13) {
					var mobielNumber = $("#mobile").val();
					var partten = /^1[3456789]\d{9}$/;
					if(partten.test(mobielNumber)){
						$("#mobileArray .clearfix").remove();
						var html = '<button class="btn btn-primary btn-sm" type="button"><span class="mobileNumber">'+mobielNumber+'</span><span class="badge">X</span></button>';
						$("#mobileArray").append(html);
						$("#mobileArray").append('<div class="clearfix"></div>');
						$("#mobileArray button .badge").on("click",function(){
							$(this).parent().remove();
						});
						$("#mobile").val("");
					}else{
						alert("手机号码格式不正确！");
					}

				}
			});
			$("#listGet").on("click",function(){
				$("#mobileArray").empty();
				var array = new Array();
				if(USER&&PWD){
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
									alert(json.errmsg);
							},
							success: function (json) {
									if (json.flag === "true") {
											var html = '';
											$.each(json.data,function(index,element){
													var teamname = element.teamname;
													var ATTENname = element.ATTENname;
													var teammembernums = element.teammembernums;
													var workname = element.workname;
													var workstyle = element.workstyle;
													var training = element.training;
													var token = element.token;
													var ip = element.ip;
													var className = "";
													console.log(teamname);


													
											});
											
									} else {
											alert(json.errmsg);
									}
							}
					});								
			}else{
					$("#myModal").modal("show");									
			}
					$.get("json/getList.aspx",{
						},
					function(json){
						if(json.flag=="true"){
							var data = json.data;
							/*$.each(data,function(index,element){
								$.each(element,function(index2,element2){
									if(index2=="order_id"){
										array.push(element2)
									}else{
										//
									}
								})
							})*/
							alert("3月1日后订单人数（去重）："+data.length);
							var verfiyNumbers=0;
							$("#mobileArray .clearfix").remove();
							$.each(data,function(index0,element0){	

								var partten = /^1[3456789]\d{9}$/;;
								if(partten.test(element0.mobile)){
									var html = '<button class="btn btn-primary btn-sm" type="button"><span class="mobileNumber" data-ctid="'+element0.ct_id+'" data-ctname="'+element0.ct_name+'">'+element0.mobile+'</span><span>'+element0.ct_name+'</span><span class="badge">X</span></button>';
									$("#mobileArray").append(html);
									verfiyNumbers++;
								}else{
									console.log(element0.mobile)
								}
							/*$.ajax({
								type: "POST",
								url: "jsonp/NewYearFood2015OrderGetByOrderid.aspx",
								data: {"order_id":order_id},
								async: false,
								success:function(json){
									if(json.flag=="true"){
										//console.log(json.data[0].mobile);
										var partten = /^1[3456789]\d{9}$/;;
										if(partten.test(json.data[0].mobile)){
											var html = '<button class="btn btn-primary btn-sm" type="button"><span class="mobileNumber" data-ctid="'+json.data[0].ct_id+'" data-ctname="'+json.data[0].ct_name+'">'+json.data[0].mobile+'</span><span>'+json.data[0].ct_name+'</span><span class="badge">X</span></button>';
											$("#mobileArray").append(html);
											verfiyNumbers++;
										}else{
											console.log(json.data[0].mobile)
										}



										}else{
										alert("获取数据失败！请重试");
									}
								}

							});*/

							});
							$("#mobileArray").append('<div class="clearfix"></div>');
							$("#mobileArray button .badge").on("click",function(){
								$(this).parent().remove();
							});
							alert("有效手机号码总数："+verfiyNumbers);



						}
					});



			});
						});
        </script>
    </body>

</html>