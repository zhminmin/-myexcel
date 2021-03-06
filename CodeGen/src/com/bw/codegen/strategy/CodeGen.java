package com.bw.codegen.strategy;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bw.codegen.model.TableInfo;
import com.bw.codegen.util.CodeGenConfig;
import com.bw.codegen.util.FileUtil;
import com.bw.codegen.util.FreeMarkerTemplateUtils;

import freemarker.template.Template;

public abstract class CodeGen 
{
	public abstract void generatorCode(List<TableInfo> tables)  throws Exception;
	
	protected void generateInitSql(List<TableInfo> tables) throws Exception
	{
		final String configPath = CodeGenConfig.DISKPATH + "init/";
		String suffix = "init.sql";
		String path = configPath + suffix;
		String templateName = "init_sql.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tables);

		suffix = "init_mysql.sql";
		path = configPath + suffix;
		templateName = "init_sql_mysql.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tables);
	}

	

	protected void generatePage(List<TableInfo> tables) throws Exception
	{
		final String configPath = CodeGenConfig.DISKPATH + "page/ftl/" + CodeGenConfig.MODULE_PATH + "/";
		for (TableInfo tableInfo : tables)
		{
			generatePageIndexFile(configPath, tableInfo);
			generatePageEditFile(configPath, tableInfo);
		}
	}
	
	protected void generateUapPage(List<TableInfo> tables) throws Exception
	{
		final String configPath = CodeGenConfig.DISKPATH + "face/" + CodeGenConfig.MODULE_PATH + "/";
		for (TableInfo tableInfo : tables)
		{
			generatePageUapIndexFile(configPath, tableInfo);
			generatePageUapScriptFile(configPath, tableInfo);
		}
	}
	
	private void generatePageUapIndexFile(String configPath, TableInfo tableInfo) throws Exception
	{
		String suffix = "index.jsp";
		String path = configPath + tableInfo.getClassname() + "/" + suffix;
		String templateName = "uap_index.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
		
		
	}
	
	private void generatePageUapScriptFile(String configPath, TableInfo tableInfo) throws Exception
	{
		String rootPath = configPath + tableInfo.getClassname() + "/scripts/";
		String suffix = "weblet.js";
		String path = rootPath + suffix;
		String templateName = "uap_weblet.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
		
		suffix = "MainViewController.js";
		path = rootPath + "views/" + suffix;
		templateName = "uap_MainViewController.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
		
		suffix = "MainView.js";
		path = rootPath + "views/" + suffix;
		templateName = "uap_MainView.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
		
		suffix = "AddView.js";
		path = rootPath + "views/" + suffix;
		templateName = "uap_AddView.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
		
		suffix = "EditView.js";
		path = rootPath + "views/" + suffix;
		templateName = "uap_EditView.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
		
		rootPath = configPath + tableInfo.getClassname() + "/resources/";
		mapperFile = new File(rootPath);
		FileUtil.mkDirs(mapperFile);
	}

	private void generatePageEditFile(String configPath, TableInfo tableInfo) throws Exception
	{
		String suffix = "edit.htm";
		String path = configPath + tableInfo.getClassname() + "/" + suffix;
		String templateName = "page_edit.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);

		suffix = "edit.htm";
		path = configPath + tableInfo.getClassname() + "/tab/" + suffix;
		templateName = "page_edit_tab.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
	}

	private void generatePageIndexFile(String configPath, TableInfo tableInfo) throws Exception
	{
		String suffix = "index.htm";
		String path = configPath + tableInfo.getClassname() + "/" + suffix;
		String templateName = "page_index.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);

		suffix = "index.htm";
		path = configPath + tableInfo.getClassname() + "/tab/" + suffix;
		templateName = "page_index_tab.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);

		suffix = "load.htm";
		path = configPath + tableInfo.getClassname() + "/" + suffix;
		templateName = "page_load.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);

		suffix = "query.htm";
		path = configPath + tableInfo.getClassname() + "/" + suffix;
		templateName = "page_query.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
	}

