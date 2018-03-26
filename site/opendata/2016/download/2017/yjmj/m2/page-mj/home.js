function initPageHome()
{
	var jpage = $(this);

	if (! g_cordova)
		jpage.find("#btnShareTo").hide();
	else
		jpage.find("#dlgMenuShare li").click(mnuShare_click);

	callSvr("Mj.query", api_MjQuery);

	function api_MjQuery(data)
	{
		var jlst1 = jpage.find("#lst1");
		$.each(MUI.rs2Array(data.person), function (i, e) {
			onAddItem(jlst1, e);
		});
		var ji = createCell({bd: "查看更多名家"})
			.addClass("viewMore")
			.appendTo(jlst1)
			.on("click", function (ev) {
				PagePersons.show({to: "person"});
			});

		var jlst2 = jpage.find("#lst2");
		$.each(MUI.rs2Array(data.work), function (i, e) {
			onAddItem(jlst2, e);
		});
		ji = createCell({bd: "查看更多作品"})
			.addClass("viewMore")
			.appendTo(jlst2)
			.on("click", function (ev) {
				PagePersons.show({to: "work"});
			});
	}

	function onAddItem(jlst, itemData)
	{
		var ji = MjItem.clone(itemData)
			.appendTo(jlst);
	}

	function mnuShare_click(ev)
	{
		var weixin = navigator.weixin;
		if (weixin == null)
		{
			console.log("*** cannot use weixin");
			return;
		}

		var id = $(this).attr("id");
		var scene = id == "li1"?  weixin.Scene.SESSION: weixin.Scene.TIMELINE;

		weixin.share({
			message: {
				title: "对的时间，遇见名家", 
				description: "每日名家名作推荐，了解名家背后的故事。",
				mediaTagName: "daca",
				thumb: "http://dacatec.com/jiapu/m2/logo_mj.jpg",
				media: {
					type: weixin.Type.WEBPAGE,   // webpage
					webpageUrl: "http://a.app.qq.com/o/simple.jsp?pkgname=com.daca.mingjia"    // webpage
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
}
