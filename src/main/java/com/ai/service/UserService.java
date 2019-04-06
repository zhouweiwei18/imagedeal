package com.ai.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.ai.model.DataResp;
import com.ai.model.User;
import com.ai.model.UserExample;

public interface UserService {

	DataResp addUser(User user);
	
	void addUserNoFace(User user);

	List<User> getAllUser(UserExample example);

	void deleteUserById(Integer integer);

	List<User> selectByList(UserExample example);

	User selectUserById(Integer id);

	void updateUserById(User user);

	// 根据用户名查询用户
	List<User> selectUserByName(String username);

	// 用户登录
	DataResp login(User user, boolean password,HttpServletRequest request);
	
	int login(User user,HttpServletRequest request);

}
