<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
${r"<@sp.themes/>" }
</head>
<body>
<div id="wrapper">
	<div class="tool-bar">
		${r'<#include "query.htm">' }
		<div class="pull-right lh30">
			${r"<@bw.btn code='"}${tableInfo.classname }${r"' />"}
		</div>
        <div class="clear"></div>
	</div>
	<div class="data-area">
		${r'<#--' } 跨行选中 idField="${tableInfo.primaryKey.attrname }"${r' -->' }
		<table id="listData" class="easyui-datagrid newgrid" style="height: 450px;">
			<thead frozen="true">
				<tr>
					<#list tableInfo.columns as column>
						<#if column.attrname == tableInfo.primaryKey.attrname>
					<th field="${column.attrname }" checkbox=true></th>
						<#break>
						</#if>
					</#list>
					<th field="btn" width="100" align="center">操作</th>
				</tr>
			</thead>
			<thead>
				<tr>
					<#list tableInfo.columns as column>
						<#if column.attrname != tableInfo.primaryKey.attrname>
					<th field="${column.attrname }" width="110" align="left">${column.columnComment}</th>
						</#if>
					</#list>
				</tr>
			</thead>
		</table>
	</div>
</div>
${r'<@bw.datagrid' } id="listData" title="${tableInfo.tableComment }列表" fieldId="${tableInfo.primaryKey.attrname }"
	url="${r'${rc.contextPath}'}/bg/${tableInfo.classname}.html?method=load" ${r'/>' }
	
<script>
var mainActionUrl = '${r"${rc.contextPath }"}/bg/${tableInfo.classname }.html';
var bWin;
var $listData = $("#listData");
autoResize("listData");
$(function(){
	$("#queryForm").submit(function(){
		var form=$("#queryForm");
		$listData.datagrid('load',serializeObject(form));
		hideMoreSearch();
		return false;
	});
	<#list tableInfo.columns as column>
	<#if column.attrType == 'Date'>
	$("input[name=${column.attrname}Begin]").focus(function (){ 
		WdatePicker({skin:'whyGreen',maxDate:$("input[name=${column.attrname}End]").val(),dateFmt:'yyyy/MM/dd'});
	});
	$("input[name=${column.attrname}End]").focus(function (){ 
		WdatePicker({skin:'whyGreen',minDate:$("input[name=${column.attrname}Begin]").val(),dateFmt:'yyyy/MM/dd'});
	});
	</#if>
	</#list>
});

function ${tableInfo.classname}_add( ) {
	bWin = $.bw.window( mainActionUrl + '?method=add', {title:'新增${tableInfo.tableComment }',iframe:true,closable:true,
		width:950,height:450,success:function(){}});
}

function ${tableInfo.classname}_edit( obj ) {
	var p = $( obj ).parent();
	var id = $( p ).attr("ids");
	bWin = $.bw.window(  mainActionUrl + '?method=edit&${tableInfo.primaryKey.attrname }=' + id, {title:'编辑${tableInfo.tableComment }',iframe:true,closable:true,
		width:950,height:450,success:function(){}});
}

function ${tableInfo.classname}_del( obj ) {
	var p = $( obj ).parent();
	var id = $( p ).attr("ids");
	$.bw.confirm('您确认要删除该记录吗？删除操作不可复原！', {confirm:function(){
		var data = {
			'${tableInfo.primaryKey.attrname }': id	
		};
		com_ajaxPost( mainActionUrl + '?method=delete', data, function( data ) {
			 $listData.datagrid('reload');
		} );
	}});
}

function ${tableInfo.classname}_batchDel() {
	if ( check() ) {
		$.bw.confirm('您确认删除选中的数据吗？删除操作不可复原！', {
			confirm: function() {
				var data = {
					'ids': getCheckedRowIds()
				};
				com_ajaxPost( mainActionUrl + '?method=batchDel', data, function( data ) {
					 $listData.datagrid('reload');
				} );
			}
		});
	}
}

function closeBWin() {
	bWin.bwModalHide();
	bWin = null;
}

function closeReloadGrid() {
	closeBWin();
	reloadGrid('listData');
}

function check() {
	var data = $listData.datagrid('getChecked');
	if ( data.length == 0 ) {
		$.bw.alert('请选择您要操作的记录',{title:'提示',t:"warning"});
		return false;
	}
	return true;
}

//获取选中ID数组
function getCheckedRowIds() {
	var datas = $listData.datagrid('getChecked');
	return $( datas ).map(function( index, item ){
		return item.${tableInfo.primaryKey.attrname };
	}).get();
}

function getRowById( ${tableInfo.primaryKey.attrname } ) {
	var rows = $.data($listData[0],'datagrid').data.rows;
	for ( var i = 0; i < rows.length; i++ ) {
		if ( rows[ i ].${tableInfo.primaryKey.attrname } == ${tableInfo.primaryKey.attrname } ) {
			return rows[ i ];
		}
	}
	return null;
}

</script>
</body>
</html>