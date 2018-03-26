// ====== global and defines {{{
/*
如果服务端接口兼容业务查询协议(BQP)，可定义 MUI.options.serverUrl 指向服务端接口地址。
否则应定义MUI.callSvrExt适配接口。
*/
$.extend(MUI.options, {
	serverUrl: "../api.php"
	// serverUrlAc: "ac"
});

// 模拟接口返回数据
// MUI.loadScript("mockdata.js", {async: false, cache: false});
//}}}

// ====== app fw {{{
//}}}

// ====== app shared function {{{
var dfdStatLib_;
function loadStatLib()
{
	if (dfdStatLib_ == null) {
		dfdStatLib_ = $.when(
			MUI.loadScript("../web/lib/echarts.min.js"),
			MUI.loadScript("../web/lib/jdcloud-wui-stat.js")
		);
	}
	return dfdStatLib_;
}
function onNoItem_default(jlst)
{
	var ji = createCell({bd: "没有了"});
	ji.css("text-align", "center");
	ji.appendTo(jlst);
}

// "val1-1:val1-2,val2-1,val2-2" => [ ["val1-1","val1-2"], ["val2-1","val2-2"] ]
// "val1-1:val1-2,val2-1,val2-2" => [ {col1: "val1-1", col2: "val1-2"}, {col1: "val2-1", col2: "val2-2"} ]
// e.g. data.works = extractTable(data.works, "\n", "\t", ["key", "name"]);
function extractTable(str, sepRow, sepCol, cols)
{
	var ret = [];
	$.each(str.split(sepRow), function (i, row) {
		var arr = row.split(sepCol);
		if (cols == null) {
			ret.push(arr);
		}
		else {
			var obj = {};
			$.each(cols, function (j, col) {
				obj[col] = arr[j];
			});
			ret.push(obj);
		}
	});
	return ret;
}
//}}}

// vim: set foldmethod=marker:
