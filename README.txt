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
|——JRE System Library        java运行环境依赖包
|——.settings
|——src
|——main
    |——webapp
        |——images
        |——META-INF
        |——static
        |——WEB-INF
            |——lib
            |——views
            |——web.xml
        |——index.jsp
  |——test
  |——target
  |——pom.xml
  注意：
  1.创建的简单的Maven项目缺少web.xml文件，系统会提示错误，需要手动配置添加，添加该配置文件的的步骤如下
  右键单击项目——>Properties——>Project Facets——>去除勾选的Dynamic web Model——>apply——>再次勾选Dynamic web Model——>Configuration——>在
  Context directory中输入web.xml文件的路径（src/main/webapp）——>apply
  经过上面的配置后会在webapp目录下创建web.xml配置文件。
  2.如果JRE环境有问题，可对Maven安装目录下的Settings.xml文件做如下修改
 	<mirror>  
	  <id>alimaven</id>  
	  <name>aliyun maven</name>  
	  <url>http://maven.aliyun.com/nexus/content/groups/public/</url>  
	  <mirrorOf>central</mirrorOf>          
	</mirror>
  这样设置下载jar包较快
  	<profile>
		<id>jdk18</id>
		<activation>
			<activeByDefault>true</activeByDefault>
			<jdk>1.8</jdk>
		</activation>
		<properties>
			<maven.compiler.source>1.8</maven.compiler.source>
			<maven.compiler.target>1.8</maven.compiler.target>
			<maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
		</properties>
	</profile>
  做如上设置将项目的运行环境设置为jdk1.8
  3.项目中的中文的显示方式可能会出现中文乱码，可以设置项目的编码方式为utf-8,步骤如下：
  右键单击项目——>Properties——>Resource——>修改Text file encoding为utf-8
  4.修改项目的Java版本
   右键单击项目——>Properties——>Project facets——>Java——>1.8
   
  五.引入项目依赖的jar包(引入的jar包请参考pom.xml文件)
  1.spring核心包
  2.springMVC的jar包
  3.MyBatis的jar包
  4.数据库连接池jar包（c3p0）
  5.数据库驱动包
  6.web项目的标配包（jstl包. servlet api jar包.junit 单元测试）
  7.其他jar包
  注意点：
  1.在Maven repository官网引入jar包
  2.注意spring jar包的版本要一致
  3.所有引入的jar包都要放在pom.xml配置文件中的<dependencies></dependencies>之间。
  
  六.引入bootstrap+jQuery前端框架
  1.在bootstrap官网中下载bootstrap,在jQuery官网中下载jQuery
  2.将下载的bootstrap文件和jQuery文件复制到项目中的src/main/wepapp/static目录下
  3.在Jsp页面中引入bootstrap中的js和css和jQuery框架的js文件（引入方式请自行参考）
  
  七.编写SSM框架整合的关键配置文件
  web.xml spring的配置文件applicationContext.xml文件 springMVC的配置文件 MyBatis的配置文件
  1.Web.xml配置文件的编写（详情请参照项目中的web.xml配置文件）
  (1)配置启动Spring的容器，在Web.xml文件中配置启动Spring的容器后，将启动Spring的容器的工作交给服务器来做，这样在后续的每次发出请求时不用每次都启动   一个Spring容器，能加快网站的响应时间，提高性能。
  (2)配置SpringMVC的前端控制器，可以在<init-param></init-param>中配置SpringMVC配置文件的路径。代码片段如下：
  	<init-param>
		<param-name>ContextConfigLocation</param-name>
		<param-value>location</param-value>
	</init-param>
  location位置即SpringMVC的配置文件所在的路径，如果不指定，则需要在web.xml同级目录下有SpringMVC的配置文件，该配置文件的名称为Servlet-name+“- servlet.xml”。比如在Servlet中有<servlet-name>dispatcherServlet<servlet-name>配置片段，则在web.xml同级的目录下需要有一个名为
  dispatcherServlet-servlet.xml的配置文件。
  (3)字符编码过滤器的配置
  需要注意字符编码过滤器应在所有过滤器之前配置，即如果项目字符编码过滤器应该是第一个过滤器。
  (4)配置使用REST风格的URI过滤器。

2.SpringMVC的配置：主要用于控制网站的跳转逻辑的配置(详情请参见项目中的dispatcherServlet-servlet.xml文件)
(1)配置扫描与网站跳转逻辑有关的组件，因为控制器控制网站的跳转逻辑，所以只扫描控制器即可，即只扫描带Controller注解的组件。
(2)配置视图解析器。
(3)两个标准的配置。一是将将SpringMVC不能处理的请求交给服务器处理的配置，二是开启注解配置。

3.Spring的配置文件，Spring的配置文件默认名称是applicationContext.xml。(详情请参见项目中的applicationContext.xml文件)
(1)数据源的配置。因为数据源涉及到数据库的一些私密信息，因此一般采用从属性文件中读取的方式配置。
(2)配置扫描业务逻辑组件，除了Controller组件都扫描。
(3)配置与MyBatis的整合。
(4)事务控制配置。

4.MyBatis的配置文件(参见项目中的applicationContext-mybatis.xml文件)

5.MyBatis-Generator配置文件。使用设个配置文件可以使用MyBatis逆向工程，能够将数据库中的表自动映射需要的Mapper文件。
(1)在pom.xml中引入MyBatis Generator jar包.(引入方式请参见pom.xml文件)
