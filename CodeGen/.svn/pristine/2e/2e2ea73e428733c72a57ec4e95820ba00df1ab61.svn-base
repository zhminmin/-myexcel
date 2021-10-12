package com.bw.codegen.model;

import java.util.List;

/**
 * 数据库表
 * @author
 */
public class TableInfo
{
	/** 表名称 */
	private String tableName;

	/** 表描述 */
	private String tableComment;

	/** 表的主键列信息 */
	private ColumnInfo primaryKey;

	/** 表的列名(不包含主键) */
	private List<ColumnInfo> columns;

	/** 类名(第一个字母大写) */
	private String className;

	/** 类名(第一个字母小写) */
	private String classname;

	public String getTableName()
	{
		return tableName;
	}

	public void setTableName(String tableName)
	{
		this.tableName = tableName;
	}

	public String getTableComment()
	{
		return tableComment;
	}

	public void setTableComment(String tableComment)
	{
		this.tableComment = tableComment;
	}

	public List<ColumnInfo> getColumns()
	{
		return columns;
	}

	public void setColumns(List<ColumnInfo> columns)
	{
		this.columns = columns;
	}

	public String getClassName()
	{
		return className;
	}

	public void setClassName(String className)
	{
		this.className = className;
	}

	public String getClassname()
	{
		return classname;
	}

	public void setClassname(String classname)
	{
		this.classname = classname;
	}

	public ColumnInfo getPrimaryKey()
	{
		return primaryKey;
	}

	public void setPrimaryKey(ColumnInfo primaryKey)
	{
		this.primaryKey = primaryKey;
	}

	@Override
	public String toString()
	{
		return "Gen [tableName=" + tableName + ", tableComment=" + tableComment + ", className=" + className + ", classname=" + classname + "]";
	}

}
