package com.bw.codegen.util;

public class StringUtil
{
	/**
	 * 是否为空
	 * @param object
	 * @return
	 */
	public static boolean isNull(Object object)
	{
		if (object instanceof String)
		{
			return StringUtil.isEmpty(object.toString());
		}
		return object == null;
	}

	/**
	 * 是否不为空
	 * @param object
	 * @return
	 */
	public static boolean isNotNull(Object object)
	{
		if (object instanceof String)
		{
			return StringUtil.isNotEmpty(object.toString());
		}
		return object != null;
	}

	/**
	 * 是否为空
	 * @param value
	 * @return
	 */
	public static boolean isEmpty(final String value)
	{
		return value == null || value.trim().length() == 0 || "null".endsWith(value);
	}

	/**
	 * 是否不为空
	 * @param value
	 * @return
	 */
	public static boolean isNotEmpty(final String value)
	{
		return value != null && value.trim().length() > 0 && !"null".endsWith(value);
	}
}
