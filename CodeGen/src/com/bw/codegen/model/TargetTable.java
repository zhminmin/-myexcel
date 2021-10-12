package com.bw.codegen.model;

/**
 * 要生成的表信息
 * @author zp
 */
public class TargetTable
{
	/** 表名称 */
	private String tableName;
	/** 类名(第一个字母大写) */
	private String className;

	public TargetTable(String tableName)
	{
		super();
		this.tableName = tableName;
	}

	public TargetTable(String tableName, String className)
	{
		super();
		this.tableName = tableName;
		this.className = className;
	}

	/** 表名称 */
	public String getTableName()
	{
		return tableName;
	}

	/** 表名称 */
	public void setTableName(String tableName)
	{
		this.tableName = tableName;
	}

	/** 类名(第一个字母大写) */
	public String getClassName()
	{
		return className;
	}

	/** 类名(第一个字母大写) */
	public void setClassName(String className)
	{
		this.className = className;
	}

}
