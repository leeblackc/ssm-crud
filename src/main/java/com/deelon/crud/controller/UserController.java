package com.deelon.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.deelon.crud.bean.Msg;
import com.deelon.crud.model.User;
import com.deelon.crud.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import guigu.bean.Employee;

@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	
	
	@ResponseBody
	@RequestMapping("/users")
	public Msg getUsers(@RequestParam(value="pn",defaultValue="1") int pn) {
		PageHelper.startPage(pn, 10);
		// startPage后面紧跟的这个查询就是一个分页查询
		List<User> emps = userService.getAll();
		// 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了。
		// 封装了详细的分页信息,包括有我们查询出来的数据，传入连续显示的页数
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
		
	}
	
	/**
	 * 检查账户是否可用
	 * @param account
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkaccount")
	public Msg checkuser(@RequestParam("account")String account){
		
		
		//数据库用户名重复校验
		boolean b = userService.checkUser(account);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail();
		}
	}
	
	/**
	 * 员工保存
	 * 
	 * 
	 * @return
	 */
	@RequestMapping(value="/user",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(User user){
		
			userService.saveUser(user);
			return Msg.success();
		}
	
	@RequestMapping(value="/user/{uid}",method=RequestMethod.DELETE)
	@ResponseBody	
	public Msg deleteOne(@PathVariable("uid") String uid) {
		Integer id = Integer.parseInt(uid);
		userService.deleteUser(id);
		return Msg.success();
		
	}
	
	
	
	}
	
	

