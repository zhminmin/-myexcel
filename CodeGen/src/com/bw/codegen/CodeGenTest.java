package com.bw.codegen;

import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.bw.codegen.model.TargetTable;

/**
 * Unit test for simple App.
 */
public class CodeGenTest
{
	public static void main(String[] args) throws Exception
	{
		// generate();
		generateWithAlias();
	}

	private static void generateWithAlias() throws Exception
	{
		// 目标数据表
		List<TargetTable> targetTbs = new ArrayList<TargetTable>();
		targetTbs.add(new TargetTable("lzhapp_material"));
		CodeGenMain codeGenMain = new CodeGenMain();
		Properties p = new Properties();
		p.load(CodeGenMain.class.getResourceAsStream("/config.properties"));
		codeGenMain.generateWithAlias(targetTbs, p);
	}
}
