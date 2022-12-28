package com.ezen.myProject.repository;

import javax.servlet.http.HttpServletRequest;

import com.ezen.myProject.domain.UserVO;

public interface UserDAO {

	UserVO getUser(String id);

	int insertUser(UserVO user);



	

}
