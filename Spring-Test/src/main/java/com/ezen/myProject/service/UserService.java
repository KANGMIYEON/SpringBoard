package com.ezen.myProject.service;

import com.ezen.myProject.domain.UserVO;

public interface UserService {

	boolean signUp(UserVO user);

	UserVO isUser(String id, String pw);



}
