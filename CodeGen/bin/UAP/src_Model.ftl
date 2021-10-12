package ${modelpackage_name};

import java.math.BigDecimal;
import java.util.Date;

import com.bw.core.model.BaseModel;
import com.bw.core.model.IBaseModel;

/**
 * ${tableInfo.tableComment}
 * @author ${author! }
 * ${date! }
 */
public class ${tableInfo.className} extends BaseModel implements IBaseModel
{
	<#list tableInfo.columns as column>
	/** ${column.columnComment} */
 	private ${column.attrType} ${column.attrname};
    	<#if column.attrType == 'Date'>
	/** ${column.columnComment} 开始时间 */
 	private String ${column.attrname}Begin;
    /** ${column.columnComment} 结束时间 */
 	private String ${column.attrname}End;
		</#if>
	</#list>
	
	<#list tableInfo.columns as column>
	/**
     * ${column.columnComment}
     * @param ${column.attrname}
     */
    public void set${column.attrName}(${column.attrType} ${column.attrname})
    {
        this.${column.attrname} = ${column.attrname};
    }
    
    /**
     * ${column.columnComment}
     * @return
     */
	public ${column.attrType} get${column.attrName}()
    {
        return ${column.attrname};
    }
    
    
    <#if column.attrType == 'Date'>
    /**
     * ${column.columnComment} 开始时间
     * @param ${column.attrname}Begin
     */
    public void set${column.attrName}Begin(String ${column.attrname}Begin)
    {
        this.${column.attrname}Begin = ${column.attrname}Begin;
    }
    
 	/**
     * ${column.columnComment} 开始时间
     * @return
     */
	public String get${column.attrName}Begin()
    {
        return ${column.attrname}Begin;
    }
    
    /**
     * ${column.columnComment} 结束时间
     * @param ${column.attrname}End
     */
    public void set${column.attrName}End(String ${column.attrname}End)
    {
        this.${column.attrname}End = ${column.attrname}End;
    }
 	
 	/**
     * ${column.columnComment} 结束时间
     * @return
     */
	public String get${column.attrName}End()
    {
        return ${column.attrname}End;
    }
    
	</#if>
	</#list>
}