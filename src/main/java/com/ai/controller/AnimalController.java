package com.ai.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.utils.ImageUtil;

@Controller
@RequestMapping("/animal")
public class AnimalController {

	@RequestMapping(value = "/animalIdent")
	@ResponseBody
	public HashMap<String, Object> plantsIdent(String animalPath) {
		// 根据地址找到对应的图片，进行图片识别
		// 假设这是一张植物类别的图片(路径)=========应该是变量
		if (animalPath == null) {
			// 这里对于本机而言
			animalPath = "D:\\Picture\\cat.jpg";
		}

		JSONObject obj = ImageUtil.getUtil().animalIdentification(animalPath);

		Map<String, Object> map2 = obj.toMap();

		return (HashMap<String, Object>) map2;

	}
}
