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

	/*
	 * @RequestMapping("/userLogin") public String userLogin(String username, String
	 * password, HttpServletRequest request) {
	 * 
	 * // 判断用户名是否为空 if ((username != null && password != null) &&
	 * (!username.equals("") && !password.equals(""))) { // 查询用户是否存在 User user =
	 * userService.userLogin(username, password); // 判断user是否为空 if (user == null) {
	 * return "login"; } else { // 查看session中是否已经存在该用户 // 获得session HttpSession
	 * session = request.getSession(); User userSession = (User)
	 * session.getAttribute("user"); // 若session中没有用户信息，则放入该用户对象 if (userSession ==
	 * null) { session.setAttribute("user", user); } //
	 * System.out.println(request.getSession().getAttribute("user")); // 返回成功标识
	 * return "index"; } }
	 * 
	 * return "login"; }
	 */

}