package com.ai.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ai.utils.FaceUtil;
import com.ai.utils.MyFileUtils;

@Controller
@RequestMapping("/face")
public class FaceController {

	@RequestMapping(value = "/faceIdent")
	@ResponseBody
	public Map<String, Object> faceIdent(String facePath, HttpServletRequest request) {

		//System.out.println(facePath);

		String imagePath = (String) request.getSession().getAttribute("imagePath");

		if (imagePath != null) {
			MyFileUtils utils = new MyFileUtils();
			facePath = utils.des + imagePath;
		}

		// 由于post提交方式存在问题。先从session中获取图片路径

		// 根据地址找到对应的图片，进行图片识别
		if (imagePath == null) {
			// 加载本机默认图片进行识别
			facePath = "/usr/share/pixmaps/girlface.jpg";
		}

		//System.out.println(facePath);

		return FaceUtil.getUtil().check(facePath);
	}

	@RequestMapping(value = "/faceChange", method = RequestMethod.POST)
	public String userAdd(HttpServletRequest request, @RequestParam("file") MultipartFile file) {
		// 下面需要进行对文件进行处理
		String path = null;
		try {
			path = MyFileUtils.uploadFile(request, file);
			System.out.println(path);
			// 将路径存储到域中，用于前端显示，同时解析该图片
			request.getSession().setAttribute("imagePath", path);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return "people";
	}
}