<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pNGAe1OrXWuM9dYM.aspx.cs" Inherits="index" validateRequest="false"%>

<!DOCTYPE html>
<html lang="zh-cn">    
    <head runat="server">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0" />
        <title>
            参赛报名表 - 上海图书馆2017开放数据应用开发竞赛
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
			<h3 class="text-center">参赛报名表( 增补 )</h3> 			
		  </div>           
          <div class="bs-callout bs-callout-info" id="callout-helper-context-color-specificity">			
			<p style="line-height: 1.5em;font-size: 1.1em; text-indent: 2em;">欢迎您报名参加上海图书馆2017开放数据应用开发竞赛，希望您填写的信息真实完整。我们承诺对所有涉及个人隐私的信息予以严格保密，报名提交的个人信息仅用于赛事。在填写过程中如有任何问题，请联系 <a href="mailto:zyzhang@libnet.sh.cn" class="">zyzhang@libnet.sh.cn</a>，电话 021-64281593。</p>
			<p style="line-height: 1.5em;font-size: 1.1em; text-indent: 2em;">报名参赛者有机会获得小小的惊喜！</p>
		  </div> 
          <div class="alert alert-info text-center" role="alert"> <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
			<span class="sr-only">info:</span>
		  	&nbsp;&nbsp;团&nbsp;&nbsp;队
          </div>   
          <form class="form-horizontal" onSubmit="return false;" role="form" id="hqxuForm">
          	<input name="token" id="token" value="" type="hidden">
            <div class="form-group">
              <label for="teamname" class="col-sm-2 control-label">*团队名称</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="teamname" name="teamname" placeholder="团队名称">
              </div>
            </div>
            <div class="form-group">
              <label for="nation" class="col-sm-2 control-label">*国家</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="nation" name="nation" placeholder="国家">
              </div>
            </div>
            <div class="form-group">
              <label for="province" class="col-sm-2 control-label">*省/直辖市/自治区</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="province" name="province" placeholder="省/直辖市/自治区，如 上海市">
                <select class="form-control" onchange="provinceSelectShow()" id="provinceList" name="provinceList" style="display: none;">
                  <option selected value="">请选择</option>
				</select>
              </div>
            </div>
            <div class="form-group" style="margin-bottom: 0;">
              <label for="ATTEN" class="col-sm-2 control-label">*领队（作为联系人）</label>
              <div class="col-sm-10">
                <div class="panel panel-info" style="padding-left: 15px;padding-right: 15px;">                  
                  <div class="panel-body">
                    <div class="form-group">
                      <label for="ATTENname" class="control-label">*姓名</label>
                      <div>
                        <input type="text" class="form-control" id="ATTENname" name="ATTENname" placeholder="姓名">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="ATTENcompany" class="control-label">*单位</label>
                      <div>
                        <input type="text" class="form-control" id="ATTENcompany" name="ATTENcompany" placeholder="单位">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="ATTENmobile" class="control-label">*手机</label>
                      <div>
                        <input type="text" class="form-control" id="ATTENmobile" name="ATTENmobile" placeholder="手机">
                      </div>
                    </div>
                    <div class="form-group">
                      <label for="ATTENmail" class="control-label">*邮箱</label>
                      <div>
                        <input type="text" class="form-control" id="ATTENmail" name="ATTENmail" placeholder="邮箱">
                      </div>
                    </div>
                  </div>
                </div>
			  </div>
            </div>
            <div class="form-group" style="margin-bottom: 0;">
              <label for="teammember" class="col-sm-2 control-label">*团队成员（包括领队）</label>
              <div class="col-sm-10">
                <div class="panel panel-info" style="padding-left: 15px;padding-right: 15px;">                  
                  <div class="panel-body">
                  	<div class="form-inline">
						<div class="form-group">							
							<div class="input-group">
								<div class="input-group-addon">*团队总人数</div>
								<input type="number" class="form-control" id="teammembernums" name="teammembernums" value="" min="1">							
							</div>
							<button type="button" class="btn btn-primary" id="memberlistBtn">确认</button>
						</div>						
					</div>
                    <div class="memberlist">
                    				
                    </div>
                  </div>
                </div>
			  </div>
            </div>            
            <div class="form-group">
              <label for="entryreason" class="col-sm-2 control-label">*请简述参赛原因</label>
              <div class="col-sm-10">
                <textarea rows="5" class="form-control" id="entryreason" name="entryreason" placeholder="简述参赛原因"></textarea>
              </div>
            </div>
            <div class="form-group">
              <label for="accessfrom" class="col-sm-2 control-label">*贵团队从何处<br class="hidden-xs"/>了解到有这个比赛</label>
              <div class="col-sm-10">
                <input type="hidden" class="form-control" id="accessfrom" name="accessfrom" placeholder="">
                <select class="form-control" onchange="accessfromSelectShow()" id="accessfromList" name="accessfromList">
                  <option selected value="">请选择</option>
				  <option>上图微信</option>
				  <option>上图信使微博</option>
				  <option>上图官网</option>
				  <option>公共文化研究上图基地微信</option>
				  <option>公共文化研究上图基地微博</option>
				  <option>公共文化研究上图基地官网</option>
				  <option>高校图书馆网站或海报</option>
				  <option>公共图书馆网站或海报</option>
				  <option>微信微博分享</option>
				  <option>社会媒体</option>
				  <option>其他</option>
				</select>
              </div>
            </div>
			<div class="alert alert-info text-center" role="alert">
				<span class="glyphicon glyphicon-folder-open" aria-hidden="true"></span>
				<span class="sr-only">work:</span>
				&nbsp;&nbsp;作&nbsp;&nbsp;品
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
              <label for="workenvironment" class="col-sm-2 control-label">*运行环境</label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="workenvironment" name="workenvironment" placeholder="运行环境">
              </div>
            </div>
			<div class="form-group">
              <label for="workidea" class="col-sm-2 control-label">*请简述作品创意</label>
              <div class="col-sm-10">
                <textarea rows="5" class="form-control" id="workidea" name="workidea" placeholder="简述作品创意"></textarea>
              </div>
            </div>
			<div class="form-group">
              <label for="workhadkey" class="col-sm-2 control-label">*是否已有API key</label>
              <div class="col-sm-10">
                <label class="radio-inline" style="margin-left: 10px;">
				  <input type="radio" name="workhadkey" id="workhadkey_A1" value="1">
				  是				  
				</label>
             	<label class="radio-inline">
				  <input type="radio" name="workhadkey" id="workhadkey_A2" value="0">
				  否&nbsp;&nbsp;( <small>注：报名后系统会给与独立的API key，供参赛者使用开放数据接口时进行验证。</small>)  
				</label>                
              </div>
            </div>
            <div class="alert alert-info text-center" role="alert">
				<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
				<span class="sr-only">work:</span>
				&nbsp;&nbsp;培&nbsp;&nbsp;训
				<br/>
				<p style="text-align: left; text-indent: 2em; margin-top: 10px;">主办方将于5月10日在上海图书馆举办“名人手稿及档案”数据及接口现场培训，分为上午集体讲解(9:00-11:30 上海图书馆会展中心5304 )、下午交流(13:30-16:00上海图书馆创·新空间1315)，欢迎各参赛团队前来参加。</p>
			</div>
			<div class="form-group">
              <label for="training" class="col-sm-2 control-label">*是否参加培训</label>
              <div class="col-sm-10">
                <label class="radio-inline" style="margin-left: 10px;">
				  <input type="radio" name="training" id="training_A1" value="参加全天">
				  参加全天
				  <br />参加人数：<input type="number" class="form-control" id="training_A1_text" name="training_A1_text" placeholder="" min="1">
				</label>
             	<label class="radio-inline">
				  <input type="radio" name="training" id="training_A2" value="仅参加上午场">
				  仅参加上午场	
				  <br />参加人数：<input type="number" class="form-control" id="training_A2_text" name="training_A2_text" placeholder="" min="1">				  
				</label>
				<label class="radio-inline" style="height: 81px;">
				  <input type="radio" name="training" id="training_A3" value="不参加">
				  不参加				  	  
				</label>
              </div>
            </div>           
            
            <p class="text-center" style="margin-top: 40px;">
            	<a href="javascript:void(0);" data-toggle="modal" data-target="#ruleModal">竞赛规则</a>
            	<br />
            	<label class="radio-inline">
				  <input type="checkbox" name="agreement" id="agreement" value="已阅读竞赛规则并同意">
				  已阅读竞赛规则并同意
				</label>
            </p>
            <div class="form-group">
              <div class="col-sm-12">
                <button type="submit" class="btn btn-primary btn-block" id="Submit" runat="server" >&nbsp;提&nbsp;&nbsp;交&nbsp;</button>
              </div>
            </div>
          </form>
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
								<td colspan="2"><strong>团队</strong>
								</td>
							</tr>
							<tr>
								<td>团队名称</td>
								<td id="tabel-teamname"></td>
							</tr>
							<tr>
								<td>国家</td>
								<td id="tabel-nation"></td>
							</tr>
							<tr>
								<td>省/直辖市/自治区</td>
								<td id="tabel-province"></td>
							</tr>
							<tr>
								<td>领队-姓名</td>
								<td id="tabel-ATTENname"></td>
							</tr>
							<tr>
								<td>领队-单位</td>
								<td id="tabel-ATTENcompany"></td>
							</tr>
							<tr>
								<td>领队-手机</td>
								<td id="tabel-ATTENmobile"></td>
							</tr>
							<tr>
								<td>领队-邮箱</td>
								<td id="tabel-ATTENmail"></td>
							</tr>
							<tr>
								<td>团队人数</td>
								<td  id="tabel-teammembernums"></td>
							</tr>
							<tr>
								<td>团队成员</td>
								<td id="tabel-teammemberlist">
								</td>
							</tr>
							<tr>
								<td>参赛原因</td>
								<td id="tabel-entryreason"></td>
							</tr>
							<tr>
								<td>竞赛消息来源</td>
								<td id="tabel-accessfrom"></td>
							</tr>
							<tr class="info text-center">
								<td colspan="2"><strong>作品</strong>
								</td>
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
								<td>运行环境</td>
								<td id="tabel-workenvironment"></td>
							</tr>
							<tr>
								<td>作品创意</td>
								<td id="tabel-workidea"></td>
							</tr>
							<tr>
								<td>是否已有apiKey</td>
								<td id="tabel-workhadkey"></td>
							</tr>
							<tr class="info text-center">
								<td colspan="2"><strong>培训</strong>
								</td>
							</tr>
							<tr>
								<td>培训</td>
								<td id="tabel-training"></td>
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
       
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery-1.8.2.min.js">
        </script>
        <!-- Include all compiled plugins (below), or include individual files
        as needed -->
        <script src="js/bootstrap.min.js">
        </script>
        <script src="js/jquery.validate.min.js"></script>
        <script src="js/messages_zh.js"></script>
        <script>
			var provinceArr = [{"ProID":1,"name":"北京市","ProSort":1,"ProRemark":"直辖市"},{"ProID":2,"name":"天津市","ProSort":2,"ProRemark":"直辖市"},{"ProID":3,"name":"河北省","ProSort":5,"ProRemark":"省份"},{"ProID":4,"name":"山西省","ProSort":6,"ProRemark":"省份"},{"ProID":5,"name":"内蒙古自治区","ProSort":32,"ProRemark":"自治区"},{"ProID":6,"name":"辽宁省","ProSort":8,"ProRemark":"省份"},{"ProID":7,"name":"吉林省","ProSort":9,"ProRemark":"省份"},{"ProID":8,"name":"黑龙江省","ProSort":10,"ProRemark":"省份"},{"ProID":9,"name":"上海市","ProSort":3,"ProRemark":"直辖市"},{"ProID":10,"name":"江苏省","ProSort":11,"ProRemark":"省份"},{"ProID":11,"name":"浙江省","ProSort":12,"ProRemark":"省份"},{"ProID":12,"name":"安徽省","ProSort":13,"ProRemark":"省份"},{"ProID":13,"name":"福建省","ProSort":14,"ProRemark":"省份"},{"ProID":14,"name":"江西省","ProSort":15,"ProRemark":"省份"},{"ProID":15,"name":"山东省","ProSort":16,"ProRemark":"省份"},{"ProID":16,"name":"河南省","ProSort":17,"ProRemark":"省份"},{"ProID":17,"name":"湖北省","ProSort":18,"ProRemark":"省份"},{"ProID":18,"name":"湖南省","ProSort":19,"ProRemark":"省份"},{"ProID":19,"name":"广东省","ProSort":20,"ProRemark":"省份"},{"ProID":20,"name":"海南省","ProSort":24,"ProRemark":"省份"},{"ProID":21,"name":"广西壮族自治区","ProSort":28,"ProRemark":"自治区"},{"ProID":22,"name":"甘肃省","ProSort":21,"ProRemark":"省份"},{"ProID":23,"name":"陕西省","ProSort":27,"ProRemark":"省份"},{"ProID":24,"name":"新疆维吾尔自治区","ProSort":31,"ProRemark":"自治区"},{"ProID":25,"name":"青海省","ProSort":26,"ProRemark":"省份"},{"ProID":26,"name":"宁夏回族自治区","ProSort":30,"ProRemark":"自治区"},{"ProID":27,"name":"重庆市","ProSort":4,"ProRemark":"直辖市"},{"ProID":28,"name":"四川省","ProSort":22,"ProRemark":"省份"},{"ProID":29,"name":"贵州省","ProSort":23,"ProRemark":"省份"},{"ProID":30,"name":"云南省","ProSort":25,"ProRemark":"省份"},{"ProID":31,"name":"西藏自治区","ProSort":29,"ProRemark":"自治区"},{"ProID":32,"name":"台湾省","ProSort":7,"ProRemark":"省份"},{"ProID":33,"name":"澳门特别行政区","ProSort":33,"ProRemark":"特别行政区"},{"ProID":34,"name":"香港特别行政区","ProSort":34,"ProRemark":"特别行政区"}];
			provinceArr.sort(function(a,b){
				return a.ProSort - b.ProSort
			});
			$.each(provinceArr,function(index,element){
				var proName = element.name;
				$("#provinceList").append('<option>'+proName+'</option>');
			})
			function accessfromSelectShow(){
				document.getElementById("accessfrom").value=document.getElementById("accessfromList").value;
			};
			function provinceSelectShow(){
				document.getElementById("province").value=document.getElementById("provinceList").value;
			};
			jQuery.validator.addMethod("isPhone", function(value, element) {    
				var tel = /^(\d{3,4}-?)?\d{7,9}$/g;    
				return this.optional(element) || (tel.test(value));    
			}, "请正确填写您的电话号码");
			jQuery.validator.addMethod("isDate", function(value, element){
				var ereg = /^(\d{1,4})(-|\/)(\d{1,2})(-|\/)(\d{1,2})$/;
				var r = value.match(ereg);
				if (r == null) {
					return false;
				}
				var d = new Date(r[1], r[3] - 1, r[5]);
				var result = (d.getFullYear() == r[1] && (d.getMonth() + 1) == r[3] && d.getDate() == r[5]);
				return this.optional(element) || (result);
			}, "请输入正确的日期");
			function numberCheck(str,tip) {				
				var reg = /^[1-9]\d*$|^0$/; // 注意：故意限制了 0321 这种格式，如不需要，直接reg=/^\d+$/;
				if (reg.test(str) == true) {
					//alert("都是数字！通过");
					return true;
				} else {
					alert(tip+": 请输入数字（整数）");
					return false;
				}
			};
			$(document).ready(function(e) {
				var BASEURL = "http://pcrc.library.sh.cn/zt/opendata/2017/enter/";
				var token = new Date().getTime();				
				//$("#token").val(token+"#"+Math.floor(Math.random()*999+100));	
				$("#token").val(token);	
				$("#memberlistBtn").on("click",function(){
					var teammembernums = $("#teammembernums").val();
					if(!numberCheck(teammembernums,"团队人数"))
						return false
					if(!isNaN(teammembernums) && teammembernums>0 && teammembernums<=999 ){		
						var nownums = $(".memberlist-wrap").length;
						var i = 1;
						if(teammembernums>nownums){
							i = nownums + 1
							for (i ; i <= teammembernums ; i++){
								var html  = 	
									'<div class="memberlist-wrap">'+
									'<div class="form-group">'+
									  '<label class="control-label">*成员'+i+'·姓名</label>'+
									  '<div>'+
										'<input type="text" class="form-control memberlist-name" name="memberlist-name-'+i+'" placeholder="成员'+i+'·姓名" required="required">'+						
									  '</div>'+
									'</div>'+
									'<div class="form-group">'+
									  '<label for="" class="control-label">*成员'+i+'·年龄</label>'+
									  '<div>'+
										'<input type="number" name="memberlist-age-'+i+'" class="form-control memberlist-age" min="1" max="100" required="required">'+
									  '</div>'+
									'</div>'+
									'<div class="form-group">'+
									  '<label class="control-label">*成员'+i+'·补充信息</label>'+
									  '<br />'+
									  '<div class="col-sm-5">'+
										'<label class="radio-inline">'+
										  '<input type="radio" class="memberlist-type memberlist-type-'+i+'" name="memberlist-type-'+i+'" value="在校生">'+
										  '在校生'+
										'</label>'+
										'<div class="form-group">'+
											'<div class="input-group">'+
												'<div class="input-group-addon">学校</div>'+
												'<input type="text" class="form-control memberlist-tips memberlist-tips-0-'+i+'" name="memberlist-tips-0-'+i+'-1" placeholder="学校">'+						
											'</div>'+
											'<div class="input-group">'+
												'<div class="input-group-addon">在读学位</div>'+
												'<input type="text" class="form-control memberlist-tips memberlist-tips-0-'+i+'" name="memberlist-tips-0-'+i+'-2" placeholder="在读学位">'+
											'</div>'+
											'<div class="input-group">'+
												'<div class="input-group-addon">在读专业</div>'+
												'<input type="text" class="form-control memberlist-tips memberlist-tips-0-'+i+'" name="memberlist-tips-0-'+i+'-3" placeholder="在读专业">'+							
											'</div>'+
										'</div>'+		
									  '</div>'+
									  '<div class="col-sm-5 col-sm-offset-1">'+
										'<label class="radio-inline">'+
										  '<input type="radio" class="memberlist-type memberlist-type-'+i+'" name="memberlist-type-'+i+'" value="非在校生">'+
										  '非在校生'+
										'</label>'+
										'<p><small>请填写工作单位，如无具体单位请在"单位"一栏填写"自由职业者"</small></p>'+
										'<div class="form-group">'+
											'<div class="input-group">'+
												'<div class="input-group-addon">单位</div>'+
												'<input type="text" class="form-control memberlist-tips memberlist-tips-1-'+i+'" name="memberlist-tips-1-'+i+'-1" placeholder="单位">'+													
											'</div>'+
											
											'<div class="input-group">'+
												'<div class="input-group-addon">职业</div>'+
												'<input type="text" class="form-control memberlist-tips memberlist-tips-1-'+i+'" name="memberlist-tips-1-'+i+'-2" placeholder="职业">'+							
											'</div>'+
										'</div>'+
									  '</div>'+
									'</div>'+				
								'<hr /></div>';

								$(".memberlist").append(html);					


							}
						}else if(teammembernums<nownums){
							var r=confirm("将删除最后 "+(nownums-teammembernums)+" 位成员填写信息！");
							if (r==true){
								var j = teammembernums*1 + 1;
								for (j; j<=nownums ;j++){
									console.log("正在删除第"+j+"条数据");
									$(".memberlist-wrap").eq(teammembernums).remove();
								}								
							}
							
						}
						
						
							
						//$(".memberlist").empty();						
					}						
					else
					{
						alert("请正确输入团队成员人数")
					}

					
					
				})
				$("#teammembernums").focusout(function(){
					$("#memberlistBtn").click();
				});
				$("#nation").focusout(function(){
					var nation = $.trim($("#nation").val());					
					if(nation=="中国" || nation=="中华人民共和国" || nation=="China" || nation=="china" || nation=="PRC" || nation=="the People's Republic of China"){						
						$("#province").css("display","none");
						$("#provinceList").show();	
						$("#provinceList").rules("add",{required:true,messages:{required:"请选择省份"}});
					}else{
						$("#provinceList").hide();	
						$("#province").css("display","block").val("");		
						$("#provinceList").rules("remove");
					}
				})
				var validator = $("#hqxuForm").validate({
					debug: true,
					rules: {
							teamname: {
								required: true,
								minlength: 2
							},
							nation: {
								required: true,
								minlength: 2
							},
							province: {
								required: true,
								minlength: 2
							},
							ATTENname: {
								required: true,
								minlength: 2
							},
							ATTENcompany: {
								required: true,
								minlength: 2
							},
							ATTENmobile: {
								required: true,
								minlength: 11,
								maxlength:11,
								isPhone:true
							},
							ATTENmail: {
								required: true,
								email:true
							},
							teammembernums: {
								required: true,
								min: 1,
								max: 999
							},
							entryreason: {
								required: true,
								minlength: 10
							},
							accessfrom: {
								required: true,
								minlength: 2
							},
							workname: {
								required: true,
								minlength: 2
							},
							workstyle: {
								required: true								
							},
							workenvironment: {
								required: true,
								minlength: 2
							},
							workidea: {
								required: true,
								minlength: 2
							},
							workhadkey: {
								required: true								
							},
							training: {
								required: true								
							},
							accessfromList: {
								required: true
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
							document.getElementById("accessfrom").value=document.getElementById("accessfromList").value;	
							var nation = $.trim($("#nation").val());					
							if(nation=="中国" || nation=="中华人民共和国" || nation=="China" || nation=="china" || nation=="PRC" || nation=="the People's Republic of China"){						
								document.getElementById("province").value=document.getElementById("provinceList").value;
							}else{
								//
							}							
							var data = $(form).serializeArray();	
							var teammembernums = 0;
							if($(":input[name=agreement]:checked").length == 0){
								alert("请阅读竞赛规则并同意");
								return false
							}
							//console.log(data);
							$(data).each(function(index,element){
								if(element.name == "teammembernums")
									teammembernums = element.value
							});
							var teammemberlist = [];
							
							for(var i =1;i<=teammembernums;i++){
								var tips = "";
								if($(":input[name='memberlist-type-"+i+"']:checked").val()=="在校生"){
									tips = $(":input[name=memberlist-tips-0-"+i+"-1]").val()+"#"+
											$(":input[name=memberlist-tips-0-"+i+"-2]").val()+"#"+
											$(":input[name=memberlist-tips-0-"+i+"-3]").val();									
								}else{
									tips = $(":input[name=memberlist-tips-1-"+i+"-1]").val()+"#"+
											$(":input[name=memberlist-tips-1-"+i+"-2]").val()											
								}
								var flag = false;
								$(tips.split("#")).each(function(index,element){
									if (element.length==0){
										flag = true;
										alert("成员信息未填写完整");										 
										return false
									}											
								});
								if(flag==true)
									return false
								if(!numberCheck($(":input[name=memberlist-age-"+i+"]").val(),"成员年龄"))
									return false
								if($(":input[name=memberlist-age-"+i+"]").val()*1 < 1 ){
									alert("成员年龄不得小于1岁");	
									return false
								}
								if($(":input[name=memberlist-age-"+i+"]").val()*1 > 100 ){
									alert("成员年龄不得大于100岁");	
									return false
								}
								teammemberlist.push({
									name: $(":input[name=memberlist-name-"+i+"]").val(),
									age: $(":input[name=memberlist-age-"+i+"]").val(),
									type: $(":input[name='memberlist-type-"+i+"']:checked").val(),
									tips: tips
								});
								//teammemberlist[i-1].name = $(":input[name=memberlist-name-"+i+"]").val();
							};
							if(teammembernums != $(".memberlist-wrap").length ){
								alert("请点击成员人数右侧确认按钮，并填写全部成员信息");	
								return false
							}
							var teammemberlistStr = "";
							var myList = new Array(); 
							$(teammemberlist).each(function(index,element){	
								myList.push(JSON.stringify(element));								
							})
							teammemberlistStr = "["+myList.join(",")+"]";
							
							var newData = jQuery.grep(data, function(element) {
								return element.name.indexOf("memberlist") == -1 && element.name.indexOf("training") == -1 && element.name.indexOf("workstyle") == -1 && element.name != "entryreason" && element.name !="workidea" ;
							}); 
							newData.push({"name":"teammemberlist","value":teammemberlistStr});
							var training = $(":input[name=training]:checked").val();
							if(training=="参加全天"){
								training = training + "#" + $("#training_A1_text").val();
								if(!numberCheck($("#training_A1_text").val(),"参加培训人数"))
									return false
								if($("#training_A1_text").val()*1 > teammembernums ){
									alert("参加培训人数不得大于团队人数");	
									return false
								}
							}else if(training=="仅参加上午场"){
								training = training + "#" + $("#training_A2_text").val();
								if(!numberCheck($("#training_A2_text").val(),"参加培训人数"))
									return false
								if($("#training_A2_text").val()*1 > teammembernums ){
									alert("参加培训人数不得大于团队人数");	
									return false
								}
							}
							newData.push({"name":"training","value":training});	
							var workstyle = "";
							$(":input[name=workstyle]:checked").each(function(){
								workstyle += $(this).val() + "#" ;
							});
							newData.push({"name":"workstyle","value":workstyle});							
							var entryreason = $("#entryreason").val().replace(/\n/g,"<br/>");
							var workidea = $("#workidea").val().replace(/\n/g,"<br/>");
							newData.push({"name":"entryreason","value":entryreason});
							newData.push({"name":"workidea","value":workidea});
							
							
							$(newData).each(function(index,element){
								//console.log(element.name,element.value);							
								
								if(element.name == "teamname"){
									var teamname = element.value;
									$("#List #tabel-teamname").html(teamname);									
								}
								if(element.name == "nation"){
									var nation = element.value;
									$("#List #tabel-nation").html(nation);
								}
								if(element.name == "province"){
									var province = element.value;
									$("#List #tabel-province").html(province);
								}
								if(element.name == "ATTENname"){
									var ATTENname = element.value;
									$("#List #tabel-ATTENname").html(ATTENname);
								}
								if(element.name == "ATTENcompany"){
									var ATTENcompany = element.value;
									$("#List #tabel-ATTENcompany").html(ATTENcompany);
								}
								if(element.name == "ATTENmobile"){
									var ATTENmobile = element.value;
									$("#List #tabel-ATTENmobile").html(ATTENmobile);
								}
								if(element.name == "ATTENmail"){
									var ATTENmail = element.value;
									$("#List #tabel-ATTENmail").html(ATTENmail);
								}
								if(element.name == "teammembernums"){
									var teammembernums = element.value;
									$("#List #tabel-teammembernums").html(teammembernums);
								}
								if(element.name == "teammemberlist"){
									var teammemberlist = eval(element.value.replace(/&quot;/g,"\""));
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
									$("#List #tabel-teammemberlist").html(teamStr);
								}
								
								if(element.name == "entryreason"){
									var entryreason = element.value;
									$("#List #tabel-entryreason").html(entryreason);
								}
								if(element.name == "accessfrom"){
									var accessfrom = element.value;
									$("#List #tabel-accessfrom").html(accessfrom);
								}
								if(element.name == "workname"){
									var workname = element.value;
									$("#List #tabel-workname").html(workname);
								}
								if(element.name == "workstyle"){
									var workstyle = element.value;
									$("#List #tabel-workstyle").html(workstyle);
								}
								if(element.name == "workenvironment"){
									var workenvironment = element.value;
									$("#List #tabel-workenvironment").html(workenvironment);
								}
								if(element.name == "workidea"){
									var workidea =  element.value;
									$("#List #tabel-workidea").html(workidea);
								}
								if(element.name == "workhadkey"){
									var workhadkey = element.value;									
									$("#List #tabel-workhadkey").html((workhadkey==0?'无':'有'));
								}
								if(element.name == "training"){
									var training = element.value;
									if(training.split("#").length>1)
								   		training = training.split("#")[0]+"&nbsp;,"+training.split("#")[1]+"&nbsp;人";
									else
										training = "不参加";
									$("#List #tabel-training").html(training);
								}		
							});
							//console.log(html);
							//$("#List").html(html);	
							
							$('#myModal').modal('show');
							$("#postBtn").unbind().on("click",function(){
								$("#Submit").attr("disabled",true);
								$(":input").attr("disabled",true);
								
								$.ajax({
									type: "POST",
									url: "dataprocess.aspx",
									data: newData,
									timeout: 10000,
									dataType: 'json',
									error: function(XMLHttpRequest, textStatus, errorThrown) {
										alert("页面出错，请重新提交表单；若多次提交失败，请刷新页面或者稍后再试！");
										$("#Submit").removeAttr("disabled");
										$(":input").removeAttr("disabled");
									},
									success: function(json) {
										if (json.flag === "true") {
												alert("报名表提交成功！回执单已发送至领队的邮箱，请注意查收！");
												var token = json.token;
												var url = BASEURL+'receipt.aspx?token='+token;
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
							



					}
				});
				
		});
        </script>
    </body>

</html>
