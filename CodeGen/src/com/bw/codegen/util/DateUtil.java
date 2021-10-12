package com.bw.codegen.util;

public class DateUtil
{
	public static final String SINGLE_DATE_FROMAT = "yyyy-MM-dd HH:mm";

	private DateUtil()
	{
	}

	/**
	 * 以指定格式返回当时时间
	 * @param pattern - 日期显示格式
	 * @return the formatted date-time string
	 * @see java.text.SimpleDateFormat
	 */
	public static String formatDateTime(String pattern)
	{
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(pattern);
		String now = sdf.format(new java.util.Date());
		return now;
	}

}
