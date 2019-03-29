package com.ai.controller;

import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.utils.Base64ImageUtils;
import com.ai.utils.Base64Util;
import com.ai.utils.FileUtil;
import com.ai.utils.HttpUtil;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
@RequestMapping("/defog")
public class DefogController {
	
	@RequestMapping(value="/defogMethod")
	@ResponseBody
	public String defogMethod(String fogPath) {
		// 请求url
		String url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/dehaze";
		try {
			// 本地文件路径
			String filePath = "D:\\Picture\\fog.jpg";
			byte[] imgData = FileUtil.readFileByBytes(filePath);
			String imgStr = Base64Util.encode(imgData);
			String imgParam = URLEncoder.encode(imgStr, "UTF-8");

			String param = "image=" + imgParam;

			// 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
			String accessToken = "24.64d405d6d143542742365949ede1a09d.2592000.1556269830.282335-15864623";

			String result = HttpUtil.post(url, accessToken, param);
			
			System.out.println("-------------------------------------");

			JsonParser jp = new JsonParser();
			// 将json字符串转化成json对象
			JsonObject jo = jp.parse(result).getAsJsonObject();
			// 获取图片Base64格式对应的值
			String message = jo.get("image").getAsString();
			//System.out.println("message：" + message);

			// 将Base64转化为图片格式
			//String imgFilePath = "D:\\tmp\\2.jpeg";
			//Base64ImageUtils.saveImage(message, imgFilePath);
 
			return message;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
