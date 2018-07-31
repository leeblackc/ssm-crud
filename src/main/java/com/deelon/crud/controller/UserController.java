package com.deelon.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.deelon.crud.bean.Msg;
import com.deelon.crud.model.User;
import com.deelon.crud.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

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
}
