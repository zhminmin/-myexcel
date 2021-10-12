<!-- 本文件仅部署模块独立数据源可能会使用到，其他请忽略
 注意修改bean id，避免重名
 -->
<?xml version="1.0" encoding="UTF-8"?>
<beans 
	xmlns="http://www.springframework.org/schema/beans" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:p="http://www.springframework.org/schema/p" 
	xmlns:context="http://www.springframework.org/schema/context" 
	xmlns:jee="http://www.springframework.org/schema/jee" 
	xmlns:tx="http://www.springframework.org/schema/tx" 
	xmlns:aop="http://www.springframework.org/schema/aop" 
	xsi:schemaLocation="
	    http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
	    http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd
	    http://www.springframework.org/schema/jee http://www.springframework.org/schema/jee/spring-jee.xsd
	    http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd
	    http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop.xsd">
		
	<!-- junittest使用 -->
	<!--
		${r'<bean id="${module_name }DataSource" class="org.apache.commons.dbcp.BasicDataSource"
		 destroy-method="close" p:driverClassName="${db.driver}" p:url="${db.url}"
		 p:username="${db.username}" p:password="${db.password}" 
		 p:maxActive="10" p:maxWait="100" 
		 p:poolPreparedStatements="true" p:defaultAutoCommit="true" />'}
	-->

	<bean id="${modulename }DataSource" class="org.springframework.jndi.JndiObjectFactoryBean"> 
		<property name="jndiName" value="${r'${sys.db.jndiName }'}" />
	</bean> 
	
    <bean id="${modulename }SqlSessionFactory" class="org.mybatis.spring.SqlSessionFactoryBean">
        <property name="dataSource" ref="${modulename }DataSource"></property>
        <property name="configLocation" value="classpath:mybatis/sqlmap/config.xml"></property>
        <!-- 加载mybatis全局配置文件 -->
        <property name="mapperLocations" value="classpath*:mybatis/sqlmap/**/${r'${sys.mybatis.mapdir }'}/*.xml">
		</property>
    </bean>
	
	<bean id="${modulename }SqlsessionTemplate" class="org.mybatis.spring.SqlSessionTemplate">  
        <constructor-arg index="0" ref="sqlSessionFactory" />  
    </bean>  
    
	<bean id="${modulename }BaseDAO" class="com.bw.core.dao.impl.IBaseDaoImpl" abstract="true">
		<property name="sqlSessionTemplate" ref="${modulename }SqlsessionTemplate"></property>
	</bean>
	
	<bean id="${modulename }TransactionManager"
		class="org.springframework.jdbc.datasource.DataSourceTransactionManager"
		p:dataSource-ref="${modulename }DataSource" />
	
	<tx:annotation-driven transaction-manager="${modulename }TransactionManager"/>
</beans>