// ====== config {{{
$.extend(MUI.options, {
	appName: "mj",
	homePage: "#home",
	pageFolder: "page-mj",
});

MUI.validateEntry([
	"#home",
	"#hotValue"
]);
// }}}

// ====== global {{{

var g_data = {
	userInfo : null, // {id, name, uname=phone}
};

var g_cfg = {
	WAIT: 3000, // 3s
};

// ---- interface {{{
var PagePersons = {
	// opt: {dt, birthday, q, to="person|work"}
	show: function (opt) {
		this.opt_ = opt;
		MUI.showPage("#persons");
	},
	opt_: null
};

var PagePerson = {
	show: function (key) {
		this.key_ = key;
		MUI.showPage("#person");
	},
	key_: null
};

var PageWork = {
	show: function (key) {
		this.key_ = key;
		MUI.showPage("#work");
	},
	key_: null
};
//}}}
//}}}

// ====== functions {{{
// <button id="btnGenCode">发送验证码<span class="p-prompt"></span></button>
function setupGenCodeButton(btnGenCode, txtPhone)
{
	btnGenCode.click(btnGenCode_click);
	function btnGenCode_click()
	{
		var phone = txtPhone.val();
		if (phone == "") {
			app_alert("填写手机号!")
			return;
		}
		callSvr("genCode", {phone: phone}, api_genCode);

		function api_genCode(data)
		{
			var $btn = btnGenCode;
			$btn.prop("disabled", true);
			$btn.addClass("disabled");
			var btnText = $btn.text();

			var n = 60;
			var tv = setInterval(function () {
				var s = "";
				-- n;
				if (n > 0) 
					s = n + "秒后可用";
				else {
					clearInterval(tv);
					$btn.prop("disabled", false);
					$btn.removeClass("disabled");
					s = btnText;
				}
				$btn.text(s);
			}, 1000);
		}
	}
}

// fn(code) 找不到验证码时code=null
function getDynCode(fn)
{
	MUI.enterWaiting();
	var url = MUI.getBaseUrl() + "tool/log.php?f=ext&sz=500";
	$.get(url).then(function (data) {
		MUI.leaveWaiting();
		var m = data.match(/验证码(\d+)/);
		var ret = m? m[1]: null;
		fn(ret);
	});
}

// o: {hd?, bd?, ft?}
// return: jcell
function createCell(o)
{
	var html = "<li class=\"weui_cell\">";
	if (o.hd != null) {
		html += "<div class=\"weui_cell_hd\">" + o.hd + "</div>";
	}
	if (o.bd != null) {
		html += "<div class=\"weui_cell_bd weui_cell_primary\">" + o.bd + "</div>";
	}
	if (o.ft != null) {
		html += "<div class=\"weui_cell_ft\">" + o.ft + "</div>";
	}
	html += "</li>";
	return $(html);
}

function checkEmptyList(jlst, dscr)
{
	if (jlst[0].children.length == 0) {
		if (dscr == null)
			dscr = "空列表!";
		var ji = createCell({bd: dscr});
		ji.css("text-align", "center");
		jlst.append(ji);
	}
}

function showDlg(ref)
{
	var jdlg = MUI.activePage.find(ref);
	MUI.showDialog(jdlg);
}

function closeDlg(o)
{
	MUI.closeDialog($(o).closest(".mui-dialog"));
}

/**
@fn shareViaWeixin(param)

@param param = {title, title2?, desc, link, imgUrl, fn?}

title: 分享给朋友title
title2：分享到朋友圈title, 如果未指定则使用title
desc：分享非朋友的描述文字
link：分享连接
imgUrl：分享图片url
fn: 成功后回调函数
*/
function shareViaWeixin(param)
{
	if (!MUI.isWeixin())
		return;

	var self = shareViaWeixin;
	if ( !self.dfd ) {
		self.dfd = $.Deferred();
		var localHtml=location.href.split('#')[0];
		var initParam;
		var dfd = callSvr("initWeixinJsapi", {url: localHtml}, api_initWeixinJsapi, {noLoadingImg:1});
		-- $.active;

		function api_initWeixinJsapi(data) 
		{
			initParam = data;

			wx.config({
				debug: false,
				appId : initParam.appId,
				timestamp : initParam.timeStamp,
				nonceStr : initParam.nonceStr,
				signature: initParam.signature,
				jsApiList: [
					'onMenuShareTimeline',
					'onMenuShareAppMessage',
					'onMenuShareQQ',
				],
			});
			self.dfd.resolve();

			wx.error(function(res){
				alert('initWeixinJsapi error: ' + res.errMsg);
				alert('url: ' + localHtml);
			});
		}
	}

	self.dfd.then(function () {

	wx.ready(function() {	//朋友圈
		var fn = param.fn || $.noop;
		var baseUrl = location.href.split('#')[0];
		if (param.link && param.link[0] == '#') {
			param.link = baseUrl + param.link;
		}
		if (param.imgUrl == null) {
			var imgUrl = baseUrl.replace(/\/m2\/.*$/, '/m2/image/logo300.png');
			param.imgUrl = imgUrl;
		}

		wx.onMenuShareTimeline({
			title: param.title,			// 分享标题
			link: param.link, 			// 分享链接
			imgUrl: param.imgUrl, // 分享图标
			success: fn,
			cancel: function () {
			},
		});
		wx.onMenuShareAppMessage({	//分享给朋友
			title: param.title2 || param.title,
			desc: param.desc,
			link: param.link,
			imgUrl: param.imgUrl,
			type: 'link',
			dataUrl: '',
			success: fn,
			cancel: function () {
			},
		});
		wx.onMenuShareQQ({
			title: param.title, // 分享标题
			desc: param.desc, 		// 分享描述
			link: param.link, 		// 分享链接
			imgUrl: param.imgUrl, 					// 分享图标
			success: fn,
			cancel: function () {
			}
		});
	});

	});
}

