package com.wz.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.github.pagehelper.PageInfo;
import com.wz.crud.bean.Employee;

/**
 * 使用Spring测试模块提供的测试请求功能，测试crud的正确性
 * @author wz
 *
 */
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	//传入Springmvc的ioc
	@Autowired
	WebApplicationContext context;
	//获取mvc请求，获取到处理结果
	MockMvc mockMvc;
	
	@Before
	public void init(){
		mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception{
		//模拟请求，并拿到返回值
		MvcResult result=mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1"))
				.andReturn();
		//请求成功以后，请求域中会有pageinfo，我们可以取出pageinfo进行验证
		MockHttpServletRequest request=result.getRequest();
		PageInfo pi=(PageInfo)request.getAttribute("pageinfo");
		System.out.println("当前页码："+pi.getPageNum());
		System.out.println("总页码："+pi.getPages());
		System.out.println("总记录数："+pi.getTotal());
		System.out.print("在页面需要连续显示的页码");
		int[] nums=pi.getNavigatepageNums();
		for(int i:nums){
			System.out.print(" "+i);
		}
		System.out.println("");
		//获取员工数据
		List<Employee> list=pi.getList();
		for (Employee employee : list) {
			System.out.println("ID:"+employee.getEmpId()+" "+"name:"+employee.getEmpName());
		}
	}
}
