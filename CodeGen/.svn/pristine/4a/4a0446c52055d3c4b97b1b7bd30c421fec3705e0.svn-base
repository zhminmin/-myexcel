package com.bw.codegen;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.bw.codegen.model.ColumnInfo;
import com.bw.codegen.model.TableInfo;
import com.bw.codegen.model.TargetTable;
import com.bw.codegen.strategy.CodeGen;
import com.bw.codegen.strategy.SsmCodeGen;
import com.bw.codegen.strategy.TemplateCodeGen;
import com.bw.codegen.strategy.UapCodeGen;
import com.bw.codegen.util.CodeGenConfig;
import com.bw.codegen.util.FileUtil;
import com.bw.codegen.util.StringUtil;

/**
 * 描述：代码生成器 <br>
 */
public class CodeGenMain
{
	private static final Log LOG = LogFactory.getLog(CodeGenMain.class);
	
	private static Map<String,CodeGen> strategyMap = new HashMap<String,CodeGen>();

	private void init(Properties p)
	{
		CodeGenConfig.init(p);
	}

	public void generateWithAlias(List<TargetTable> targetTbs, Properties p)
	{
		try
		{
			init(p);

			File rootFolder = new File(CodeGenConfig.DISKPATH);
			if (rootFolder.exists())
			{
				FileUtil.deleteFile(rootFolder);
			}
			FileUtil.mkDirs(rootFolder);

			List<TableInfo> tables = new ArrayList<TableInfo>();
			for (TargetTable tb : targetTbs)
			{
				tables.add(getTableInfo(tb.getTableName(), tb.getClassName()));
			}
			strategyMap.get(CodeGenConfig.TEMPLATE_NAME).generatorCode(tables);
			
		}
		catch (Exception e)
		{
			LOG.error(e);
		}
	}

	public void generate(List<String> targetTbs, Properties p)
	{
		try
		{
			init(p);

			File rootFolder = new File(CodeGenConfig.DISKPATH);
			if (rootFolder.exists())
			{
				FileUtil.deleteFile(rootFolder);
			}
			FileUtil.mkDirs(rootFolder);

			List<TableInfo> tables = new ArrayList<TableInfo>();
			for (String tb : targetTbs)
			{
				tables.add(getTableInfo(tb, null));
			}
			strategyMap.get(CodeGenConfig.TEMPLATE_NAME).generatorCode(tables);
		}
		catch (Exception e)
		{
			LOG.error(e);
		}
	}
	
