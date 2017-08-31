package com.wz.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wz.crud.bean.Employee;
import com.wz.crud.bean.Message;
import com.wz.crud.service.EmployeeService;

/**
 * 处理员工信息的CRUD请求
 * @author wz
 *
 */
@Controller
public class EmployeeController {
	@Autowired
	private EmployeeService employeeService;
	
	/**
	 * 单个批量二合一的删除方法
	 * 批量删除：1-2-3
	 * 单个删除：1
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Message deleteEmp(@PathVariable("ids")String ids){
		if(ids.contains("-")){
			List<Integer> del_ids=new ArrayList<>();
			String[] str_ids=ids.split("-");
			//组装id集合
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(ids));
			}
			employeeService.deleteBatch(del_ids);
		}else{
			Integer id=Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Message.success();
	}
	/*
	 * 未改造的员工单个删除
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	@ResponseBody
	public Message deleteEmpById(@PathVariable("id")Integer id){
		employeeService.deleteEmp(id);
		return Message.success();
	}
	*/
	
	/**
	 * 
	 * 如果直接发送ajax的put请求
	 * 
	 * 员工信息更新方法
	 * @param employee
	 * @return
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Message saveEmp(Employee employee){
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Message.success();
	}
	
	/**
	 * 根据员工id查询员工信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Message getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeService.getEmp(id);
		return Message.success().add("emp", employee);
	}
	
	/**
	 * 检查用户名是否可用
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkuser")
	public Message checkuser(@RequestParam("empName")String empName){
		//先判断用户名是否合法
		String regx="(^[a-zA_Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regx)){
			return Message.fail().add("va_msg", "用户名可以是6-16位英文字母和数字的组合或者是2-5个汉字组合");
		}
		//数据库用户名重复校验
		boolean b=employeeService.checkUser(empName);
		if(b){
			return Message.success();
		}
		else{
			return Message.fail().add("va_msg", "用户名不可用！");
		}
	}
	
	/**
	 * 查询所有员工信息（分页查询）
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model){
		//getAll()方法不是一个分页查询方法
		//可以通过引入pageHelper插件改造成分页查询方法
		//在查询之前只需要调用PageHelper.startPage(pageNumber,pageSize)方法
		PageHelper.startPage(pn, 15);
		//后面紧跟的查询就是分页查询
		List<Employee> emps=employeeService.getAll();
		//使用pageinfo包装查询的信息，只需要将pageinfo交给页面就行
		PageInfo pageInfo=new PageInfo(emps,5);
		model.addAttribute("pageinfo", pageInfo);
			return "list";
	}
	
	/**
	 * 需要导入jackson包
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Message getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn){
				//getAll()方法不是一个分页查询方法
				//可以通过引入pageHelper插件改造成分页查询方法
				//在查询之前只需要调用PageHelper.startPage(pageNumber,pageSize)方法
				PageHelper.startPage(pn, 15);
				//后面紧跟的查询就是分页查询
				List<Employee> emps=employeeService.getAll();
				//使用pageinfo包装查询的信息，只需要将pageinfo交给页面就行
				PageInfo pageInfo=new PageInfo(emps,5);
				return Message.success().add("pageinfo", pageInfo);
	}
	
	/**
	 * 员工信息保存
	 * 1.支持JSR303校验
	 * 2.需要导入Hibernate-Validator包
	 * @return
	 */
	@ResponseBody
	@RequestMapping(name="/emp",method=RequestMethod.POST)
	public Message saveEmployee(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//检验失败，应该返回失败，在前端模态框中显示校验失败的错误信息
			Map<String,Object> map=new HashMap<String, Object>();
			List<FieldError> errors=result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Message.fail().add("errorFields",map);
		}
		else{
			//校验成功，保存员工信息
			employeeService.saveEmployee(employee);
			return Message.success();
		}
	}
}

