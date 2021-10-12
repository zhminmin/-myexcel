package com.bw.codegen.util;

import java.io.IOException;

import freemarker.cache.ClassTemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateExceptionHandler;

/**
 * 模板工具
 */
public class FreeMarkerTemplateUtils
{
	private static final Configuration CONFIGURATION = new Configuration();

	private FreeMarkerTemplateUtils()
	{
	}

	static
	{
		// 这里比较重要，用来指定加载模板所在的路径
		CONFIGURATION.setTemplateLoader(new ClassTemplateLoader(FreeMarkerTemplateUtils.class, "/" + CodeGenConfig.TEMPLATE_NAME));
		CONFIGURATION.setDefaultEncoding("UTF-8");
		CONFIGURATION.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
	}

	public static Template getTemplate(String templateName) throws IOException
	{
		return CONFIGURATION.getTemplate(templateName);
	}

	public static void clearCache()
	{
		CONFIGURATION.clearTemplateCache();
	}
}