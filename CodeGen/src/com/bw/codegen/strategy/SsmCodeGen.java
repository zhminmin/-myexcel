package com.bw.codegen.strategy;

import java.util.List;

import com.bw.codegen.model.TableInfo;

public class SsmCodeGen extends CodeGen 
{

	@Override
	public void generatorCode(List<TableInfo> tables) throws Exception
	{
		generateSrc(tables);
		generateConfig(tables);
		generatePage(tables);
		generateInitSql(tables);
	}

}
