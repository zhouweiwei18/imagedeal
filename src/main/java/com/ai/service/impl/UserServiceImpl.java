package com.ai.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.dao.UserMapper;
import com.ai.model.DataResp;
import com.ai.model.User;
import com.ai.model.UserExample;
import com.ai.service.UserService;
import com.ai.utils.FaceHelper;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userDao;

	@Override
	public void addUserNoFace(User user) {

		userDao.insert(user);
	}

	@Override
	public int login(User user, HttpServletRequest request) {
		UserExample example = new UserExample();
		example.createCriteria().andUsernameEqualTo(user.getUsername());
		example.createCriteria().andPasswordEqualTo(user.getPassword());
		List<User> list = userDao.selectByExample(example);
		if (list != null&&list.size()>0) {
			//看密码是否匹配
			if(user.getPassword().equals(list.get(0).getPassword())) {
				
				// 查看session中是否已经存在该用户
				// 获得session
				HttpSession session = request.getSession();
				User userSession = (User) session.getAttribute("user");
				// 若session中没有用户信息，则放入该用户对象
				if (userSession == null) {
					session.setAttribute("user", list.get(0));
				}
				return 1;
			}
  
			//密码不对
			return 0;
		}
		
		//不存在该用户
		return 0;

	}

	public DataResp login(User user, boolean passwordLogin, HttpServletRequest request) {
		DataResp dataResp = new DataResp();
		// 判断是否是刷脸登陆
		if (!passwordLogin) {
			// 首先要对提交的人脸做一下识别，看是否是符合用来作人脸对比的图像
			dataResp = FaceHelper.faceDetect(user.getFacecode());
			// 如果成功的话，就用这张人脸和注册时录入的人脸进行比对
			if (dataResp.getCode() == DataResp.Code.SUCCESS) {
				// 查询登陆用户
				UserExample example = new UserExample();
				example.createCriteria().andUsernameEqualTo(user.getUsername());
				List<User> list = userDao.selectByExample(example);
				User compareUser = new User();
				if (list != null) {
					compareUser = list.get(0);
				}
				if (user != null) {
					// 进行对比
					dataResp = FaceHelper.faceCompare(user.getFacecode(), compareUser.getFacecode());
					if (dataResp.getCode() == DataResp.Code.SUCCESS) {

						// 查看session中是否已经存在该用户
						// 获得session
						HttpSession session = request.getSession();
						User userSession = (User) session.getAttribute("user");
						// 若session中没有用户信息，则放入该用户对象
						if (userSession == null) {
							session.setAttribute("user", user);
						}

						// 把用户返回前端，用于后续操作
						dataResp.setData(compareUser);
					}
				} else {
					dataResp.setCode(DataResp.Code.ERROR);
					dataResp.setMessage("该用户不存在");
				}

			}
			// 否则，识别失败的话，提示，重新刷脸

		} else {
			// 密码登陆
			UserExample example = new UserExample();
			example.createCriteria().andUsernameEqualTo(user.getUsername());
			example.createCriteria().andPasswordEqualTo(user.getPassword());
			user = (User) userDao.selectByExample(example);
			if (user != null) {
				dataResp.setMessage("登陆成功");

				// 查看session中是否已经存在该用户
				// 获得session
				HttpSession session = request.getSession();
				User userSession = (User) session.getAttribute("user");
				// 若session中没有用户信息，则放入该用户对象
				if (userSession == null) {
					session.setAttribute("user", user);
				}

				dataResp.setCode(DataResp.Code.SUCCESS);
				dataResp.setData(user);
			} else {
				dataResp.setCode(DataResp.Code.ERROR);
				dataResp.setMessage("登陆失败，用户名或密码错误");
			}
		}

		return dataResp;
	}

	public DataResp addUser(User user) {
		// 识别人脸
		DataResp dataResp = FaceHelper.faceDetect(user.getFacecode());

		if (dataResp.getCode() == DataResp.Code.SUCCESS) {
			// 把 base64 存到数据库中，以便以后作对比使用
			userDao.insert(user);
		}

		return dataResp;
	}

	public List<User> getAllUser(UserExample example) {

		return userDao.selectByExample(example);

	}

	public void deleteUserById(Integer integer) {

		userDao.deleteByPrimaryKey(integer);

	}

	/**
	 * 返回分页的List集合
	 */

	public List<User> selectByList(UserExample example) {

		return this.userDao.selectByExample(example);

	}

	public User selectUserById(Integer id) {

		return userDao.selectByPrimaryKey(id);
	}

	public void updateUserById(User user) {

		userDao.updateByPrimaryKey(user);

	}

	public List<User> selectUserByName(String username) {

		UserExample example = new UserExample();

		example.createCriteria().andUsernameEqualTo(username);

		return userDao.selectByExample(example);

	}

	/*
	 * public User userLogin(String username, String password) {
	 * 
	 * // 创建查询对象 UserExample userExample = new UserExample();
	 * 
	 * userExample.createCriteria().andUsernameEqualTo(username);
	 * 
	 * List<User> list = userDao.selectByExample(userExample);
	 * 
	 * // 判断是否有该用户的姓名 if (list.size() != 0) {
	 * 
	 * // 遍历用户集合 for (User user : list) { if (user.getPassword().equals(password)) {
	 * return user; } }
	 * 
	 * // 说明密码错误 return null; }
	 * 
	 * // 说明用户名不存在 return null; }
	 */

}
