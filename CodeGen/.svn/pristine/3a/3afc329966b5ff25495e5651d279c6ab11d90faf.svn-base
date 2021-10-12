package com.bw.codegen.strategy;

import java.io.File;
import java.util.List;

import com.bw.codegen.model.TableInfo;
import com.bw.codegen.util.CodeGenConfig;
import com.bw.codegen.util.FileUtil;

public class UapCodeGen extends CodeGen
{

	@Override
	public void generatorCode(List<TableInfo> tables) throws Exception
	{
		generateConfig(tables);
		generateUapPage(tables);
		generateSrc(tables);
	}
	
	protected void generateSrc(List<TableInfo> tables) throws Exception
	{
		final String srcPath = CodeGenConfig.DISKPATH + "src/";
		generateModelFile(srcPath, tables);
		generateDaoFile(srcPath, tables);
		generateServiceFile(srcPath, tables);
		generateUapControllerFile(srcPath, tables);
	}
	
	private void generateUapControllerFile(String srcPath, List<TableInfo> tables) throws Exception
	{
		String servicePath = srcPath + CodeGenConfig.CONTROLLERPACKAGE_NAME.replace(".", "/") + "/";
		for (TableInfo tableInfo : tables)
		{
			String suffix = "Controller.java";
			String path = servicePath + tableInfo.getClassName() + suffix;
			String templateName = "uap_Controller.ftl";
			File f = new File(path);
			FileUtil.mkParentDirs(f);
			generateFileByTemplate(templateName, f, tableInfo);
		}
	}

}
