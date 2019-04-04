package com.ai.utils;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

public class FaceUtil {

	public static FaceUtil getUtil() {
		return new FaceUtil();
	}

	// 人脸检测
	public Map<String, Object> check(String facePath) {
		// 请求url
		String url = "https://aip.baidubce.com/rest/2.0/face/v3/detect";
		try {
			Map<String, Object> map = new HashMap<String, Object>();

			String base64 = Base64ImageUtils.GetImageStrFromPath(facePath);

			map.put("image", base64);
			map.put("face_field", "age,beauty,expression,faceshape,gender,glasses,race,qualities,emotion,landmark150");
			map.put("image_type", "BASE64");

			String param = GsonUtils.toJson(map);

			// 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
			String accessToken = "24.582f1e3b8219bcd796f18761a0111b4f.2592000.1556355073.282335-15791498";

			String result = HttpUtil.post(url, accessToken, "application/json", param);
			
			Gson gson = new Gson();  
			map = gson.fromJson(result,Map.class);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 人脸检测
	public Map<String, Object> checkByBase64(String facePath) {
		// 请求url
		String url = "https://aip.baidubce.com/rest/2.0/face/v3/detect";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			
			//String base64 = Base64ImageUtils.GetImageStrFromPath(facePath);
			
			map.put("image", facePath);
			map.put("face_field", "age,beauty,expression,faceshape,gender,glasses,race,qualities,emotion,landmark150");
			map.put("image_type", "BASE64");
			
			String param = GsonUtils.toJson(map);
			
			// 注意这里仅为了简化编码每一次请求都去获取access_token，线上环境access_token有过期时间， 客户端可自行缓存，过期后重新获取。
			String accessToken = "24.582f1e3b8219bcd796f18761a0111b4f.2592000.1556355073.282335-15791498";
			
			String result = HttpUtil.post(url, accessToken, "application/json", param);
			
			Gson gson = new Gson();  
			map = gson.fromJson(result,Map.class);
			return map;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
