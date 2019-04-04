package com.ai.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ai.utils.MyFileUtils;
import com.ai.utils.QualityUtil;

@Controller
@RequestMapping("/quality")
public class QualityEnhanceController {

	@RequestMapping(value = "/qualityEnhance")
	@ResponseBody
	public String qualityEnhance(String imagePath,HttpServletRequest request) {
		
		// 根据地址找到对应的图片，进行图片识别
		String Path = (String) request.getSession().getAttribute("qualityImagePath");

		if (Path != null) {
			MyFileUtils utils = new MyFileUtils();
			imagePath = utils.des + Path;
		}

		if (Path == null) {
			// 加载本机默认图片进行识别
			imagePath = "/usr/share/pixmaps/boy.jpg.png";
		}

		return QualityUtil.getUtil().imageQualityEnhance(imagePath);
	}
	
	
	
	
	@RequestMapping(value = "/qualityChange", method = RequestMethod.POST)
	public String userAdd(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
		// 下面需要进行对文件进行处理
		String path = null;
		try {
			path = MyFileUtils.uploadFile(request, file);
			System.out.println(path);
			// 将路径存储到域中，用于前端显示，同时解析该图片
			request.getSession().setAttribute("qualityImagePath", path);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "qualityEnhance";
	}

}
