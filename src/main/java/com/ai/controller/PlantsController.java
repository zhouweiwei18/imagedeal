package com.ai.controller;

import java.util.HashMap;
import java.util.Iterator;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.utils.ImageUtil;

@Controller
@RequestMapping("/plants")
public class PlantsController {

	/**
	 * 用于植物的识别
	 */
	@RequestMapping(value = "/plantsIdent")
	@ResponseBody
	public HashMap<String, Object> plantsIdent(Integer plantsID) {

		// 这里的图片本应该是先本地上传到服务中的，图片地址保存到数据库
		// 根据地址找到对应的图片，进行图片识别

		// 假设这是一张植物类别的图片(路径)=========应该是变量
		String image = "D:\\Picture\\sunflower.jpg";

		JSONObject obj = ImageUtil.getUtil().plantIdentification(image);

		HashMap<String, Object> data = new HashMap<String, Object>();
		// 将json字符串转换成jsonObject
		// JSONObject jsonObject = JSONObject.fromObject(object);
		Iterator it = obj.keys();
		// 遍历jsonObject数据，添加到Map对象
		while (it.hasNext()) {
			String key = String.valueOf(it.next());
			Object value = obj.get(key);
			data.put(key, value);
		}
		return data;
	}

}