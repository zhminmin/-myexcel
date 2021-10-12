package com.bw.codegen;

import java.io.FileWriter;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class GenSqlCommit
{
	public static void main(String[] args)
	{
		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;

		try
		{
			// 1.注册驱动
			DriverManager.registerDriver(new com.mysql.jdbc.Driver());

			// 2.建立连接
			// 方法一 参数一：协议+访问数据库，参数二：用户名，参数三：密码
			connection = (Connection) DriverManager.getConnection("jdbc:mysql://10.1.16.40:3306/200scsc", "root", "123456");

			// 方法二
			// DriverManager.getConnection("jdbc:msql://localhost/student?user=root&password=password");

			// 3.创建statement，跟数据库打交道一定需要这个对象
			st = (Statement) connection.createStatement();

			// 4.执行查询
			String sql = "select table_name from information_schema.tables WHERE TABLE_TYPE = 'BASE TABLE'";
			rs = st.executeQuery(sql);

			List<String> sqlStrings = new ArrayList<String>();
			// 5.遍历查询每一条记录
			while (rs.next())
			{
				String table_name = rs.getString("table_name");
				System.out.println("开始执行" + table_name);
				String tableSql = "SHOW FULL COLUMNS FROM " + table_name;
				String updateSqls = "-- " + table_name + ";";
				sqlStrings.add(updateSqls);
				try
				{
					ResultSet resultSet = connection.createStatement().executeQuery(tableSql);
					while (resultSet.next())
					{
						if (!StringUtils.isBlank(resultSet.getString("Comment")) && !"PRI".equals(resultSet.getString("Key")))
						{
							sqlStrings.add("alter table " + table_name + " modify column `" + resultSet.getString("Field") + "` " + resultSet.getString("Type") + " COMMENT '" + resultSet.getString("Comment") + "';");
						}
					}
				}
				catch (Exception e)
				{
					// TODO: handle exception
				}

				sqlStrings.add("");
			}
			FileWriter fwriter = new FileWriter("C:\\四川\\更新.sql", false);
			fwriter.write(StringUtils.join(sqlStrings, "\n"));

		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
	}
}
