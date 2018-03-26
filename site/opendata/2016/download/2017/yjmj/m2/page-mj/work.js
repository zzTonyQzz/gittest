function initPageWork() 
{
	var jpage = $(this);
	var curKey_;
	jpage.on("pagebeforeshow", pageBeforeShow);

	function pageBeforeShow()
	{
		var key = PageWork.key_;
		if (! key || key == curKey_)
			return;
		curKey_ = key;
		callSvr("Mj.getWork", {key: key}, api_getWork);
	}

	function api_getWork(data)
	{
		var jcont = jpage.find(".bd");
		jcont.prop("scrollTop", 0);
		jcont.dataview(data, {
			events: {
				liPerson_click: function (ev) {
					var personKey = ev.data.personKey;
					PagePerson.show(personKey);
				}
			}
		});
	}
}
