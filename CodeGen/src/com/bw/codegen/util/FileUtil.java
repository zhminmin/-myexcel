package com.bw.codegen.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * 文件操作
 */
public class FileUtil
{

	private FileUtil()
	{

	}

	/**
	 * 递归删除文件或目录
	 * @param file
	 */
	public static boolean deleteFile(File file) throws Exception
	{
		// 判断文件是否存在
		if (!file.exists())
		{
			return false;
		}

		// 遍历目录下所有的文件
		if (file.isDirectory())
		{
			for (File f : file.listFiles())
			{
				deleteFile(f);
			}
		}

		// 删除空目录或文件
		return file.delete();
	}

	/**
	 * 根据路径和byte生成文件
	 * @param path
	 * @param input
	 */
	public static void wirteFile(String path, byte[] input) throws Exception
	{
		File folder = new File(path);
		if (!folder.getParentFile().exists())
		{
			folder.getParentFile().mkdirs();
		}
		if (!folder.exists())
		{
			folder.createNewFile();
		}
		File outFile = new File(path);
		OutputStream output = new FileOutputStream(outFile);
		output.write(input);
		output.flush();
		output.close();
	}

	/**
	 * 创建父文件夹
	 * @param destPath destPath
	 * @throws IOException
	 */
	public static void mkParentDirs(String destPath) throws IOException
	{
		mkParentDirs(new File(destPath));
	}

	/**
	 * 创建父文件夹
	 * @param destPath destPath
	 * @throws IOException
	 */
	public static void mkParentDirs(File destFile) throws IOException
	{
		// 创建文件
		if (destFile.getParentFile() != null && !destFile.getParentFile().exists() && !destFile.getParentFile().mkdirs())
		{
			throw new IOException("目标目录 \'" + destFile + "\' 创建失败");
		}
	}

	/**
	 * 创建父文件夹
	 * @param destPath destPath
	 * @throws IOException
	 */
	public static void mkDirs(File destFile) throws IOException
	{
		// 创建文件
		if (destFile != null && !destFile.exists() && !destFile.mkdirs())
		{
			throw new IOException("目标目录 \'" + destFile + "\' 创建失败");
		}
	}

	/**
	 * 写入文件到磁盘相应路径下
	 * @param inputStream 输入流
	 * @param filePath 文件路径
	 * @return
	 * @throws IOException
	 */
	public static boolean writeFile(InputStream inputStream, String filePath) throws IOException
	{
		if ((inputStream == null) || StringUtil.isEmpty(filePath))
		{
			return false;
		}
		File file = new File(filePath.replace("\\", File.separator).replace("//", File.separator));
		if (!file.exists())
		{
			File parent = file.getParentFile();
			if (!parent.exists())
			{
				// 新建文件夹
				if (!parent.mkdirs())
				{
					return false;
				}
			}
			// 创建新文件
			if (!file.createNewFile())
			{
				return false;
			}
		}

		FileOutputStream outputStream = null;
		try
		{
			outputStream = new FileOutputStream(file);
			// 写入流
			return writeStream(inputStream, outputStream);
		}
		finally
		{
			if (outputStream != null)
			{
				outputStream.close();
			}
			// 释放输入流
			inputStream.close();
		}
	}

	/**
	 * 删除文件
	 * @param filePath 文件路径
	 * @return
	 */
	public static boolean deleteFile(String filePath)
	{
		File file = new File(filePath.replace("\\", "/").replace("//", "/"));
		if (!file.exists())
		{
			return true;
		}
		return file.delete();
	}

	/**
	 * 输入输出流转换，将输入流内容写入到输出流内
	 * @param inputStream 输入流
	 * @param outputStream 输出流
	 * @return
	 * @throws IOException
	 */
	public static boolean writeStream(InputStream inputStream, OutputStream outputStream) throws IOException
	{
		if ((inputStream == null) || (outputStream == null))
		{
			return false;
		}
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try
		{
			bis = new BufferedInputStream(inputStream);
			bos = new BufferedOutputStream(outputStream);

			byte[] buffer = new byte[102400];
			// int total = 0;
			int len = 0;

			while ((len = bis.read(buffer)) > 0)
			{
				bos.write(buffer, 0, len);
				// total += len;
				bos.flush();
			}
			bos.flush();
			bos.close();

		}
		finally
		{
			if (bis != null)
			{
				bis.close();
			}
			if (bos != null)
			{
				bos.close();
			}
		}
		return true;
	}

	/**
	 * 获取文件大小字符串
	 * @param size
	 * @return
	 */
	public static String getFileSize(long size)
	{
		String fileSize;
		if (size > 1024 * 1024 * 1024)
		{
			fileSize = new BigDecimal(size).divide(new BigDecimal(1024 * 1024 * 1024), 2, RoundingMode.HALF_DOWN).toString() + "G";
		}
		else if (size > 1024 * 1024)
		{
			fileSize = new BigDecimal(size).divide(new BigDecimal(1024 * 1024), 2, RoundingMode.HALF_DOWN).toString() + "MB";
		}
		else if (size > 1024)
		{
			fileSize = new BigDecimal(size).divide(new BigDecimal(1024), 2, RoundingMode.HALF_DOWN).toString() + "KB";
		}
		else
		{
			fileSize = String.valueOf(size) + "B";
		}
		return fileSize;
	}

}