	private TableInfo getTableInfo(String tb, String tbAlias) throws Exception
	{
		String _tb = tb.toLowerCase();
		Connection conn = null;
		PreparedStatement pst = null;
		ResultSet rs = null;
		try
		{
			conn = getConnection();
			pst = conn.prepareStatement(CodeGenConfig.SELECT_TB);
			pst.setString(1, tb);
			rs = pst.executeQuery();
			TableInfo tableInfo = null;
			while (rs.next())
			{
				tableInfo = new TableInfo();
				tableInfo.setTableName(_tb);
				if (StringUtil.isNotEmpty(tbAlias))
				{
					tableInfo.setClassName(StringUtils.capitalize(tbAlias));
				}
				else
				{
					tableInfo.setClassName(replaceUnderLineAndUpperCase(_tb));
				}
				tableInfo.setClassname(StringUtils.uncapitalize(tableInfo.getClassName()));
				tableInfo.setTableComment(rs.getString("table_comment"));
			}

			if (tableInfo == null)
			{
				throw new RuntimeException("表[" + tb + "]不存在");
			}

			LOG.debug(tableInfo);

			pst = conn.prepareStatement(CodeGenConfig.SELECT_TBCOL);
			pst.setString(1, tb);
			rs = pst.executeQuery();
			List<ColumnInfo> columns = new ArrayList<ColumnInfo>();
			ColumnInfo column = null;
			while (rs.next())
			{
				column = new ColumnInfo();
				column.setColumnComment(rs.getString("column_comment"));
				String dataType = rs.getString("data_type").toLowerCase();

				if (dataType.indexOf("(") != -1)
				{
					dataType = dataType.substring(0, dataType.indexOf("("));
				}

				if ("number".equals(dataType))
				{
					String dataScale = rs.getString("data_scale");
					if (StringUtil.isNotEmpty(dataScale) && !"0".equals(dataScale))
					{
						dataType = "decimal";
					}
					else
					{
						String dataPrecision = rs.getString("data_precision");
						if (StringUtil.isNotEmpty(dataPrecision) && Integer.parseInt(dataPrecision) >= 20)
						{
							dataType = "bigint";
						}
					}
				}

				column.setColumnType(dataType);
				column.setColumnName(rs.getString("column_name").toLowerCase());
				column.setColumnKey(rs.getString("COLUMN_KEY"));
				column.setColumnLength(rs.getString("CHARACTER_MAXIMUM_LENGTH"));
				column.setAttrName(replaceUnderLineAndUpperCase(column.getColumnName()));
				column.setAttrname(StringUtils.uncapitalize(column.getAttrName()));
				// 列的数据类型，转换成Java类型
				String attrType = javaTypeMap.get(column.getColumnType());
				column.setAttrType(attrType);
				columns.add(column);

				if (StringUtil.isNotEmpty(column.getColumnKey()) && tableInfo.getPrimaryKey() == null)
				{
					tableInfo.setPrimaryKey(column);
				}

				LOG.debug(column);
			}

			if (null == tableInfo.getPrimaryKey())
			{
				tableInfo.setPrimaryKey(columns.get(0));
			}
			tableInfo.setColumns(columns);
			return tableInfo;
		}
		finally
		{
			if (rs != null)
			{
				try
				{
					rs.close();
				}
				catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
			if (pst != null)
			{
				try
				{
					pst.close();
				}
				catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
			if (conn != null)
			{
				try
				{
					conn.close();
				}
				catch (SQLException e)
				{
					e.printStackTrace();
				}
			}
		}
	}
	
	private Connection getConnection() throws Exception
	{
		Class.forName(CodeGenConfig.DRIVER);
		Connection connection = DriverManager.getConnection(CodeGenConfig.URL, CodeGenConfig.USER, CodeGenConfig.PASSWORD);
		return connection;
	}
	
	private static String replaceUnderLineAndUpperCase(String str)
	{
		return StringUtils.capitalize(replaceUnderLine(str));
	}

	private static String replaceUnderLine(String str)
	{
		StringBuilder sb = new StringBuilder();
		sb.append(str);
		int count = sb.indexOf("_");
		while (count != 0)
		{
			int num = sb.indexOf("_", count);
			count = num + 1;
			if (num != -1)
			{
				char ss = sb.charAt(count);
				char ia = (char) (ss - 32);
				sb.replace(count, count + 1, ia + "");
			}
		}
		return sb.toString().replaceAll("_", "");
	}
	
	/** 状态编码转换 */
	private static Map<String, String> javaTypeMap = new HashMap<String, String>();
	
	static
	{
		initJavaTypeMap();
		strategyMap.put("UAP", new UapCodeGen());
		strategyMap.put("templates", new TemplateCodeGen());
		strategyMap.put("2.0.1", new SsmCodeGen());
	}
	
	/**
	 * 返回状态映射
	 */
	private static void initJavaTypeMap()
	{
		javaTypeMap.put("tinyint", "Integer");
		javaTypeMap.put("smallint", "Integer");
		javaTypeMap.put("mediumint", "Integer");
		javaTypeMap.put("int", "Integer");
		javaTypeMap.put("integer", "Integer");
		javaTypeMap.put("number", "Integer");
		javaTypeMap.put("bigint", "Long");
		javaTypeMap.put("float", "Float");
		javaTypeMap.put("double", "Double");
		javaTypeMap.put("decimal", "BigDecimal");
		javaTypeMap.put("bit", "Boolean");
		javaTypeMap.put("char", "String");
		javaTypeMap.put("varchar", "String");
		javaTypeMap.put("varchar2", "String");
		javaTypeMap.put("tinytext", "String");
		javaTypeMap.put("text", "String");
		javaTypeMap.put("clob", "String");
		javaTypeMap.put("mediumtext", "String");
		javaTypeMap.put("longtext", "String");
		javaTypeMap.put("date", "Date");
		javaTypeMap.put("datetime", "Date");
		javaTypeMap.put("timestamp", "Date");
	}
	
	
}