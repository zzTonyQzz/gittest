function initPagePersons()
{
	var jpage = $(this);
	var curOpt_ = {};

	jpage.on("pagebeforeshow", onPageBeforeShow);
	jpage.find("#dlgMenu .mnuQ").click(mnuQ_click);

	var lstIf = MUI.initPageList(jpage, {
		pageItf: PagePersons,
		navRef: ".mui-navbar",
		listRef: ".p-list",
		onAddItem: onAddItem,
		onNoItem: onNoItem_default,
		onGetQueryParam: function (jlst, queryParam) {
			if (curOpt_.birthDt) {
				queryParam.birthDt = curOpt_.birthDt;
			}
			if (curOpt_.dt) {
				queryParam.dt = curOpt_.dt;
			}
			if (curOpt_.q) {
				queryParam.q = curOpt_.q;
			}
		}
	});

	function onAddItem(jlst, itemData)
	{
		var ji = MjItem.clone(itemData)
			.appendTo(jlst);
	}

	function onPageBeforeShow(ev)
	{
		var opt = PagePersons.opt_ || {};
		if (opt.to) {
			if (opt.to == "person") {
				jpage.find("[mui-linkto=#lst1]").click();
			}
			else {
				//jpage.find("#lst2").click();
				jpage.find("[mui-linkto=#lst2]").click();
			}
			delete opt.to;
		}

		if (JSON.stringify(curOpt_) == JSON.stringify(opt))
			return;
		curOpt_ = opt;
		PagePersons.refresh = true;
	}

	function mnuQ_click(ev)
	{
		var jo = $(this);
		if (jo.hasClass("byKey")) {
			var opt = {
				defValue: curOpt_.q
			};
			MUI.app_alert("输入查询关键字: ", "p", function (text) {
				curOpt_ = {q: text};
				lstIf.markRefresh();
				lstIf.refresh();
			}, opt);
		}
		else if (jo.hasClass("byDt")) {
			var opt = {
				defValue: curOpt_.dt || new Date().format("D")
			};
			MUI.app_alert("输入新的日期: ", "p", function (text) {
				curOpt_ = {dt: text};
				lstIf.markRefresh();
				lstIf.refresh();
			}, opt);
		}
		else if (jo.hasClass("byBirthDt")) {
			var opt = {
				defValue: curOpt_.birthDt || g_data.userInfo.birthDt || "1988-9-9"
			};
			MUI.app_alert("输入新的生日: ", "p", function (text) {
				curOpt_ = {birthDt: text};
				lstIf.markRefresh();
				lstIf.refresh();
			}, opt);
		}
	}
}
