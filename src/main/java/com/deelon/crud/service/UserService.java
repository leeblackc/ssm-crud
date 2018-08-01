package com.deelon.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.deelon.crud.dao.UserMapper;
import com.deelon.crud.model.User;
import com.deelon.crud.model.UserExample;
import com.deelon.crud.model.UserExample.Criteria;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
	public List<User> getAll() {
		// TODO Auto-generated method stub
		return userMapper.selectByExample(null);
	}

	public boolean checkUser(String account) {
		// TODO Auto-generated method stub
		UserExample user = new UserExample();
		Criteria criteria =  user.createCriteria();
		criteria.andAccountEqualTo(account);
		long count = userMapper.countByExample(user);
				
		return count==0;
	}

	public void saveUser(User user) {
		// TODO Auto-generated method stub
		userMapper.insertSelective(user);
		
	}

	public void deleteUser(Integer id) {
		// TODO Auto-generated method stub
		userMapper.deleteByPrimaryKey(id);
	}
	
}
