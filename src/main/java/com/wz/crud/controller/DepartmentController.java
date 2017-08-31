package com.wz.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.wz.crud.bean.Department;
import com.wz.crud.bean.Message;
import com.wz.crud.service.DepartmentService;

/**
 * 处理所有与部门有关的请求
 * @author wz
 *
 */
@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	@RequestMapping("/depts")
	@ResponseBody
	public Message getDepts(){
		List<Department> list= departmentService.getDepts();
		return Message.success().add("depts", list);
	}
}