	protected void generateConfig(List<TableInfo> tables) throws Exception
	{
		final String configPath = CodeGenConfig.DISKPATH + "config/";
		generateMyBatis(configPath, tables);
		generateContext(configPath, tables);
		generateServlet(configPath, tables);
	}

	/** ?????? servlet ?????? */
	private void generateServlet(String configPath, List<TableInfo> tables) throws Exception
	{
		String suffix = "-servlet.xml";
		String path = configPath + "servlet/" + CodeGenConfig.MODULE_PATH + suffix;
		String templateName = "config_servlet.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tables);
	}

	/** ??????spring ds dao service ???????????? */
	private void generateContext(String configPath, List<TableInfo> tables) throws Exception
	{
		configPath += "context/" + CodeGenConfig.MODULE_PATH + "/";
		String suffix = "applicationContext-dao.xml";
		String path = configPath + suffix;
		String templateName = "config_dao.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tables);

		suffix = "applicationContext-ds.xml";
		path = configPath + suffix;
		templateName = "config_ds.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tables);

		suffix = "applicationContext-service.xml";
		path = configPath + suffix;
		templateName = "config_service.ftl";
		mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tables);
	}

	/** ??????mybatis-model?????? */
	private void generateMyBatis(String configPath, List<TableInfo> tables) throws Exception
	{
		for (TableInfo tableInfo : tables)
		{
			generateMyBatisMapperFile(configPath + "mybatis/sqlmap/" + CodeGenConfig.MODULE_PATH + "/m/", tableInfo, "mysql");
			generateMyBatisMapperFile(configPath + "mybatis/sqlmap/" + CodeGenConfig.MODULE_PATH + "/o/", tableInfo, "orcale");
		}
		generateMyBatisConfigFile(configPath + "mybatis/sqlmap/", tables);
	}

	/** ??????mybatis-config?????? */
	private void generateMyBatisConfigFile(String configPath, List<TableInfo> tables) throws Exception
	{
		final String suffix = CodeGenConfig.MODULENAME + "-config.xml";
		final String path = configPath + suffix;
		final String templateName = "config_SqlConfig.ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tables);
	}

	/** ??????mybatis-Mapper?????? */
	private void generateMyBatisMapperFile(String configPath, TableInfo tableInfo, String database) throws Exception
	{
		final String suffix = "_SqlMap.xml";
		final String path = configPath + tableInfo.getClassName() + suffix;
		final String templateName = "config_SqlMap_" + database + ".ftl";
		File mapperFile = new File(path);
		FileUtil.mkParentDirs(mapperFile);
		generateFileByTemplate(templateName, mapperFile, tableInfo);
	}

	/** ?????????????????????????????? */
	protected void generateFileByTemplate(final String templateName, File file, Object obj) throws Exception
	{
		Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
		FileOutputStream fos = new FileOutputStream(file);
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("tableInfo", obj);
		dataMap.put("author", CodeGenConfig.AUTHOR);
		dataMap.put("date", CodeGenConfig.CURRENT_DATE);
		dataMap.put("package_name", CodeGenConfig.PACKAGE_NAME);
		dataMap.put("modelpackage_name", CodeGenConfig.MODELPACKAGE_NAME);
		dataMap.put("module_name", CodeGenConfig.MODULE_NAME);
		dataMap.put("modulename", CodeGenConfig.MODULENAME);
		dataMap.put("module_path", CodeGenConfig.MODULE_PATH);
		dataMap.put("daopackage_name", CodeGenConfig.DAOPACKAGE_NAME);
		dataMap.put("servicepackage_name", CodeGenConfig.SERVICEPACKAGE_NAME);
		dataMap.put("txnpackage_name", CodeGenConfig.TXNPACKAGE_NAME);
		dataMap.put("controllerpackage_name", CodeGenConfig.CONTROLLERPACKAGE_NAME);

		Writer out = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"), 10240);
		template.process(dataMap, out);
	}

	/** ??????src?????? */
	protected void generateSrc(List<TableInfo> tables) throws Exception
	{
		final String srcPath = CodeGenConfig.DISKPATH + "src/";
		generateModelFile(srcPath, tables);
		generateDaoFile(srcPath, tables);
		generateServiceFile(srcPath, tables);

		generateTxnFile(srcPath, tables);
		generateControllerFile(srcPath, tables);
	}

	/** ??????src-controller?????? */
	private void generateControllerFile(String srcPath, List<TableInfo> tables) throws Exception
	{
		String servicePath = srcPath + CodeGenConfig.CONTROLLERPACKAGE_NAME.replace(".", "/") + "/";
		for (TableInfo tableInfo : tables)
		{
			String suffix = "Controller.java";
			String path = servicePath + tableInfo.getClassName() + suffix;
			String templateName = "src_Controller.ftl";
			File f = new File(path);
			FileUtil.mkParentDirs(f);
			generateFileByTemplate(templateName, f, tableInfo);
		}
	}

	/** ??????src-txn?????? */
	private void generateTxnFile(String srcPath, List<TableInfo> tables) throws Exception
	{
		String servicePath = srcPath + CodeGenConfig.TXNPACKAGE_NAME.replace(".", "/") + "/";
		for (TableInfo tableInfo : tables)
		{
			String suffix = "AppService.java";
			String path = servicePath + tableInfo.getClassName() + suffix;
			String templateName = "src_AppService.ftl";
			File f = new File(path);
			FileUtil.mkParentDirs(f);
			generateFileByTemplate(templateName, f, tableInfo);
		}
	}

	/** ??????src-service?????? */
	protected void generateServiceFile(String srcPath, List<TableInfo> tables) throws Exception
	{
		String servicePath = srcPath + CodeGenConfig.SERVICEPACKAGE_NAME.replace(".", "/") + "/";
		for (TableInfo tableInfo : tables)
		{
			String suffix = "Service.java";
			String path = servicePath + tableInfo.getClassName() + suffix;
			String templateName = "src_Service.ftl";
			File f = new File(path);
			FileUtil.mkParentDirs(f);
			generateFileByTemplate(templateName, f, tableInfo);
		}

		servicePath = servicePath + "impl/";
		for (TableInfo tableInfo : tables)
		{
			String suffix = "ServiceImpl.java";
			String path = servicePath + tableInfo.getClassName() + suffix;
			String templateName = "src_ServiceImpl.ftl";
			File f = new File(path);
			FileUtil.mkParentDirs(f);
			generateFileByTemplate(templateName, f, tableInfo);
		}

	}

	/** ??????src-dao?????? */
	protected void generateDaoFile(String srcPath, List<TableInfo> tables) throws Exception
	{
		String modelPath = srcPath + CodeGenConfig.DAOPACKAGE_NAME.replace(".", "/") + "/impl/";
		for (TableInfo tableInfo : tables)
		{
			String suffix = "Dao.java";
			String path = modelPath + tableInfo.getClassName() + suffix;
			String templateName = "src_DaoImpl.ftl";
			File f = new File(path);
			FileUtil.mkParentDirs(f);
			generateFileByTemplate(templateName, f, tableInfo);
		}
	}

	/** ??????src-model?????? */
	protected void generateModelFile(String srcPath, List<TableInfo> tables) throws Exception
	{
		String modelPath = srcPath + CodeGenConfig.MODELPACKAGE_NAME.replace(".", "/") + "/";
		for (TableInfo tableInfo : tables)
		{
			String suffix = ".java";
			String path = modelPath + tableInfo.getClassName() + suffix;
			String templateName = "src_Model.ftl";
			File f = new File(path);
			FileUtil.mkParentDirs(f);
			generateFileByTemplate(templateName, f, tableInfo);
		}
	}
	
}
