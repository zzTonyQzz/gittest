function initPagePerson() 
{
	var jpage = $(this);
	var curKey_;
	jpage.on("pagebeforeshow", pageBeforeShow);

	function pageBeforeShow()
	{
		var key = PagePerson.key_;
		if (! key || key == curKey_)
			return;
		curKey_ = key;
		callSvr("Mj.getPerson", {key: key}, api_getPerson);
	}

	function api_getPerson(data)
	{
		jpage.find(".bd").prop("scrollTop", 0);
		var jcont = jpage;
		jcont.dataview(data, {
			events: {
				liWork_click: function (ev) {
					var workKey = ev.data.key;
					PageWork.show(workKey);
				}
			}
		});
	}
}
