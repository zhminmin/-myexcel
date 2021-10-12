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

    <context:component-scan base-package="${servicepackage_name}.impl" />
    
</beans>
