package com.ai.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.utils.ContrastUtil;

@Controller
@RequestMapping("/contrast")
public class ContrastEnhanceController {

	@RequestMapping(value = "/contrastEnhance")
	@ResponseBody
	public String contrastEnhance(String imagePath) {

		imagePath = "D:\\Picture\\5.jpg";

		return ContrastUtil.getUtil().contrastEnhance(imagePath);
	}

}
