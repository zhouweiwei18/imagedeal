package com.ai.utils;

import java.util.HashMap;

import org.json.JSONObject;

import com.baidu.aip.imageclassify.AipImageClassify;

public class ImageUtil {
	// 设置APPID/AK/SK
	public static final String APP_ID = "15787966";
	public static final String API_KEY = "Q5RPyZaMdNGqTSXoVUYD0yfR";
	public static final String SECRET_KEY = "Z6RRVeKi4NEuGQzCWos20uyp3VWkesEA";
	public AipImageClassify client = null;

	// 构造方法初始化一个AipImageClassifyClient
	public ImageUtil() {
		client = new AipImageClassify(APP_ID, API_KEY, SECRET_KEY);
	}

	public static ImageUtil getUtil() {
		return new ImageUtil();
	}

	/**
	 * 普通物体识别
	 * 
	 * @param client
	 */
	public JSONObject universalIdentification(String image) {
		// 传入可选参数调用接口
		HashMap<String, String> options = new HashMap<String, String>();
		options.put("baike_num", "5");

		// 参数为本地路径
		JSONObject res = client.advancedGeneral(image, options);

		return res;
	}

	/**
	 * 菜品识别
	 * 
	 * @param client
	 */
	public JSONObject FoodIdentification(String image) {
		// 传入可选参数调用接口
		HashMap<String, String> options = new HashMap<String, String>();
		options.put("top_num", "3");
		options.put("filter_threshold", "0.7");
		options.put("baike_num", "5");

		// 参数为本地路径
		JSONObject res = client.dishDetect(image, options);

		return res;

	}

	/**
	 * 车辆识别
	 * 
	 * @param client
	 */
	public JSONObject carIdentification(String image) {
		// 传入可选参数调用接口
		HashMap<String, String> options = new HashMap<String, String>();
		options.put("top_num", "3");
		options.put("baike_num", "5");

		// 参数为本地路径
		JSONObject res = client.carDetect(image, options);

		return res;
	}

	/**
	 * logo商标识别
	 */
	public JSONObject logoIdentification(String image) {
		// 传入可选参数调用接口
		HashMap<String, String> options = new HashMap<String, String>();
		options.put("custom_lib", "false");

		// 参数为本地路径
		JSONObject res = client.logoSearch(image, options);

		return res;

	}

	/**
	 * 动物识别
	 * 
	 * @param client
	 */
	public JSONObject animalIdentification(String image) {
		// 传入可选参数调用接口
		HashMap<String, String> options = new HashMap<String, String>();
		options.put("top_num", "3");
		options.put("baike_num", "5");

		// 参数为本地路径
		JSONObject res = client.animalDetect(image, options);

		return res;
	}

	/**
	 * 植物识别
	 * 
	 * @param client
	 */
	public JSONObject plantIdentification(String image) {
		// 传入可选参数调用接口
		HashMap<String, String> options = new HashMap<String, String>();
		options.put("baike_num", "5");

		// 参数为本地路径
		JSONObject res = client.plantDetect(image, options);
		// System.out.println(res.toString(2));
		return res;

	}

	/**
	 * 图像主体检测
	 * 
	 * @param client
	 */
	public JSONObject objectIdentification(String image) {
		// 传入可选参数调用接口
		HashMap<String, String> options = new HashMap<String, String>();
		options.put("with_face", "0");

		// 参数为本地路径
		JSONObject res = client.objectDetect(image, options);

		return res;
	}

}
