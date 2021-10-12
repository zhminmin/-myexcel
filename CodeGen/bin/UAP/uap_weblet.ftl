$import("${module_name}$${tableInfo.classname }.views.MainViewController");
mx.weblets.WebletManager.register({
    id: "${module_name}$${tableInfo.classname }",
    name: "${tableInfo.tableComment}",
    onload: function(e)
    {
    },
    onstart: function(e)
    {
        var mvc = new ${module_name}$${tableInfo.classname}.views.MainViewController();
        e.context.rootViewPort.setViewController(mvc);
    }
});