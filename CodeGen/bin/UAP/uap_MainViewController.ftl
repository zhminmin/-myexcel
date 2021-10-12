$ns("${module_name}$${tableInfo.classname }.views");
$import("${module_name}$${tableInfo.classname }.views.MainView");
${module_name}$${tableInfo.classname }.views.MainViewController = function(){
	var me = $extend(mx.views.ViewController);
	var base = {};
	me.getView = function(){
		if (me.view == null){
			me.view = new ${module_name}$${tableInfo.classname }.views.MainView({ controller: me });
		}
		return me.view;
	};
	
	me._onactivate = function(e){
	
	};
	return me.endOfClass(arguments);
};