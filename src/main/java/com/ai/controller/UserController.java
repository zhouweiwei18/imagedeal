package com.ai.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.model.DataResp;
import com.ai.model.User;
import com.ai.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@RequestMapping("/userReg")
	public String userReg(User user) {

		List<User> users = userService.selectUserByName(user.getUsername());

		if (users != null && users.size() > 0) {

			return "reg";
		} else {
			// 添加用户
			userService.addUserNoFace(user);

			return "login";
		}

	}

	/**
	 * 用户注册功能
	 */
	@RequestMapping("/userRegister")
	@ResponseBody
	public DataResp userRegister(User user) {

		// 首先查询用户名是否已经存在
		if (user != null) {

			List<User> users = userService.selectUserByName(user.getUsername());

			if (users != null && users.size() > 0) {
				User u = users.get(0);
				if (u != null) {
					return new DataResp();
				}
			}
			// 数据库不存当前注册用,允许注册

			return userService.addUser(user);
		}

		return new DataResp();
	}

	@RequestMapping("/userLogin")
	@ResponseBody
	public DataResp login(User user, boolean passwordLogin, HttpServletRequest request) {
		return userService.login(user, passwordLogin, request);
	}

	@RequestMapping("/userLoginNoFace")
	public String login(User user, HttpServletRequest request) {

		int i = userService.login(user, request);

		if (i != 1) {

			return "login";
		}

		return "index";
	}
}