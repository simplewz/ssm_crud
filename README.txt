项目名称：部门员工信息管理系统
一.项目简介：利用SpringMVC+Spring+MyBatis框架构建一个网站，通过网站可以实现对部门员工信息进行CRUD操作，实现对部门员工信息的管理。
CRUD的含义:
C:create          创建
R:Retrieve        查询
U:Update          更新
D:Delete          删除

二.系统涉及的功能点
1.数据分页
2.数据校验（前端校验/后端校验）
3.ajax请求
4.Rest风格的URI:使用HTTP协议请求方式的动词来表示对资源的操作。
  GET:查询操作
  POST:新增操作
  PUT:修改操作
  DELETE:删除操作
 
三.技术要点
1.基础框架：SpringMVC+Spring+MyBatis
2.数据库：mysql
3.前端框架：bootstrap+jQuery
4.项目依赖管理：Maven
5.分页插件pagehelper的使用
6.逆向工程：MyBatis Generater

四.创建Maven项目
创建简单的Maven项目，项目的目录结构如下所示：(项目名称为ssm_crud)
ssm_crud
|——src/main/java          存放编写业务有关的代码
|——src/main/resources     存放配置文件的目录
|——src/test/java          测试java代码
|——src/test/resources     测试配置资源文件
JRE

