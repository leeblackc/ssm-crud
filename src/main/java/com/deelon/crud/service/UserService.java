package com.deelon.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.crud.dao.UserMapper;
import com.deelon.crud.model.User;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
	public List<User> getAll() {
		// TODO Auto-generated method stub
		return userMapper.selectByExample(null);
	}
	
}
