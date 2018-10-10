package com.wz.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.wz.crud.bean.Department;
import com.wz.crud.bean.Employee;
import com.wz.crud.dao.DepartmentMapper;
import com.wz.crud.dao.EmployeeMapper;

/**
 * @author wz
 *spring的项目可以使用Spring的单元测试，可以帮助自动注入需要的组件
 *1.导入SpringTest的依赖的包
 *2.使用@ContextConfiguration注解指定Spring配置文件的路径
 *3.使用@RunWith注解指定单元测试所用的测试为Spring的单元测试
 *4.使用@Autowired注解制定须要使用的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	@Test
	public void main() {
		/*
		 * 传统的测试方法：
		 * 1.创建Spring容器 
		 * ApplicationContext ioc=new ClassPathXmlApplicationContext("applicationContext.xml");
		 * 2.从容器获得mapper
		 * ioc.getBean(Department.class);
		 */
		//1.部门信息插入测试
		
		//departmentMapper.insertSelective(new Department(null,"RR部"));
		
		//2.测试员工信息插入
		//employeeMapper.insertSelective(new Employee(null,"zhao","男","simple@163.com",2));
		//3.根据员工主键信息删除测试
		employeeMapper.deleteByPrimaryKey(new Integer(23));
		//修改员工信息
		//employeeMapper.updateByPrimaryKey(record);
		//3.批量插入
		
		EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<100;i++){
			String uid=UUID.randomUUID().toString().substring(0,6)+i;
			mapper.insertSelective(new Employee(null,uid,"男",uid+"@163.com",1));
		}
		System.out.println("批量操作完成！");
	}
}
