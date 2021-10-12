<#assign tableInfos=tableInfo>
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

	<bean id="${modulename }UrlMapping" class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
		<property name="mappings">
			<props>
				<#list tableInfos as tableInfo>
				<prop key="/bg/${tableInfo.classname}.html">${tableInfo.classname}Controller</prop>
				</#list>
			</props>
		</property>
	</bean>
	<#list tableInfos as tableInfo>
	
	<bean id="${tableInfo.classname}Controller" class="${controllerpackage_name}.${tableInfo.className}Controller" parent="baseController">
		<property name="indexView">
			<value>/${module_path }/${tableInfo.classname}/index</value>
		</property>
		<property name="loadView">
			<value>/${module_path }/${tableInfo.classname}/load</value>
		</property>
		<property name="editView">
			<value>/${module_path }/${tableInfo.classname}/edit</value>
		</property>
		<property name="${tableInfo.classname}AppService">
			<ref bean="${tableInfo.classname}AppService" />
		</property>
	</bean>
	</#list>
</beans>