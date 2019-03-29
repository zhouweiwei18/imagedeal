package com.ai.utils;

import java.net.URLEncoder;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class QualityUtil {

	public static QualityUtil getUtil() {
		return new QualityUtil();
	}

	public String imageQualityEnhance(String imagePath) {
		// 请求url
		String url = "https://aip.baidubce.com/rest/2.0/image-classify/v1/image_quality_enhance";
		try {
			// 本地文件路径
			//String filePath = "D:\\Picture\\1.jpg.png";
			byte[] imgData = FileUtil.readFileByBytes(imagePath);
			String imgStr = Base64Util.encode(imgData);
			String imgParam = URLEncoder.encode(imgStr, "UTF-8");

			String param = "image=" + imgParam;

			// 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
			String accessToken = "24.64d405d6d143542742365949ede1a09d.2592000.1556269830.282335-15864623";

			String result = HttpUtil.post(url, accessToken, param);

			JsonParser jp = new JsonParser();
			// 将json字符串转化成json对象
			JsonObject jo = jp.parse(result).getAsJsonObject();
			// 获取message对应的值
			String message = jo.get("image").getAsString();

			return message;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
