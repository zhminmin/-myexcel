$ns("${module_name}$${tableInfo.classname }.views");
$import("mx.datacontainers.GridEntityContainer");
$import("mx.datacontrols.DataGridSearchBox");
$import("mx.datacontrols.ComplexGrid");
$import("mx.editors.DropDownEditor");
$import("mx.containers.VSplit");
$import("mx.containers.Panel");
$include("~/scpw_theme/workspace/resources/js/messagebox.js");
${module_name}$${tableInfo.classname }.views.EditView = function (obj) {
    var me = $extend(mx.views.View);
    var base = {};
    base.init = me.init;

    // 编辑弹窗传过来的主键ID
    var id = obj.id;
    me.init = function () {
        base.init();
        initControls();
    };

    function initControls() {
        initHSplit();
        initDataForm();
    }

    // 创建分区
    function initHSplit() {
        me.winhSplit = new mx.containers.HSplit({
            rows: "auto, 40px"
        });
        me.addControl(me.winhSplit);

        Qbutton = new mx.controls.Button({
            text: "确定"
        });
        Cbutton = new mx.controls.Button({
            text: "取消"
        });
        Qbutton.on("click", function () {
            //获取表单值
            var formData = getDataFormValue(me.dataForm);
            submitForm();
        });
        Cbutton.on("click", function () {
            win.hide();
        });
        Cbutton.$e.css("margin-left", "10px");
        me.winhSplit.addControl(Qbutton, 1);
        me.winhSplit.addControl(Cbutton, 1);
    }


    // 初始化表单数据
    function initDataForm() {
        var entityContainer = new mx.datacontainers.FormEntityContainer({
            type: "local"// 声明容器类型为本地数据。
        });
        //编辑回显
        var res = new mx.rpc.RESTClient().getSync(${module_name}$${tableInfo.classname }.mappath("~/rest/${tableInfo.classname}/" + id));
        if (res.successful) {
            entityContainer.data = res.resultValue;
        } else {
            showMessage("提示信息", true, false, "确定", data.resultHint, "warnning", null, null);
        }
        me.dataForm = new mx.datacontrols.DataForm({
            entityContainer: entityContainer,
            captionColumnWidth: 180,
            maxCols: 2,
            css: {
                "height": "100%"
            },
            fields: [
            <#list tableInfo.columns as column>
				<#if column.attrname != tableInfo.primaryKey.attrname>
		                {
		                    name: "${column.attrname}",
		                    caption: "${column.columnComment}",
		                    editorType: "TextEditor",
		                    nullable: false,
		                    maxLength: 50,
		                    onchanged: replaceSpecialStr
		                },
	             </#if>
			</#list>
            ],
            onload: function (e) {
            }
        });
        me.dataForm.load();
        me.winhSplit.addControl(me.dataForm, 0);
    }

    // 提交表单
    function submitForm() {
        // 验证表单数据
        if (!formValidate(me.dataForm)) {
            return false;
        }
        var postUrl = "~/rest/${tableInfo.classname}/update";
        var data = JSON.stringify(getFormData(me.dataForm));
        var restClient = new mx.rpc.RESTClient();
        me.$e.setBusy(true);
        restClient.post(${module_name}$${tableInfo.classname }.mappath(postUrl), data, function (e) {
            if (e.successful) {
                win.hide();
                me.mainView._dataGrid.load();
                showMessage("提示信息", true, false, "确定", e.resultValue, "info", null, null);
            } else {
                showMessage("提示信息", true, false, "确定", e.resultHint, "warnning", null, null);
            }
            me.$e.setBusy(false);
        });
    }

    me.endOfClass(arguments)
    return me;
};
