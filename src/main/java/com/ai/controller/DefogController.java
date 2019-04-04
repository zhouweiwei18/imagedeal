package com.ai.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ai.utils.Base64ImageUtils;
import com.ai.utils.Base64Util;
import com.ai.utils.FileUtil;
import com.ai.utils.HttpUtil;
import com.ai.utils.MyFileUtils;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
@RequestMapping("/defog")
public class DefogController {

	@RequestMapping(value = "/defogMethod")
	@ResponseBody
	public String defogMethod(String fogPath, HttpServletRequest request) {
		// 请求url
		String url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/dehaze";
		try {

			// 根据地址找到对应的图片，进行图片识别
			String imagePath = (String) request.getSession().getAttribute("foggyImagePath");

			if (imagePath != null) {
				MyFileUtils utils = new MyFileUtils();
				fogPath = utils.des + imagePath;
			}

			if (imagePath == null) {
				// 加载本机默认图片进行识别
				fogPath = "D:\\Picture\\fog.jpg";
			}

			// 本地文件路径
			// String filePath = "D:\\Picture\\fog.jpg";
			// String filePath = "/usr/share/pixmaps/fog.jpg";
			byte[] imgData = FileUtil.readFileByBytes(fogPath);
			String imgStr = Base64Util.encode(imgData);
			String imgParam = URLEncoder.encode(imgStr, "UTF-8");

			String param = "image=" + imgParam;

			// 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
			String accessToken = "24.64d405d6d143542742365949ede1a09d.2592000.1556269830.282335-15864623";

			String result = HttpUtil.post(url, accessToken, param);

			JsonParser jp = new JsonParser();
			// 将json字符串转化成json对象
			JsonObject jo = jp.parse(result).getAsJsonObject();
			// 获取图片Base64格式对应的值
			String message = jo.get("image").getAsString();

			return message;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@RequestMapping(value = "/foggyChange", method = RequestMethod.POST)
	public String userAdd(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
		// 下面需要进行对文件进行处理
		String path = null;
		try {
			path = MyFileUtils.uploadFile(request, file);
			System.out.println(path);
			// 将路径存储到域中，用于前端显示，同时解析该图片
			request.getSession().setAttribute("foggyImagePath", path);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "defogging";
	}

}
