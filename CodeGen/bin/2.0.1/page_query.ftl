<div class="pull-left">
	<form id="queryForm" class="form-horizontal"  method="post">                                    
		<table class="search-table">
			<tr>
				<#assign moreStartIndex = 0>
				<#list tableInfo.columns as column>
					<#if column.attrname != tableInfo.primaryKey.attrname>
						<#assign moreStartIndex = column_index>
				<td><label class="control-label search-key">${column.columnComment }：</label></td>
   				<td>
	   					<#if column.attrType == 'Date'>
					<input id="${column.attrname}Begin" name="${column.attrname}Begin" type="text" class="'form-control search-val Wdate" />&nbsp;-&nbsp;
					<input id="${column.attrname}End" name="${column.attrname}End" type="text" class="'form-control search-val Wdate" />
						<#else>
					<input id="${column.attrname}" name="${column.attrname}" type="text" class="form-control search-val" />
						</#if>
 				</td>
 						<#break>
 					</#if>
				</#list>
 				<td>
 					<button type="submit" class="btn btn-success btn-custom waves-effect waves-light search-btn">查询</button>
 				</td>
				<td>
					<button type="button" class="btn btn-success btn-custom waves-effect waves-light more-search-btn">&#8595; 更多</button>
				</td>
			</tr>
		</table>
   		<div class="more-search fadeOutUp" style="display: none;">
      		<table class="search-table">
      			<#assign rowIndex = 0>
      			<#list tableInfo.columns as column>
					<#if column_index gt moreStartIndex && column.attrname != tableInfo.primaryKey.attrname>
						<#if rowIndex%2 == 0 >
				<tr>
						</#if>
						<#assign rowIndex = rowIndex+1>
					<td><label class="control-label search-key">${column.columnComment }：</label></td>
					<td<#if !column_has_next && rowIndex%2 == 1> colspan="3"</#if>>
	   					<#if column.attrType == 'Date'>
						<input id="${column.attrname}Begin" name="${column.attrname}Begin" type="text" class="'form-control search-val Wdate" />&nbsp;-&nbsp;
						<input id="${column.attrname}End" name="${column.attrname}End" type="text" class="'form-control search-val Wdate" />
						<#else>
						<input id="${column.attrname}" name="${column.attrname}" type="text" class="form-control search-val" />
						</#if>
 					</td>
						<#if  !column_has_next || rowIndex%2 == 0 >
				</tr>
						</#if>
 					</#if>
				</#list>
       		</table>
       		<div class="pull-right" style="margin-top:5px;">
	     		<button type="submit" class="btn btn-success btn-custom waves-effect waves-light search-btn" >查询</button>
	    		<button type="button" class="btn btn-success btn-custom waves-effect waves-light more-search-btn">&#8593; 收缩</button>			
	     	</div>
		</div>
	</form>
</div>