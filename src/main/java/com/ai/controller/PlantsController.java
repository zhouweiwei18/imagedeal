package com.ai.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ai.utils.ImageUtil;
import com.ai.utils.MyFileUtils;

@Controller
@RequestMapping("/plants")
public class PlantsController {

	/**
	 * 用于植物的识别
	 */
	@RequestMapping(value = "/plantsIdent")
	@ResponseBody
	public HashMap<String, Object> plantsIdent(String plantsPath,HttpServletRequest request) {
		
		// 根据地址找到对应的图片，进行图片识别
		String imagePath = (String) request.getSession().getAttribute("plantImagePath");

		if (imagePath != null) {
			MyFileUtils utils = new MyFileUtils();
			plantsPath = utils.des + imagePath;
		}
		
		if (imagePath == null) {
			// 加载本机默认图片进行识别
			plantsPath = "/usr/share/pixmaps/sunflower.jpg";

		}

		JSONObject obj = ImageUtil.getUtil().plantIdentification(plantsPath);

		Map<String, Object> map2 = obj.toMap();

		return (HashMap<String, Object>) map2;

	}
	
	
	@RequestMapping(value = "/plantsChange", method = RequestMethod.POST)
	public String userAdd(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
		// 下面需要进行对文件进行处理
		String path = null;
		try {
			path = MyFileUtils.uploadFile(request, file);
			System.out.println(path);
			// 将路径存储到域中，用于前端显示，同时解析该图片
			request.getSession().setAttribute("plantImagePath", path);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "plants";
	}

}