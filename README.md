
1. 휴대폰 인증번호 API 사용시
-> app.properties파일
-> DEV 프로젝트 / Merge/Pull 후에 / src/main/resources/config 만든 후에 위 파일을 넣으면 됩니다.

-----------------------------------------------------xml-------------------------------------------------------

xml 설정시 확인



1\. web.xml



src/main/resources/dataSource-config.xml 작성

&nbsp;	    => web.xml에 등록해야 함 

&nbsp;	    <context-param>

&nbsp;			<param-name>contextConfigLocation</param-name>

&nbsp;			<param-value>

&nbsp;						classpath:/dataSource-config.xml  <!-- 추가해야 작동  -->

&nbsp;			</param-value>

&nbsp;		</context-param>



2\. pom.xml



<!-- Mybatis 설정 시작 -->

&nbsp;		<!-- 컨넥션풀 -->

&nbsp;		<bean id="dataSource" class="org.springframework.jndi.JndiObjectFactoryBean">

&nbsp;			<property name="jndiName" value="java:comp/env/jdbc/jsp\_pj\_ict05" />

&nbsp;			<property name="resourceRef" value="true" />

&nbsp;		</bean>

&nbsp;		

&nbsp;		<!-- Mybatis 파일 위치 지정, 컨넥션풀 -->

&nbsp;		<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">

&nbsp;			<property name="dataSource" ref="dataSource" />

&nbsp;			<property name="mapperLocations" value="classpath:mappers/\*\*/\*.xml" />  

&nbsp;		</bean>

&nbsp;		

&nbsp;		<!-- 생성자 DI이며, sqlSession이 참조변수 -->

&nbsp;		<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">

&nbsp;			<constructor-arg ref="sqlSessionFactory" />

&nbsp;		</bean>

&nbsp;		

&nbsp;		<!-- Mybatis 설정 종료 -->



3\. dataSource-config.xml



<!-- Mybatis 설정 시작 pom.xml에 jar파일 먼저 추가 -->

&nbsp;	<!-- 컨넥션풀 -->

&nbsp;	<bean id="dataSource" class="org.springframework.jndi.JndiObjectFactoryBean">

&nbsp;		<property name="jndiName" value="java:comp/env/jdbc/dc\_shop" />

&nbsp;		<property name="resourceRef" value="true" />

&nbsp;	</bean>

&nbsp;	

&nbsp;	<!-- Mybatis 파일 위치 지정, 컨넥션풀 -->

&nbsp;	<bean id="sqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">

&nbsp;		<property name="dataSource" ref="dataSource" />

&nbsp;		<property name="mapperLocations" value="classpath:mappers/\*\*/\*.xml" />  

&nbsp;	</bean>

&nbsp;	

&nbsp;	<!-- 생성자 DI이며, sqlSession이 참조변수 -->

&nbsp;	<bean id="sqlSession" class="org.mybatis.spring.SqlSessionTemplate">

&nbsp;		<constructor-arg ref="sqlSessionFactory" />

&nbsp;	</bean>

&nbsp;	

&nbsp;	<!-- Mybatis 설정 종료 -->

jdbc 서버 네이밍 확인



4\. (예시파일)customerMapper.xml

맵퍼파일



5\. Servers -> context.xml



<Resource 

&nbsp;      author="Container" 

&nbsp;      driverClassName="oracle.jdbc.driver.OracleDriver" 

&nbsp;      maxActive="8" 

&nbsp;      maxWait="1000" 

&nbsp;      name="jdbc/dc\_shop" 

&nbsp;      password="pet" 

&nbsp;      type="javax.sql.DataSource" 

&nbsp;      url="jdbc:oracle:thin:@localhost:1521/xe" 

&nbsp;      username="dc\_shop"/>

서버주소

------------------------------------------------------------------------------------------------------------------------

=======
## 기술 스택
- Spring Framework 5.1.8
- MyBatis
- Oracle Database
- JSP/Servlet
- jQuery
- CSS3

## 개발 환경
- Java 11
- Eclipse IDE
- Tomcat Server
