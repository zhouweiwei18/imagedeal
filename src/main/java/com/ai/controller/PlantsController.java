package com.ai.controller;

import java.util.HashMap;
import java.util.Map;

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

		Map<String, Object> map2 = obj.toMap();

		return (HashMap<String, Object>) map2;

	}

}