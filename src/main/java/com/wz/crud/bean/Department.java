package com.wz.crud.bean;

public class Department {

	private Integer deptId;

    private String deptName;
    
    //不带参数的构造器
    public Department() {
		super();
	}

	//带参数的构造器
    public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName == null ? null : deptName.trim();
    }
}