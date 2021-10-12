${r'<@compress single_line=true>'}
${r'<#if resModel?exists && resModel.resultList?has_content>'}
	${r'<#assign btnRecord>'}
		${r"<@bw.btnRecord code='"}${tableInfo.classname}${r"' />"}
	${r'</#assign>'}
	${r'<#assign col>'}
		${r'<#list resModel.resultList as result>'}
		{
		<#list tableInfo.columns as column>
			<#if column.attrname == tableInfo.primaryKey.attrname>
			"${column.attrname}": "${r'${result.'}${column.attrname}${r' }'}",
			"btn":"<p ids='${r'${result.'}${column.attrname}${r'}'}'>${r'${btnRecord'}${r' }'}</p>"<#if column_has_next>,</#if>
			<#else>
			<#if column.attrType == 'Date'>
			"${column.attrname}": "${r'${(result.'}${column.attrname}${r'?string("yyyy/MM/dd HH:mm:ss"))! }'}"<#if column_has_next>,</#if>
			<#elseif column.attrType == 'String' && column.attrname != "id" && !column.attrname?ends_with("Id")>
			"${column.attrname}": "${r'${bw.jsonStr(result.'}${column.attrname}${r') }'}"<#if column_has_next>,</#if>
			<#else>
			"${column.attrname}": "${r'${result.'}${column.attrname}${r'! }'}"<#if column_has_next>,</#if>
			</#if>
			</#if>
		</#list>
		}${r'<#if result_has_next>,</#if>'}
		${r'</#list>'}
	${r'</#assign>'}
	${r'<@bw.row total=resModel.pu.totalCount field=col/>'}
${r'<#else>'}
${r'<@bw.row total=0/>'}			
${r'</#if>'}
${r'</@compress>'}