package com.wz.crud.dao;

import com.wz.crud.bean.Employee;
import com.wz.crud.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);
    //增加的方法
    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);
    //增加的方法
    Employee selectByPrimaryKey(Integer empId);
    //增加的方法
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    //增加的方法
    Employee selectByPrimaryKeyWithDept(Integer empId);

    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);
    //增加的方法
    int updateByPrimaryKeySelective(Employee record);
    //增加的方法
    int updateByPrimaryKey(Employee record); 
}