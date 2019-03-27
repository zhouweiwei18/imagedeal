package com.ai.utils;

import java.io.File;
import java.io.IOException;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

public class MyFileUtils {

	private static String location;

	/**
	 * 静态代码块加载配置文件信息
	 */
	static {
		ResourceBundle bundle = ResourceBundle.getBundle("jdbc");
		location = bundle.getString("file_loaction");
	}

	public static String uploadFile(HttpServletRequest request, MultipartFile file) throws IOException {
		if (!file.isEmpty()) {
			// 上传文件路径
			// 上传文件名
			String filename = file.getOriginalFilename();
			File filepath = new File(location, filename);
			// 判断路径是否存在，如果不存在就创建一个
			if (!filepath.getParentFile().exists()) {
				filepath.getParentFile().mkdirs();
			}

			// 打印一系列详细信息
			System.out.println(file.getSize());
			System.out.println(file.getBytes());
			System.out.println(file.getContentType());
			System.out.println(file.getInputStream());
			System.out.println(file.getName());
			System.out.println(file.getOriginalFilename());

			// 将上传文件保存到一个目标文件当中
			file.transferTo(new File(location + File.separator + filename));
			// 返回文件在服务器上存储的路径
			return filename;
		} else {
			// 返回null值
			return null;
		}
	}

	public static String[] getAllPicName() {
		File file = new File(location);
		String[] names = file.list();
		return names;
	}

	public static ResponseEntity<byte[]> getFile(String filename) throws Exception {
		HttpHeaders headers = new HttpHeaders();
		File file = new File(location +"\\"+ filename);

		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", filename);

		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}

}
