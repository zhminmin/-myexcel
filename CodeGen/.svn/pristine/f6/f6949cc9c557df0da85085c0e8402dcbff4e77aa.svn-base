<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
${r"<@sp.themes/>"}
</head>
<body>
<div class="panel-body modal-area">
	<form id="${tableInfo.classname}Form" action="javascript:void(0);" method="post">
		<div class="form-bar form-fixed">
	     	<div class="pull-right">
	     		<button type="submit" class="btn btn-success btn-custom waves-effect waves-light">提交</button>
	     		<button type="button" class="btn btn-info btn-custom waves-effect waves-light"
	     		onclick="javascript:_dialog.closeBWin();">取消</button>
	     		</div>
	     	<div class="clear"></div>
      	</div>
      	<div class="form-fixed-clear"></div>
      	
		<input type="hidden" id="${tableInfo.primaryKey.attrname }" name="${tableInfo.primaryKey.attrname }" value="${r'${'}${tableInfo.classname}.${tableInfo.primaryKey.attrname }${r'!}'}"/>
		<div class="form-data">
			<table  class="table txtL form-table">
				<tbody>
				<#assign rowIndex = 0>
				<#assign colIndex = 0>
				<#list tableInfo.columns as column>
					<#if column.attrname != tableInfo.primaryKey.attrname>
						<#if colIndex%2 == 0 >
							<#if rowIndex%2 == 0>
					<tr class="trForContent1">
							<#else>
					<tr class="trForContent2">
							</#if>
							<#assign rowIndex = rowIndex+1>
						</#if>
						<#assign colIndex = colIndex+1>
						<td<#if rowIndex == 1> width="15%"</#if> class="txtR"><!--<span class="red">*</span>-->${column.columnComment}：</td>
						<td<#if !column_has_next && colIndex%2 == 1> colspan="3"<#elseif rowIndex == 1> width="35%"</#if>>
							<#if column.attrType == 'Date'>
							<input type="text" id="${column.attrname}" name="${column.attrname}" class="form-control search-val Wdate" 
								value="${r'${('}${tableInfo.classname}.${column.attrname}${r"?string('yyyy/MM/dd'))! }"}" style="width:85%;" />
							<#else>
							<input type="text" id="${column.attrname}" name="${column.attrname}" class="form-control search-val" 
								value="${r'${'}${tableInfo.classname}.${column.attrname}${r'! }'}" maxlength="${column.columnLength!'20'}" style="width:85%;" />
							</#if>
						</td>
						<#if !column_has_next || colIndex%2 == 0 >
					</tr>
						</#if>
					</#if>
				</#list>
			</table>
		</div>
	</form>
</div>

<script>

$(function(){
	$.formValidator.initConfig({formID:"${tableInfo.classname }Form",debug:false,submitOnce:false,forceValid:false,
		onError:function(msg,obj,errorlist){
			var subject = obj.settings[0].subject ? '【' + obj.settings[0].subject + '】'  : '';
      		$.bw.notify( subject + msg, 'error' );
		}, onSuccess:function(){
			var form = serializeObject( $("#${tableInfo.classname }Form") );
			com_ajaxPost( "${r'${rc.contextPath}'}/bg/${tableInfo.classname}.html?method=${r'${doMethod }'}", form, function( data ) {
				_dialog.closeReloadGrid();
			} );
		},
		submitAfterAjaxPrompt : '有数据正在异步验证，请稍等...'
	});
	$("#${tableInfo.classname }Form").submit(function(){return false;});
	
	<#list tableInfo.columns as column>
		<#if column.attrname != tableInfo.primaryKey.attrname>
			<#if column.attrType == 'Date'>
	$("input[name=${column.attrname }]").focus(function (){
		WdatePicker({skin:'whyGreen',dateFmt:'yyyy/MM/dd'});
	});
			<#else>
	$("#${column.attrname }").formValidator({onShow:" ",onFocus:" ",onCorrect:" ", empty: true, subject:"${column.columnComment }"})
		.inputValidator({min:0,max:${column.columnLength!'20'},empty:{leftEmpty:false,rightEmpty:false,emptyError:"前后不能有空格"},onError:"不能超过${column.columnLength!'20'}字符"})
				<#if column.attrType == 'Integer' || column.attrType == 'Long' >
		.regexValidator({regExp:"intege", param:"g", dataType:"enum", onError:"只能输入整数"})
				<#elseif column.attrType == 'Float' || column.attrType == 'Double' || column.attrType == 'BigDecimal' >
		.regexValidator({regExp:"num", param:"g", dataType:"enum", onError:"只能输入数字"})	
				</#if>
		;
			</#if>
		</#if>
	</#list>
	
	//校验模板 请开发参考后删除
	/*
	$("#standardNumber").formValidator({onShow:" ",onFocus:" ",onCorrect:" ", empty: true, subject:"字段名称"})
	//formValidatorRegex.js
	 .regexValidator({regExp:"impword",param:"g",dataType:"enum",onError:"密码必须包含大小写字母、数字以及特殊符号”~!@#$%^&*_“，不能出现连续数字且长度不小于8位！"})
	.compareValidator({desID:"passWord",operateor:"=",onError:"两次密码不一致,请确认"})
	.functionValidator({fun:function(val,dom){this.isValid = true;},onError:"输入错误"})
	.ajaxValidator({
	    type : "get",
		url : "{rc.contextPath }/bg/wzjhUnit.html?method=checkDept&id={wzjhUnit.id!}'}",
		datatype : "text",
		isValid : true,
		beforeSend: function(jqXHR, configs){
			configs.url += "&fdDeptId=" + $("#fdDeptId").val();
			return true;
		},
		success : function(data) {
			return data == "true";
		},
		buttons: $("#submitBtn"),
		error: function(){ $.bw.notify( "服务器没有返回数据，可能服务器忙，请重试", 'error' );},
		onError : "当前部门已被其他单位使用，请选择未被使用的部门",
		onWait : "正在校验部门是否可用，请稍候..."
	});
	*/
});

</script>
</body>
</html>