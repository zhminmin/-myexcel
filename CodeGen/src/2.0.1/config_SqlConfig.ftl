<#assign tableInfos=tableInfo>
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration PUBLIC "-//mybatis.org//DTD Config 3.0//EN" "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
      <setting name="jdbcTypeForNull" value="NULL" />
       <!-- NO_LOGGING  --><setting name="logImpl" value="STDOUT_LOGGING" />
    </settings>
    <!-- 模块需要设置别名统一在此处配置 -->
    <typeAliases>
    	<!--
    	<#list tableInfos as tableInfo>
		<typeAlias alias="${tableInfo.classname}" type="${modelpackage_name}.${tableInfo.className}" />
		</#list>
		-->
		<package name="${modelpackage_name }"/>
    </typeAliases>
</configuration>