package com.ai.controller;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.utils.FaceUtil;

@Controller
@RequestMapping("/face")
public class FaceController {

	@RequestMapping(value = "/faceIdent")
	@ResponseBody
	public Map<String, Object> plantsIdent(String facePath) {
		// 根据地址找到对应的图片，进行图片识别
		// 假设这是一张植物类别的图片(路径)=========应该是变量
		if (facePath == null) {
			// 这里对于本机而言
			facePath = "D:\\Picture\\girlface.jpg";
		}

		return FaceUtil.getUtil().check(facePath);

	}
}