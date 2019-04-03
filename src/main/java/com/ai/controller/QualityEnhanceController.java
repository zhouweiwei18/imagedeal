package com.ai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.utils.QualityUtil;

@Controller
@RequestMapping("/quality")
public class QualityEnhanceController {

	@RequestMapping(value = "/qualityEnhance")
	@ResponseBody
	public String qualityEnhance(String imagePath) {

		//imagePath = "D:\\Picture\\boy.jpg.png";
		imagePath = "/usr/share/pixmaps/boy.jpg.png";

		return QualityUtil.getUtil().imageQualityEnhance(imagePath);
	}

}
