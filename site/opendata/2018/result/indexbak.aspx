<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" validateRequest="false"%>

<!DOCTYPE html>
<html lang="zh-cn">    
    <head runat="server">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0" />
        <title>
            作品提交内容一览表 - 上海图书馆2017开放数据应用开发竞赛
        </title>
        <!-- Bootstrap -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

		<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
		<link rel="stylesheet" href="css/jquery.fileupload.css">
		<link rel="stylesheet" href="css/jquery.fileupload-ui.css">

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
			.input-group, #memberlistBtn {
				margin-top: 5px;
			}
			.alert {				
				font-size: 1.5em;
			}
			.alert p {	
				font-size: 0.7em;
			}
		</style>
    </head>
    <body>
		<div class="container">
 	     
         
          <div class="projects-header page-header">		  	
			<h2 class="text-center">上海图书馆2017开放数据应用开发竞赛</h2>  
			<h3 class="text-center">作品提交</h3> 			
		  </div>           
          <div class="bs-callout bs-callout-info" id="callout-helper-context-color-specificity">			
			<p style="line-height: 1.5em;font-size: 1.1em; text-indent: 2em;">作品提交时间：7月11日 - <span style="color: #FF0000;">8月11日</span>。</p>
			<p style="line-height: 1.5em;font-size: 1.1em; text-indent: 2em;">欢迎您参加上海与图书馆2017开放数据应用开发竞赛，希望您填写的信息及上传的作品真实完整且符合<a href="http://pcrc.library.sh.cn/zt/opendata/2017/#rule" target="_blank">竞赛规则</a>。作品提交前请认真审核所提交内容，各项信息及作品一旦提交不予更改。我们也承诺对所有涉及个人隐私的信息予以严格保密。</p>
			<p style="line-height: 1.5em;font-size: 1.1em; text-indent: 2em;">如在提交过程中有任何问题，请联系 <a href="mailto:zyzhang@libnet.sh.cn" class="">zyzhang@libnet.sh.cn</a>，电话 021-64281593。</p>
		  </div> 
          <div id="step1" style="display: <%= step1Show %>">
			<div class="alert alert-info text-center" role="alert"> <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
			<span class="sr-only">info:</span>
			&nbsp;&nbsp;身&nbsp;&nbsp;份&nbsp;&nbsp;校&nbsp;&nbsp;验
			</div>
			<form class="form-horizontal" onSubmit="return false;" role="form0" id="hqxuForm0">
				<div class="form-group">
				  <label for="ATTENname" class="col-sm-2 control-label">*领队姓名</label>
				  <div class="col-sm-10">
					<input type="text" class="form-control" id="hqxuForm0_ATTENname" name="ATTENname" placeholder="领队姓名" value="">
				  </div>
				</div>
				<div class="form-group">
				  <label for="checkStyle" class="col-sm-2 control-label">*选择校验方式</label>
				  <div class="col-sm-10">
					<label class="radio-inline" style="margin-left: 10px;">
					  <input type="radio" name="checkStyle" id="checkStyle_A1" value="mobile" checked>
					  手机			  
					</label>
					<label class="radio-inline">
					  <input type="radio" name="checkStyle" id="checkStyle_A2" value="email">
					  邮箱
					</label>                
				  </div>
				</div>
				<div class="form-group" id="hqxuForm0_ATTENmobile">
				  <label for="ATTENmobile" class="col-sm-2 control-label">*手机</label>
				  <div class="col-sm-10">
					<input type="text" class="form-control" name="ATTENmobile" placeholder="手机" value="">
				  </div>
				</div>
				<div class="form-group" id="hqxuForm0_ATTENmail" style="display:none">
				  <label for="ATTENmail" class="col-sm-2 control-label">*邮箱</label>
				  <div class="col-sm-10">
					<input type="text" class="form-control" name="ATTENmail" placeholder="邮箱">
				  </div>
				</div>
				<div class="form-group">
					<div class="col-sm-12">
						<button id="hqxuForm0_Submit" type="submit" class="btn btn-primary btn-block"> 校 验 </button>
					</div>
				</div>
			</form>
          </div>
          <div id="step2" style="display: <%= step2Show %>">
			<form class="form-horizontal" onSubmit="return false;" role="form" id="hqxuForm">
				
				<div class="alert alert-info text-center" role="alert">
					<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>
					<span class="sr-only">work:</span>
					&nbsp;&nbsp;作&nbsp;&nbsp;品&nbsp;&nbsp;提&nbsp;&nbsp;交
				</div>
				<input type="hidden" name="teamid" value="" />
				<div class="form-group">
				  <label for="teamname" class="col-sm-2 control-label">*团队名称</label>
				  <div class="col-sm-10">
					<input type="text" class="form-control" id="teamname" name="teamname" disabled>
				  </div>
				</div>
				<div class="form-group">
				  <label for="workname" class="col-sm-2 control-label">*作品名称</label>
				  <div class="col-sm-10">
					<input type="text" class="form-control" id="workname" name="workname" placeholder="作品名称">
				  </div>
				</div>
				<div class="form-group">
				  <label for="workstyle" class="col-sm-2 control-label">*作品形式（多选）</label>
				  <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="checkbox" name="workstyle" id="workstyle_A1" value="IOS APP">
					  IOS APP
					</label>
					<label class="radio-inline">
					  <input type="checkbox" name="workstyle" id="workstyle_A2" value="Android APP">
					  Android APP
					</label>
					<label class="radio-inline">
					  <input type="checkbox" name="workstyle" id="workstyle_A3" value="微站">
					  微站
					</label>						                      
				  </div>
				</div>
				<div class="form-group">
				  <label for="workUsingData" class="col-sm-2 control-label">*使用数据情况</label>
				  <div class="col-sm-10">
					<label class="radio-inline">
					  <input type="radio" name="workUsingData" id="workUsingData_A1" value="inner">
					  仅使用上海图书馆所开放的数据
					</label>
					<div class="clearfix"></div>
					<label class="radio-inline">
					  <input type="radio" name="workUsingData" id="workUsingData_A2" value="outter">
					  除上海图书馆所开放的数据外还使用了外部数据
					</label>	
					<div class="clearfix"></div>
					<div class="form-group" id="outterDataList" style="display:block">					  
					  <div class="col-sm-12">
						<input type="text" class="form-control" name="outterDataList" placeholder="请填写具体外部数据源">
					  </div>
					</div>					                      
				  </div>
				</div>
				<div class="form-group">
				  <label for="workSummary" class="col-sm-2 control-label">*摘要</label>
				  <div class="col-sm-10">
					<textarea rows="5" class="form-control" id="workSummary" name="workSummary" placeholder="简要介绍作品（500字以内）"></textarea>
				  </div>
				</div>
				<div class="form-group">
				  <label for="workDetail" class="col-sm-2 control-label">*作品说明</label>
				  <div class="col-sm-10">
					<textarea rows="5" class="form-control" id="workDetail" name="workDetail" placeholder="描述作品构思切入点、解决的主要问题、技术实现方案、数据使用情况、创新点以及作品潜在价值等"></textarea>
				  </div>
				</div>
				<div class="form-group" style="margin-bottom: 0;">
					<label for="workFiles" class="col-sm-2 control-label">*上传程序或微站访问地址</label>
					<div class="col-sm-10">
						<div class="panel panel-info" style="padding-left: 15px;padding-right: 15px;">
							<div class="panel-body">
								<p><small>请打包成压缩文件（支持zip、rar格式）后上传<br />如提交多种形式的作品，请在打包文件内分成多个单独文件夹</small></p>
								<div class="form-group" id="miniSiteWrap" style="display: none;">
								  <label for="miniSite" class="control-label" style="float: left; margin-left: 2em;">*微站访问地址</label>
								  <div class="col-sm-10">
									<input type="text" class="form-control" id="miniSite" name="miniSite" placeholder="微站访问地址">
								  </div>
								</div>
								<div id="fileupload" action="http://pcrc.library.sh.cn/files/FileTransferHandler.ashx" method="POST" enctype="multipart/form-data">
									<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
									<div class="row fileupload-buttonbar">
										<div class="col-lg-7">
											<!-- The fileinput-button span is used to style the file input field as button -->
											<span class="btn btn-success fileinput-button">
												<i class="glyphicon glyphicon-plus"></i>
												<span>选择文件</span>
												<input type="file" name="files" >
											</span>
											<button type="submit" class="btn btn-primary start">
												<i class="glyphicon glyphicon-upload"></i>
												<span>开始上传</span>
											</button>
											<button type="reset" class="btn btn-warning cancel">
												<i class="glyphicon glyphicon-ban-circle"></i>
												<span>取消上传</span>
											</button>
											<button type="button" class="btn btn-danger delete">
												<i class="glyphicon glyphicon-trash"></i>
												<span>删除文件</span>
											</button>
											<input type="checkbox" class="toggle">
											<!-- The global file processing state -->
											<span class="fileupload-process"></span>
										</div>
										<!-- The global progress state -->
										<div class="col-lg-5 fileupload-progress fade">
											<!-- The global progress bar -->
											<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
												<div class="progress-bar progress-bar-success" style="width:0%;"></div>
											</div>
											<!-- The extended global progress state -->
											<div class="progress-extended">&nbsp;</div>
										</div>
									</div>
									<!-- The table listing the files available for upload/download -->
									<table role="presentation" class="table table-striped"><tbody class="files" id="workFiles"></tbody></table>
								</div>	 						
								
								
							</div>
						</div>
					</div>
				</div>
		    	<div class="form-group" style="margin-bottom: 0;">
					<label for="workVideo" class="col-sm-2 control-label">上传APP、微站LOGO（可选项）</label>
					<div class="col-sm-10">
						<div class="panel panel-info" style="padding-left: 15px;padding-right: 15px;">
							<div class="panel-body">
								<p><small>注：LOGO（APP、微站徽标）应当具有识别性（易识别、易记忆）、特异性（自主设计，具有差异性）、内涵性（象征意义），且无敏涵字样、形状和语言；建议分辨率 600*600 px<br/>支持格式：jpg、jpeg、png</small></p>
								<div id="fileupload3" action="http://pcrc.library.sh.cn/files/FileTransferHandler.ashx" method="POST" enctype="multipart/form-data">
									<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
									<div class="row fileupload-buttonbar">
										<div class="col-lg-7">
											<!-- The fileinput-button span is used to style the file input field as button -->
											<span class="btn btn-success fileinput-button">
												<i class="glyphicon glyphicon-plus"></i>
												<span>选择文件</span>
												<input type="file" name="file">
											</span>
											<button type="submit" class="btn btn-primary start">
												<i class="glyphicon glyphicon-upload"></i>
												<span>开始上传</span>
											</button>
											<button type="reset" class="btn btn-warning cancel">
												<i class="glyphicon glyphicon-ban-circle"></i>
												<span>取消上传</span>
											</button>
											<button type="button" class="btn btn-danger delete">
												<i class="glyphicon glyphicon-trash"></i>
												<span>删除文件</span>
											</button>
											<input type="checkbox" class="toggle">
											<!-- The global file processing state -->
											<span class="fileupload-process"></span>
										</div>
										<!-- The global progress state -->
										<div class="col-lg-5 fileupload-progress fade">
											<!-- The global progress bar -->
											<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
												<div class="progress-bar progress-bar-success" style="width:0%;"></div>
											</div>
											<!-- The extended global progress state -->
											<div class="progress-extended">&nbsp;</div>
										</div>
									</div>
									<!-- The table listing the files available for upload/download -->
									<table role="presentation" class="table table-striped"><tbody class="files" id="workLogo"></tbody></table>
								</div>				
							</div>
						</div>
					</div>
				</div>  
			    <div class="form-group" style="margin-bottom: 0;">
					<label for="workPPT" class="col-sm-2 control-label">*上传作品介绍PPT和PDF</label>
					<div class="col-sm-10">
						<div class="panel panel-info" style="padding-left: 15px;padding-right: 15px;">
							<div class="panel-body">
								<p><small>（PPT不超过15页，请上传PPT格式及PDF格式各一份）<br/>支持格式：ppt、pptx、pdf</small></p>								
								<div id="fileupload1" action="http://pcrc.library.sh.cn/files/FileTransferHandler.ashx" method="POST" enctype="multipart/form-data">
									<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
									<div class="row fileupload-buttonbar">
										<div class="col-lg-7">
											<!-- The fileinput-button span is used to style the file input field as button -->
											<span class="btn btn-success fileinput-button">
												<i class="glyphicon glyphicon-plus"></i>
												<span>选择文件</span>
												<input type="file" name="files[]" multiple>
											</span>
											<button type="submit" class="btn btn-primary start">
												<i class="glyphicon glyphicon-upload"></i>
												<span>开始上传</span>
											</button>
											<button type="reset" class="btn btn-warning cancel">
												<i class="glyphicon glyphicon-ban-circle"></i>
												<span>取消上传</span>
											</button>
											<button type="button" class="btn btn-danger delete">
												<i class="glyphicon glyphicon-trash"></i>
												<span>删除文件</span>
											</button>
											<input type="checkbox" class="toggle">
											<!-- The global file processing state -->
											<span class="fileupload-process"></span>
										</div>
										<!-- The global progress state -->
										<div class="col-lg-5 fileupload-progress fade">
											<!-- The global progress bar -->
											<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
												<div class="progress-bar progress-bar-success" style="width:0%;"></div>
											</div>
											<!-- The extended global progress state -->
											<div class="progress-extended">&nbsp;</div>
										</div>
									</div>
									<!-- The table listing the files available for upload/download -->
									<table role="presentation" class="table table-striped"><tbody class="files" id="workPPT"></tbody></table>
								</div>							
							</div>
						</div>
					</div>
				</div>
				<div class="form-group" style="margin-bottom: 0;">
					<label for="workVideo" class="col-sm-2 control-label">上传作品介绍视频（可选项，视频不超过50M）</label>
					<div class="col-sm-10">
						<div class="panel panel-info" style="padding-left: 15px;padding-right: 15px;">
							<div class="panel-body">
								<p><small>注：PPT及视频内容展示方式自定，原则是以最能充分表现其作品的优异性为前提，须客观真实反映作品的创意、功能和界面，可做截图或设计效果图，但不得与提交的其它材料内容有矛盾之处<br/>支持格式：MP4</small></p>
								<div id="fileupload2" action="http://pcrc.library.sh.cn/files/FileTransferHandler.ashx" method="POST" enctype="multipart/form-data">
									<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
									<div class="row fileupload-buttonbar">
										<div class="col-lg-7">
											<!-- The fileinput-button span is used to style the file input field as button -->
											<span class="btn btn-success fileinput-button">
												<i class="glyphicon glyphicon-plus"></i>
												<span>选择文件</span>
												<input type="file" name="file">
											</span>
											<button type="submit" class="btn btn-primary start">
												<i class="glyphicon glyphicon-upload"></i>
												<span>开始上传</span>
											</button>
											<button type="reset" class="btn btn-warning cancel">
												<i class="glyphicon glyphicon-ban-circle"></i>
												<span>取消上传</span>
											</button>
											<button type="button" class="btn btn-danger delete">
												<i class="glyphicon glyphicon-trash"></i>
												<span>删除文件</span>
											</button>
											<input type="checkbox" class="toggle">
											<!-- The global file processing state -->
											<span class="fileupload-process"></span>
										</div>
										<!-- The global progress state -->
										<div class="col-lg-5 fileupload-progress fade">
											<!-- The global progress bar -->
											<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
												<div class="progress-bar progress-bar-success" style="width:0%;"></div>
											</div>
											<!-- The extended global progress state -->
											<div class="progress-extended">&nbsp;</div>
										</div>
									</div>
									<!-- The table listing the files available for upload/download -->
									<table role="presentation" class="table table-striped"><tbody class="files" id="workVideo"></tbody></table>
								</div>								
							
							
							
							
							</div>
						</div>
					</div>
				</div>         

				<p class="text-center" style="margin-top: 40px;">
					<a href="javascript:void(0);" data-toggle="modal" data-target="#ruleModal">竞赛规则</a>
					<br />
					<label class="radio-inline">
					  <input type="checkbox" name="agreement" id="agreement" value="已阅读竞赛规则并同意">
					  本团队已知晓竞赛规则，并承诺所提交的作品符合规则要求
					</label>
				</p>
				<div class="form-group">
				  <div class="col-sm-12">
					<button type="submit" class="btn btn-primary btn-block" id="workSubmit" runat="server" >&nbsp;提&nbsp;&nbsp;交&nbsp;</button>
				  </div>
				</div>
			  </form>          	
          </div>   
        </div>
        
        <div class="modal fade" tabindex="-1" role="dialog" id="myModal">
		  <div class="modal-dialog" role="document">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">请确认信息</h4>
			  </div>
			  <div class="modal-body">
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
							<tr class="info text-center">
								<td colspan="2"><strong>作品提交</strong>
								</td>
							</tr>
							<tr>
								<td>团队名称</td>
								<td id="tabel-teamname"></td>
							</tr>
							<tr>
								<td>作品名称</td>
								<td id="tabel-workname"></td>
							</tr>
							<tr>
								<td>作品形式</td>
								<td id="tabel-workstyle"></td>
							</tr>
							<tr>
								<td>使用数据情况</td>
								<td id="tabel-workUsingData"></td>
							</tr>
							<tr>
								<td>摘要</td>
								<td id="tabel-workSummary"></td>
							</tr>
							<tr>
								<td>作品说明</td>
								<td id="tabel-workDetail"></td>
							</tr>
							<tr>
								<td>程序文件包</td>
								<td id="tabel-workFiles"></td>
							</tr>
							<tr>
								<td>LOGO</td>
								<td id="tabel-workLogo"></td>
							</tr>
							<tr>
								<td>微站访问地址</td>
								<td id="tabel-miniSiteUrl"></td>
							</tr>
							<tr>
								<td>作品介绍PPT和PDF</td>
								<td id="tabel-workPPT"></td>
							</tr>
							<tr>
								<td>作品介绍视频</td>
								<td id="tabel-workVideo"></td>
							</tr>							
						</tbody>
					</table>
				</div>
			  </div>
			  <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">返回修改</button>
				<button type="button" class="btn btn-primary" id="postBtn">确认提交</button>
			  </div>
			</div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
        
        
        <!-- /.modal -->
      	<div class="modal fade" tabindex="-1" role="dialog" id="ruleModal">
		  <div class="modal-dialog" role="document">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">竞赛规则</h4>
			  </div>
			  <div class="modal-body">
			  	<p style="text-indent: 0;">参赛者提交参赛作品，视为同意以下参赛规则：</p>
				<p style="text-indent: 2em;">1. 参赛作品可为任何形式的移动应用，以微站（移动Web应用）或IOS、Android等平台上的App为主要方式。</p>
				<p style="text-indent: 2em;">2. 参赛团队可由1人或数人组成，其中1至2人负责答辩和演示。参赛团队在报名时须提交真实的个人身份信息，主办方承诺对所有涉及个人隐私的信息予以严格保密，参赛团队报名提交的个人信息仅用于赛事相关程序。参赛团队名单以在官网上提交的报名表为准，不予更改。</p>
				<p style="text-indent: 2em;">3. 竞赛评奖的主要依据为作品的创新性、可行性、技术含量、交互体验、开放数据利用程度等。</p>
				<p style="text-indent: 2em;">4. 所有竞赛入围作品（含获奖作品）的知识产权归属作者和上海图书馆（上海科学技术情报研究所）双方共有。参赛作品应该为未经发表的原创作品，具有一定的创新性和独特性。</p>
				<p style="text-indent: 2em;">5. 竞赛评委由国家公共文化服务体系建设专家委员会专家，图书情报、计算机等领域的专家，上海图书馆理事会成员，专业媒体和用户代表等组成。评审分书面审查和现场答辩两个阶段，答辩的具体日期和时间将另行通知。</p>
				<p style="text-indent: 2em;">6. 有以下情况的，主办方可以取消参赛者参赛资格：</p>
				<p style="text-indent: 4em;">a) 违反相关法律、法规；</p>
				<p style="text-indent: 4em;">b) 涉嫌作弊行为，侵犯他人知识产权；</p>
				<p style="text-indent: 4em;">c) 提交的作品缺乏必要的完整性，或有严重缺陷，或涉嫌虚假信息；</p>
				<p style="text-indent: 4em;">d) 提交的作品包含不健康、淫秽、色情或诽谤任何第三方的内容；</p>
				<p style="text-indent: 4em;">e) 提交的作品包含其他主办方认为不适当的内容。</p>
				<p style="text-indent: 2em;">7. 如由于提交的竞赛作品而引起任何法律纠纷，或附带的责任，均由提交作品的参赛团队组成人员个人承担，主办方不承担任何责任。</p>
				<p style="text-indent: 2em;">8. 所有与参赛相关的提交材料均不予退还。主办方有权将参赛作品及相关信息用于制作纸质、音频、视频等形式的宣传品和出版物（传播途径包括互联网），以及举办展览展示活动（展览展示途径包括互联网）等。</p>
				<p style="text-indent: 2em;">9. 本次竞赛实行回避制度，以示公允，主办方员工不参加评奖。评委对作品的评审结果一旦给出即为最终结果，主办方无义务提供任何反馈意见。</p>
				<p style="text-indent: 2em;">10. 主办方保留对该竞赛规则修订的权利，并拥有对竞赛规则的最终解释权。</p>			
				
			  </div>
			  <div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>				
			  </div>
			</div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div>
       	<!-- The template to display files available for upload -->
		<script id="template-upload" type="text/x-tmpl">
		{% for (var i=0, file; file=o.files[i]; i++) { %}
			<tr class="template-upload fade">
				<td>
					<p class="name">{%=file.name%}</p>
					<strong class="error text-danger"></strong>
				</td>
				<td>
					<p class="size">Processing...</p>
					<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
				</td>
				<td>
					{% if (!i && !o.options.autoUpload) { %}
						<button class="btn btn-primary start" disabled>
							<i class="glyphicon glyphicon-upload"></i>
							<span>开始上传</span>
						</button>
					{% } %}
					{% if (!i) { %}
						<button class="btn btn-warning cancel">
							<i class="glyphicon glyphicon-ban-circle"></i>
							<span>取消上传</span>
						</button>
					{% } %}
				</td>
			</tr>
		{% } %}
		</script>
		<!-- The template to display files available for download -->
		<script id="template-download" type="text/x-tmpl">
		{% for (var i=0, file; file=o.files[i]; i++) { %}
			<tr class="template-download fade">

				<td>
					<p class="name" data-url="{%=file.url%}">
						{% if (file.url) { %}
							{%=file.name%}
						{% } else { %}
							<span>{%=file.name%}</span>
						{% } %}
					</p>
					{% if (file.error) { %}
						<div><span class="label label-danger">Error</span> {%=file.error%}</div>
					{% } %}
				</td>
				<td>
					<span class="size">{%=o.formatFileSize(file.size)%}</span>
				</td>
				<td>
					{% if (file.deleteUrl) { %}
						<button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
							<i class="glyphicon glyphicon-trash"></i>
							<span>删除文件</span>
						</button>
						<input type="checkbox" name="delete" value="1" class="toggle">
					{% } else { %}
						<button class="btn btn-warning cancel">
							<i class="glyphicon glyphicon-ban-circle"></i>
							<span>取消上传</span>
						</button>
					{% } %}
				</td>
			</tr>
		{% } %}
		</script>
		
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery-1.8.2.min.js"></script>
        <!-- Include all compiled plugins (below), or include individual files
        as needed -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.validate.min.js"></script>
        <script src="js/messages_zh.js"></script>        
		<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
		<!-- The Templates plugin is included to render the upload/download listings -->
		<script src="//blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>

		<script src="js/vendor/jquery.ui.widget.js"></script>
		

        <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
		<script src="js/jquery.iframe-transport.js"></script>
		<!-- The basic File Upload plugin -->
		<script src="js/jquery.fileupload.js"></script>
		<!-- The File Upload processing plugin -->
		<script src="js/jquery.fileupload-process.js"></script>


		<!-- The File Upload validation plugin -->
		<script src="js/jquery.fileupload-validate.js"></script>
		<!-- The File Upload user interface plugin -->
		<script src="js/jquery.fileupload-ui.js"></script>
		<script>
			var TEAMID,TEAMNAME_OLD,WROKNAME_OLD;
		</script>
		<script src="js/main.js"></script>        
		<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
		<!--[if (gte IE 8)&(lt IE 10)]>
		<script src="js/cors/jquery.xdr-transport.js"></script>
		<![endif]-->
		<script>
			$(document).ready(function(e) {				
				$(":input[name=checkStyle]").on("click",function(){
					var checkStyle = $(":input[name=checkStyle]:checked").val();
					if(checkStyle=="mobile"){
						$("#hqxuForm0_ATTENmail").hide();
						$("#hqxuForm0_ATTENmobile").show();
					}else{
						$("#hqxuForm0_ATTENmobile").hide();
						$("#hqxuForm0_ATTENmail").show();
					}					
				});
				$("#hqxuForm0_Submit").on("click",function(){
					var checkStyle = $(":input[name=checkStyle]:checked").val();
					var ATTENname = $("#hqxuForm0_ATTENname").val().trim();
					var ATTENmobile = "";
					var ATTENmail = "";
					if(!ATTENname){
						alert("请填写领队姓名！");
						return false
					}
					if(checkStyle=="mobile"){
						ATTENmobile = $(":input[name=ATTENmobile]").val();;
						ATTENmail = "";
						if(!ATTENmobile){
							alert("请填写领队手机！");
							return false
						}
					}else{
						ATTENmail = $(":input[name=ATTENmail]").val();;
						ATTENmobile = "";
						if(!ATTENmail){
							alert("请填写领队邮箱！");
							return false
						}
					}
					$("#hqxuForm0_Submit").attr("disabled",true);
					$.ajax({
						type: "POST",
						url: "json/step1.aspx",
						data: {
							ATTENname: ATTENname,
							ATTENmobile: ATTENmobile,
							ATTENmail: ATTENmail
						},
						timeout: 5000,
						dataType: 'json',
						error: function(XMLHttpRequest, textStatus, errorThrown) {
							alert("获取数据失败，请刷新页面！");
							$("#hqxuForm0_Submit").removeAttr("disabled");
						},
						success: function(json) {
							if (json.flag === "true") {
								TEAMID = json.data[0].teamid;
								TEAMNAME_OLD = json.data[0].teamname;
								WROKNAME_OLD = json.data[0].workname_old;
								var STATE = json.data[0].state;
								if(STATE!=0){
									alert("已提交过作品，不能重复提交！");
									$("#hqxuForm0_Submit").removeAttr("disabled");
									return false
								}
								alert("校验成功！\n\r团队："+TEAMNAME_OLD+"\n\r");
								//console.log(TEAMID,TEAMNAME_OLD,WROKNAME_OLD);
								$(":input[name=teamid]").val(TEAMID);
								$(":input[name=teamname]").val(TEAMNAME_OLD);
								$(":input[name=workname]").val(WROKNAME_OLD);
								$('#fileupload,#fileupload1,#fileupload2,#fileupload3').fileupload({
									url: 'http://pcrc.library.sh.cn/files/FileTransferHandler.ashx?hqxu=team_'+TEAMID
								});
								$("#step1").hide();
								$("#step2").show();
							} else {
								alert(json.errmsg);
								$("#hqxuForm0_Submit").removeAttr("disabled");
							}
						}
					});
				});
				$(":input[name=workUsingData]").on("click",function(){
					var workUsingData = $(":input[name=workUsingData]:checked").val();
					if(workUsingData=="inner"){
						$("#outterDataList").hide();						
					}else{
						$("#outterDataList").show();
					}						
					//console.log(workUsingData);					
				});
				$("#workstyle_A3").on("click",function(){
					var miniSite = $("#workstyle_A3").prop('checked');
					if(miniSite){
						$("#miniSiteWrap").show();					
					}else{
						$("#miniSiteWrap").hide();			
					}					
				});
				
				$("#workSubmit").on("click",function(){
					//var data = $('#hqxuForm').serializeArray();
					var teamid = $('#hqxuForm :input[name=teamid]').val();
					var teamname = $('#hqxuForm :input[name=teamname]').val();
					var workname = $('#workname').val().trim();	
					if(!workname){
						alert("请填写作品名称！");
						return false
					}
					var workstyle = "";
					if($('#hqxuForm :input[name=workstyle]:checked').length<1){
						alert("请选择作品形式！");
						return false
					}
					$('#hqxuForm :input[name=workstyle]:checked').each(function(index,element){
						workstyle += $(element).val() + "#";
					});
					workstyle =  workstyle.substring(0,(workstyle.length-1));
					if($('#hqxuForm :input[name=workUsingData]:checked').length<1){
						alert("请选择使用数据情况！");
						return false
					}
					var workUsingData = $('#hqxuForm :input[name=workUsingData]:checked').val();
					if(workUsingData=="outter"){
						if(!$('#hqxuForm :input[name=outterDataList]').val().trim()){
							alert("请填写具体使用的外部数据！");
							return false
						}
						workUsingData = $('#hqxuForm :input[name=outterDataList]').val();
					}
					var workSummary = $('#workSummary').val().trim().replace(/\n/g,"<br/>");	
					if(!workSummary){
						alert("请填写作品摘要！");
						return false
					}
					var workDetail = $('#workDetail').val().trim().replace(/\n/g,"<br/>");	
					if(!workDetail){
						alert("请填写作品说明！");
						return false
					}
					if(($("#workFiles>.template-download>td>.name").length!=1 && (!$("#workstyle_A3").prop('checked') && $('#hqxuForm :input[name=workstyle]:checked').length==1)) || ($("#workFiles>.template-download>td>.name").length!=1 && $('#hqxuForm :input[name=workstyle]:checked').length>1) ){
						alert("请上传程序！");
						return false
					}
					if((!$("#workFiles>.template-download>td>.name").eq(0).data("url")&& (!$("#workstyle_A3").prop('checked') && $('#hqxuForm :input[name=workstyle]:checked').length==1)) || (!$("#workFiles>.template-download>td>.name").eq(0).data("url") && $('#hqxuForm :input[name=workstyle]:checked').length>1) ){
						alert("请正确上传程序！");
						return false
					}
					var miniSiteUrl = "";
					miniSiteUrl = $('#hqxuForm :input[name=miniSite]').val().trim();
					if($("#workstyle_A3").prop('checked') && miniSiteUrl==""){
						alert("请填写微站地址，若尚未发布，请填写 localhost！");
						return false
					}
					var workFiles = "";
					var workFilesUrl = "";
					if($("#workFiles>.template-download>td>.name").length==1){
						workFiles = $("#workFiles>.template-download>td>.name").eq(0).html().trim();
						workFilesUrl = $("#workFiles>.template-download>td>.name").eq(0).data("url").trim();
					}		
					var workLogo = "";
					var workLogoUrl = "";
					if($("#workLogo>.template-download>td>.name").length==1){
						workLogo = $("#workLogo>.template-download>td>.name").eq(0).html().trim();
						workLogoUrl = $("#workLogo>.template-download>td>.name").eq(0).data("url").trim();
					}	
					if($("#workPPT>.template-download>td>.name").length!=2){
						alert("请上传作品介绍(PPT和PDF)！");
						return false
					}
					if(!$("#workPPT>.template-download>td>.name").eq(0).data("url")&&!$("#workPPT>.template-download>td>.name").eq(1).data("url")){
						alert("请正确上传作品介绍PPT和PDF文档！");
						return false
					}			
					var ppt1 = $("#workPPT>.template-download>td>.name").eq(0).html().trim();
					var ppt2 = $("#workPPT>.template-download>td>.name").eq(1).html().trim();
					//console.log(ppt1.split(".")[(ppt1.split(".").length-1)], ppt2.split(".")[(ppt2.split(".").length-1)]);
					if(ppt1.split(".")[ppt1.split(".").length-1] == ppt2.split(".")[ppt2.split(".").length-1] || (ppt1.split(".")[ppt1.split(".").length-1]!="pdf" && ppt2.split(".")[ppt2.split(".").length-1]!="pdf")){
						alert("请上传作品介绍PPT和PDF文档各一份！");
						return false
					} 
					var workPPT = $("#workPPT>.template-download>td>.name").eq(0).html().trim()+"、"+$("#workPPT>.template-download>td>.name").eq(1).html().trim();
					var workPPTUrl = $("#workPPT>.template-download>td>.name").eq(0).data("url").trim()+"#hqxu#"+$("#workPPT>.template-download>td>.name").eq(1).data("url").trim();
					var workVideo = "";
					var workVideoUrl = "";
					if($("#workVideo>.template-download>td>.name").length==1){
						workVideo = $("#workVideo>.template-download>td>.name").eq(0).html().trim();
						workVideoUrl = $("#workVideo>.template-download>td>.name").eq(0).data("url").trim();
					}
					var agreementSign = $("#agreement").prop('checked');
					if(!agreementSign){
						alert("请确认提交作品符合规则要求，并勾选表单末的确认框！");
						return false
					}
					//console.log(TEAMID,TEAMNAME_OLD,workname,workstyle,workUsingData,workSummary,workDetail,workFiles,workFilesUrl,workLogo,workLogoUrl,miniSiteUrl,workPPT,workPPTUrl,workVideo,workVideoUrl);
					$("#List #tabel-teamname").html(teamname);
					$("#List #tabel-workname").html(workname);
					$("#List #tabel-workstyle").html(workstyle);
					if(workUsingData=="inner"){
						$("#List #tabel-workUsingData").html('仅使用上海图书馆所开放的数据');
					}else{
						$("#List #tabel-workUsingData").html('除上海图书馆所开放的数据外还使用了外部数据：'+workUsingData);
					}					
					$("#List #tabel-workSummary").html(workSummary);
					$("#List #tabel-workDetail").html(workDetail);
					$("#List #tabel-workFiles").html(workFiles?workFiles:"未上传");
					$("#List #tabel-workLogo").html(workLogo?workLogo:"未上传");
					if(miniSiteUrl){
						$("#List #tabel-miniSiteUrl").html(miniSiteUrl).parent("tr").show();
					}else{
						$("#List #tabel-miniSiteUrl").parent("tr").hide();
					}						
					$("#List #tabel-workPPT").html(workPPT);					
					if(workVideo){
						$("#List #tabel-workVideo").html(workVideo).parent("tr").show();
					}else{
						$("#List #tabel-workVideo").parent("tr").hide();
					}	
					$('#myModal').modal('show');
					$("#postBtn").unbind().on("click",function(){
						$("#Submit").attr("disabled",true);
						$(":input").attr("disabled",true);
						$.ajax({
							type: "POST",
							url: "json/dataprocess.aspx",
								//(teamid,teamname,workname,workstyle,workUsingData,workSummary,workDetail,workFiles,workFilesUrl,miniSiteUrl,workPPT,workPPTUrl,workVideo,workVideoUrl)
							data: {
								teamid: TEAMID,
								teamname: TEAMNAME_OLD,
								workname: workname,
								workstyle: workstyle,
								workUsingData: workUsingData,
								workSummary: workSummary,
								workDetail: workDetail,
								workFiles: workFiles,
								workFilesUrl: workFilesUrl,
								workLogo: workLogo,
								workLogoUrl: workLogoUrl,
								miniSiteUrl: miniSiteUrl,
								workPPT: workPPT,
								workPPTUrl: workPPTUrl,
								workVideo: workVideo,
								workVideoUrl: workVideoUrl
							},
							timeout: 10000,
							dataType: 'json',
							error: function(XMLHttpRequest, textStatus, errorThrown) {
								alert("页面出错，请重新提交表单；若多次提交失败，请刷新页面或者稍后再试！");
								$("#Submit").removeAttr("disabled");
								$(":input").removeAttr("disabled");
							},
							success: function(json) {
								if (json.flag === "true") {
										alert("作品提交表提交成功！回执单已发送至领队的邮箱，请注意查收！");
										var token = json.token;
										var url = 'http://pcrc.library.sh.cn/zt/opendata/2017/result/'+'receipt.aspx?token='+token;
										var t=setTimeout("location.href='"+url+"'",1000);
								} else {
										alert(json.errmsg);
										$('#myModal').modal('hide');
										$("#Submit").removeAttr("disabled");
										$(":input").removeAttr("disabled");
								}
							}
						});	
					})
				});
				
		});
        </script>
    </body>

</html>
