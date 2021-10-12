$ns("${module_name}$${tableInfo.classname }.views");
$import("mx.containers.HSplit");
$import("mx.datacontainers.GridEntityContainer");
$import("mx.containers.Container");
$import("mx.datacontrols.DataGrid");
$import("mx.editors.LinkEditor");
$import("${module_name}$${tableInfo.classname }.views.AddView");
$import("${module_name}$${tableInfo.classname }.views.EditView");
${module_name}$${tableInfo.classname }.views.MainView = function () {

    var me = $extend(mx.views.View);
    var base = {};
    base.init = me.init;
    me.filter = {};
    me.init = function () {
        base.init();
        initControls();
    };

    // 控制面板
    function initControls() {
        initHSplit();
        initSearchEdit();
        initDataGrid();
        me.on("activate", me.controller._onactivate);

    }

    // 布局
    function initHSplit() {
        var layoutbox = mx.containers.Container({});
        me.addControl(layoutbox);

        me.mainHSplit = new mx.containers.HSplit({
            type: 0,
            id: "mainHSplit",
            rows: "82px,auto"
        });
        layoutbox.addControl(me.mainHSplit);

        me.toolHSplit = new mx.containers.HSplit({
            type: 0,
            rows: "40px,40px"
        });
        me.mainHSplit.addControl(me.toolHSplit, 0);

    }

    // 工具栏
    function initSearchEdit() {
        me.seachEdit = {};
        // 查询字段
        <#list tableInfo.columns as column>
			<#if column.attrname != tableInfo.primaryKey.attrname>
        		<#if column.attrType == 'Date'>
		me.seachEdit.${column.attrname}Start = new mx.editors.DateTimeEditor({
            alias: "${column.attrname}Start",
            width: "125px",
            lineBreak: false,
            formatString: "yyyy-MM-dd"
		});

        me.seachEdit.${column.attrname}End = new mx.editors.DateTimeEditor({
            alias: "${column.attrname}End",
            width: "125px",
            lineBreak: false,
            formatString: "yyyy-MM-dd"
        });

        var label = new mx.controls.Label({
            text: "——————",
            textAlign: "center",
            verticalAlign: "middle",
        });

        me.toolHSplit.addControl(getSLabel("${column.columnComment}", 85), 0);
        me.toolHSplit.addControl(me.seachEdit.${column.attrname}Start, 0);
        me.toolHSplit.addControl(label, 0);
        me.toolHSplit.addControl(me.seachEdit.${column.attrname}End, 0);
        		<#else>
		me.seachEdit.${column.attrname} = new mx.editors.TextEditor({
			alias: "${column.attrname}",
			width: "125px",
			lineBreak: false,
			onchanged: replaceSpecialStr
		});
		me.toolHSplit.addControl(getSLabel("${column.columnComment}", 85), 0);
		me.toolHSplit.addControl(me.seachEdit.${column.attrname}, 0);
        		</#if>	
        	</#if>
		</#list>

        // 查询按钮
        me.Sbutton = new mx.controls.Button({
            cssClass: "leftBtn",
            text: "查询",
            onclick: function () {
                me.filter = getFilter(me.seachEdit);
                me._dataGrid.setFilter(me.filter);
                me._dataGrid.load();
            }
        });
        me.toolHSplit.addControl(me.Sbutton, 0);

        // 重置按钮
        me.Rbutton = new mx.controls.Button({
            cssClass: "leftBtn",
            text: "重置",
            onclick: function () {
                me.filter = resetFilter(me.seachEdit);
                me._dataGrid.setFilter(me.filter);
                me._dataGrid.load();
            }
        });
        me.toolHSplit.addControl(me.Rbutton, 0);

        // 删除按钮
        me.delBtn = new mx.controls.Button({
            cssClass: "leftBtn",
            text: "删除",
            onclick: function () {
                if (me._dataGrid.getCheckedIDs().length === 0) {
                    mx.indicate("info", "请勾选一条待删除记录。");
                    return;
                }
                showMessage("提示信息", true, true, "删除", "你确定要删除数据吗? 删除后将不能恢复！", "info",
                    function () {
                        var data = {
                            ids: me._dataGrid.getCheckedIDs()
                        };
                        me.$e.setBusy(true);
                        var client = new mx.rpc.RESTClient();
                        var baseUrl = ${module_name}$${tableInfo.classname }.mappath("~/rest/${tableInfo.classname}/delete");
                        client.post(baseUrl, JSON.stringify(data), function (e) {
                        if (e.successful === true) {
                            mx.indicate("info", "删除成功！");
                            me._dataGrid.load();
                        } else {
                            mx.indicate("info", e.resultHint);
                        }
                        me.$e.setBusy(false);
                    });
                }, null);
            }
        });
        me.toolHSplit.addControl(me.delBtn, 1);

        // 添加按钮
        me.addBtn = new mx.controls.Button({
            cssClass: "leftBtn",
            text: "新增",
            onclick: function () {
                var view = new ${module_name}$${tableInfo.classname }.views.AddView({
                    mainView: me
                });
                showWin(view, "新增", 900, 400);
            }
        });
        me.toolHSplit.addControl(me.addBtn, 1);
    }

    // 初始化表格
    function initDataGrid() {
        var gridEntityContainer = new mx.datacontainers.GridEntityContainer({
            baseUrl: ${module_name}$${tableInfo.classname }.mappath("~/rest/${tableInfo.classname}/query"),
            iscID: "-1",
            primaryKey: "${tableInfo.primaryKey.attrname}",
            loadMeta: false
        });
        me._dataGrid = new mx.datacontrols.DataGrid({
            columns: [
                {
                    name: "cz", caption: "操作", width: "120px", dataAlign: "center",
                    renderCell: function (p_item, $p_cell) {
                        var id = p_item.getValue("id");
                        linkEditor = new mx.editors.LinkEditor(
                            {
                                type: "text",
                                cssClass: "optLink",
                                text: "编辑",
                                onclick: function () {
                                    var view = new ${module_name}$${tableInfo.classname }.views.EditView(
                                        {
                                            mainView: me,
                                            id: id
                                        });
                                    showWin(view, "编辑", 900, 400);
                                }
                            });
                        $p_cell.append(linkEditor.$e);
                    }
                },
                <#list tableInfo.columns as column>
                	{name: "${column.attrname}", caption: "${column.columnComment}", dataAlign: "center", width: "100px"},
				</#list>
            ],
            id: "DataGrid",
            displayRowNumber: true,
            rowNumberColWidth: 40,
            pageSize: 20,
            displayCheckBox: true,
            entityContainer: gridEntityContainer,
            onload: function (e) {

            }
        });
        me._dataGrid.load();
        me.mainHSplit.addControl(me._dataGrid, 1);
    }

    // 弹窗视图
    function showWin(view, title, width, height) {
        win = me.getContext().windowManager.createFromView(view, {
            width: width,
            height: height,
            reusable: true,
            displayMaxButton: false,
            title: title
        });
        win.showDialog();
    }

    return me.endOfClass(arguments);
};