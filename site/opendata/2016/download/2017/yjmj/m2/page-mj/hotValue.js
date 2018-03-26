function initPageHotValue()
{
	var jpage = $(this);
	var result_ = null;

	var jform = jpage.find("#frmUserInfo");
	MUI.setFormData(jform, g_data.userInfo, {setOrigin:true});
	MUI.setFormSubmit(jform, form_submit, {validate: form_validate, onNoAction: form_submit});

	jpage.find("#btnMyResult").click(function () {
		$(this).hide();
		if (g_data.userInfo && g_data.userInfo.birthDt)
			jform.submit();
		else
			jform.show();
	});
	if (g_cordova)
		jpage.find("#dlgMenuShare li").click(mnuShare_click);

	if (g_args.hvId) {
		getHotValue(g_args.hvId);
		MUI.deleteUrlParam("hvId");
	}
	else {
		jpage.find("#btnMyResult").hide();
		if (g_data.userInfo && g_data.userInfo.birthDt) {
			getHotValue();
		}
		else {
			jform.show();
		}
	}

	function getHotValue(hvId)
	{
		var param = {};
		if (hvId && MUI.isWeixin())
			param.id = hvId;
		else if (g_data.userInfo.birthDt) 
			param.birthDt = g_data.userInfo.birthDt;

		MUI.useBatchCall();
		callSvr("HotValue.get", param, api_HotValueGet, null, {noex:1});
		callSvr("Mj.query", {pagesz:5}, api_MjQuery);
		if (param.birthDt) {
			callSvr("Mj.query", {pagesz:5, birthDt: param.birthDt}, api_MjQuery2, null, {birthDt: param.birthDt});
		}
		else {
			jpage.find("#lst3, #lst4").empty();
		}
	}

	function api_HotValueGet(data)
	{
		if (data === false) {
			jform.show();
			return;
		}
		jform.hide();

		data.isMyResult_ = MUI.parseDate(data.birthDt) - MUI.parseDate(g_data.userInfo.birthDt) == 0;
		var dvOpt = {
			formats: {
				dateD: function (val) {
					return MUI.parseDate(val).format("D");
				}
			}
		};
		data.val = $.parseJSON(data.val);
		jpage.find("#divHotValue")
			.dataview(data, dvOpt)
			.show();

		if (data.isMyResult_)
			result_ = data;
		if (MUI.isWeixin()) {
			setupShareViaWeixin(data.isMyResult_? data.id: null);
		}

		var jo = jpage.find("#divOp");
		jo.toggle(jo.children(":visible").size()>0);
	}

	function form_submit()
	{
		getHotValue();
	}
	
	function form_validate(jf, queryParam)
	{
		var birthDt = MUI.parseDate(jf[0].birthDt.value);
		if (birthDt == null)
			return false;
		if (birthDt.diff("y", new Date()) < 5) {
			MUI.app_alert("未满5岁哦，等你长大一些再测吧!");
			return false;
		}

		setTimeout(function () {
			jf.find(":input").prop("disabled", true);
			jf.find("button").hide();
		});
		if (! MUI.isWeixin()) {
			// 直接取结果并显示
			g_data.userInfo = {
				id: 1,
				birthDt: jf[0].birthDt.value,
				career: jf[0].career.value,
				city: jf[0].city.value
			};
			if (! g_data.userInfo.birthDt)
				debugger;
			MUI.setStorage("userInfo", JSON.stringify(g_data.userInfo));
			getHotValue();
			return false;
		}
		// 更新userInfo. 注意form上已绑定userInfo，如果立即更新会导致getFormData()返回没有变化数据。
		var updatedInfo = MUI.getFormData(jf);
		setTimeout(function () {
			$.extend(g_data.userInfo, updatedInfo);
		});
	}

	function setupShareViaWeixin(hotValueId)
	{
		var baseUrl = location.href.split(/[#?]/)[0];
		var link;
		if (hotValueId)
			link = baseUrl + "?hvId=" + hotValueId + "#hotValue";
		else
			link = baseUrl + "#hotValue";
		var imgUrl = baseUrl.replace(/\/m2\/.*$/, '/m2/logo_mj.jpg');
		var param = {
			title: result_
				? result_.title + ": " + "今天名气指数为" + result_.Hx + "！"
				: "测测今天的名气指数",
			desc: result_
				?  result_.dscr
				: "我在用“遇见名家”测名气指数，邀你一起来玩!",
			link: link,
			imgUrl: imgUrl,
			fn: function () {
				console.log("share done");
			}
		}
		shareViaWeixin(param);
	}

	function mnuShare_click(ev)
	{
		var weixin = navigator.weixin;
		if (weixin == null)
		{
			console.log("*** cannot use weixin");
			return;
		}
		if (result_ == null) {
			MUI.app_alert("先测试再分享吧");
			return;
		}

		var id = $(this).attr("id");
		var scene = id == "li1"?  weixin.Scene.SESSION: weixin.Scene.TIMELINE;

		var baseUrl = location.href.split(/[#?]/)[0];
		var imgUrl = baseUrl.replace(/\/m2\/.*$/, '/m2/logo_mj.jpg');
		var link = baseUrl + "?hvId="+result_.id + "#hotValue";

		weixin.share({
			message: {
				title: result_.title + ": " + "今天名气指数为" + result_.Hx + "！",
				description: result_.dscr,
				mediaTagName: "daca",
				thumb: imgUrl,
				media: {
					type: weixin.Type.WEBPAGE,   // webpage
					webpageUrl: link
				}
			},
			scene: scene,
		}, function () {
			//alert("Success");
		}, function (reason) {
			// 取消时reason为空
			if (reason)
				alert("Failed: " + reason);
		});
	}

	function api_MjQuery(data)
	{
		var jlst = jpage.find("#lst1");
		$.each(MUI.rs2Array(data.person), function (i, e) {
			onAddItem(jlst, e);
		});
		var ji = createCell({bd: "查看更多名家"})
			.addClass("viewMore")
			.appendTo(jlst)
			.on("click", function (ev) {
				PagePersons.show({to: "person"});
			});

		jlst = jpage.find("#lst2");
		$.each(MUI.rs2Array(data.work), function (i, e) {
			onAddItem(jlst, e);
		});
		ji = createCell({bd: "查看更多作品"})
			.addClass("viewMore")
			.appendTo(jlst)
			.on("click", function (ev) {
				PagePersons.show({to: "work"});
			});
	}

	function api_MjQuery2(data)
	{
		var birthDt = this.birthDt;

		var jlst = jpage.find("#lst3");
		$.each(MUI.rs2Array(data.person), function (i, e) {
			onAddItem(jlst, e);
		});
		var ji = createCell({bd: "查看更多名家"})
			.addClass("viewMore")
			.appendTo(jlst)
			.on("click", function (ev) {
				PagePersons.show({to: "person", birthDt: birthDt});
			});

		jlst = jpage.find("#lst4");
		$.each(MUI.rs2Array(data.work), function (i, e) {
			onAddItem(jlst, e);
		});
		ji = createCell({bd: "查看更多作品"})
			.addClass("viewMore")
			.appendTo(jlst)
			.on("click", function (ev) {
				PagePersons.show({to: "work", birthDt: birthDt});
			});
	}

	function onAddItem(jlst, itemData)
	{
		var ji = MjItem.clone(itemData)
			.appendTo(jlst);
	}
}
