package com.bw.codegen.util;

import java.util.Properties;

public class CodeGenConfig
{
	// public static final String SELECT_TBS =
	// "select table_name, table_comment, create_time, update_time from information_schema.tables where table_comment <> '' and table_schema = (select database()) AND table_name = #{searchValue}";
	/* 获取具体表 */
	public static final String MYSQL_SELECT_TB = "select table_name, table_comment from information_schema.tables where table_comment <> '' and table_schema = (select database()) and table_name = ?";
	/* 获取具体表字段 */
	public static final String MYSQL_SELECT_TBCOL = "select column_name, data_type, column_comment, COLUMN_KEY, CHARACTER_MAXIMUM_LENGTH from information_schema.columns where table_name = ? and table_schema = (select database()) order by ordinal_position";
	/* 获取具体表 */
	public static final String ORCALE_SELECT_TB = "SELECT COMMENTS AS table_comment FROM user_tab_comments WHERE Table_Name = ?";
	/* 获取具体表字段 */
	public static final String ORCALE_SELECT_TBCOL = "SELECT tcol.COLUMN_NAME AS column_name, tcol.DATA_TYPE AS data_type, tcom.COMMENTS AS column_comment, ( SELECT CASE WHEN COUNT (*) > 0 THEN 'PRI' ELSE  ''  END  FROM  user_cons_columns tcc, user_constraints tuc WHERE tcc.constraint_name = tuc.constraint_name AND tuc.constraint_type = 'P' AND tcc.TABLE_NAME = tcol.TABLE_NAME AND tcc.COLUMN_NAME = tcol.COLUMN_NAME ) AS COLUMN_KEY, tcol.DATA_LENGTH AS CHARACTER_MAXIMUM_LENGTH, tcol.DATA_PRECISION as data_precision, tcol.DATA_SCALE as data_scale FROM  user_tab_columns tcol, user_col_comments tcom WHERE tcom.TABLE_NAME = tcol.TABLE_NAME AND tcom.COLUMN_NAME = tcol.COLUMN_NAME AND tcom.TABLE_NAME = ? ORDER BY  tcol.COLUMN_id";
	/** 输出目录 */
	public static String DISKPATH;
	/** 扩展模块名 */
	public static String MODULE_NAME;
	/** 扩展模块名 驼峰 */
	public static String MODULENAME;
	/** 扩展模块路径 */
	public static String MODULE_PATH;
	/** 模块包名 */
	public static String PACKAGE_NAME;
	/** model 包名 */
	public static String MODELPACKAGE_NAME;
	/** DAO 包名 */
	public static String DAOPACKAGE_NAME;
	/** service 包名 */
	public static String SERVICEPACKAGE_NAME;
	/** txn 包名 */
	public static String TXNPACKAGE_NAME;
	/** controller 包名 */
	public static String CONTROLLERPACKAGE_NAME;

	/** 作者 */
	public static String AUTHOR;
	/** 日期 */
	public static String CURRENT_DATE;
	/** 模板名称 */
	public static String TEMPLATE_NAME = "templates";

	/** 数据库 */
	public static String URL;
	/** 用户名 */
	public static String USER;
	/** 密码 */
	public static String PASSWORD;
	/** 驱动 */
	public static String DRIVER;
	public static String SELECT_TB;
	public static String SELECT_TBCOL;

	public static void init(Properties p)
	{
		DISKPATH = p.getProperty("diskPath");
		MODULE_NAME = p.getProperty("MODULE_NAME");
		if (StringUtil.isNotEmpty(p.getProperty("TEMPLATE_NAME")))
		{
			TEMPLATE_NAME = p.getProperty("TEMPLATE_NAME");
		}
		MODULE_PATH = MODULE_NAME.replace(".", "/");
		MODULENAME = replaceUnderLine(CodeGenConfig.MODULE_NAME.replace(".", "_"));
		PACKAGE_NAME = "com.bw." + MODULE_NAME;
		MODELPACKAGE_NAME = PACKAGE_NAME + ".model";
		DAOPACKAGE_NAME = PACKAGE_NAME + ".dao";
		SERVICEPACKAGE_NAME = PACKAGE_NAME + ".service";
		TXNPACKAGE_NAME = PACKAGE_NAME + ".txn";
		CONTROLLERPACKAGE_NAME = PACKAGE_NAME + ".controller";

		AUTHOR = p.getProperty("AUTHOR");
		CURRENT_DATE = DateUtil.formatDateTime(DateUtil.SINGLE_DATE_FROMAT);

		URL = p.getProperty("URL");
		USER = p.getProperty("USER");
		PASSWORD = p.getProperty("PASSWORD");
		DRIVER = p.getProperty("DRIVER");
		SELECT_TB = "com.mysql.jdbc.Driver".equals(DRIVER) ? MYSQL_SELECT_TB : ORCALE_SELECT_TB;
		SELECT_TBCOL = "com.mysql.jdbc.Driver".equals(DRIVER) ? MYSQL_SELECT_TBCOL : ORCALE_SELECT_TBCOL;
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
}