(function() {

var jtpl_;
var tplCode_;
var dvOpt_ = {
	events: {
		person_click: function (ev) {
			var item = ev.data;
			PagePerson.show(item.key);
		},
		work_click: function (ev) {
			var item = ev.data;
			PageWork.show(item.workKey);
		},
		dscr_click: dscr_click,
		search_click: search_click
	}
};

function queryKey(q)
{
	var url = "http://zhihu.sogou.com/zhihuwap?query=" + q;
	if (window.cordova && cordova.InAppBrowser) {
		if (tplCode_ == null) {
			tplCode_ = $("#tplMjHack").html();
		}
		MUI.showLoading();
		var wb = cordova.InAppBrowser.open(url, "_black", "location=no,hidden=yes");
		$(wb).on('loadstart', function (ev) {
			//MUI.showLoading();
			//wb.hide();
		});
		$(wb).on("loadstop", function (ev) {
			if (wb == null)
				return;
			// 定制搜索页面，隐藏头尾
			wb.executeScript({code: tplCode_});

			MUI.hideLoading();
			wb.show();
		});
		$(wb).on('loaderror', function (ev) {
			MUI.hideLoading();
			var ms = ev.originalEvent.url.match(/^mingjia:\/\/(\w+)/);
			if (ms == null)
				MUI.app_alert("加载失败！请重试！", "e");
			// if (ms[1] == "back");
			wb.close();
			wb = null;
			return false;
		});
	}
	else {
		location.href = url;
		MUI.app_abort();
	}
}

function dscr_click(ev)
{
	var item = ev.data;
	if (item.workKey) {
		PageWork.show(item.workKey);
	}
	else {
		PagePerson.show(item.key);
	}
}

function search_click(ev)
{
	if (! g_cordova) {
		MUI.app_alert("搜索功能请下载APP后使用!");
		return;
	}
	var item = ev.data;
	var q = item.workName || item.name;
	queryKey(q);
}

function getTpl()
{
	if (jtpl_ == null) {
		var jo = $("#tplMjItem");
		jtpl_ = $(jo.html());
	}
	return jtpl_;
}

window.MjItem = {
/*
@fn MjItem.clone(itemData)
 */
	clone: function (itemData) {
		var y = parseInt(itemData.dt);
		itemData.focusCnt_ = (y >= 1895 && y <= 1925 || (y>=1975 && y<=1995) )? 1+y%3: 0;
		var ji = getTpl().clone()
			.dataview(itemData, dvOpt_);

		if (itemData.gender == '女')
			ji.find(".icon-person").addClass("female");
		return ji;
	},
	queryKey: queryKey
};
})();

//}}}

// ====== main {{{

function handleLogin(data)
{
	if (data.err && data.err == "no_openid") {
		if (g_args.wxauth) {
			debugger; // 避免后端出错导致 反复微信认证
			MUI.app_abort();
		}
		// 发起微信认证
		var authUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?" + $.param({
			appid: data.appId,
			redirect_uri: data.redirectUri,
			response_type: "code",
			scope: "snsapi_userinfo", // "snsapi_base" 或 "snsapi_userinfo" ，如果需要更多信息
			state: MUI.appendParam(location.href, "wxauth=1") // state为微信认证后，前端将前往的页面。
		}) + "#wechat_redirect";
		location.href = authUrl;
		MUI.app_abort();
	}
	MUI.deleteUrlParam("wxauth");
	MUI.handleLogin(data);
}

$(document).on("muiInit", myInit);
$(document).on("pagebeforeshow", pageBeforeShow);

// called after page is load. called in html page.
function myInit()
{
	//MUI.initClient();
	// redirect to login if auto login fails
	if (MUI.isWeixin()) {
		MUI.tryAutoLogin(handleLogin, "WxUser.get", true);
	}
	else {
		g_data.userInfo = $.parseJSON(MUI.getStorage("userInfo")) || {
			id: 1
		};
	}
}

function pageBeforeShow(ev)
{
	if (MUI.isWeixin()) {
		var jpage = $(ev.target);
		jpage.find(".hd").hide();
	}
}

function logoutUser()
{
	MUI.logout();
}
// }}}

// vim: set foldmethod=marker:
