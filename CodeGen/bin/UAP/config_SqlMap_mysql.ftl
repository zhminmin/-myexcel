<#assign tableInfo=tableInfo>
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="nameSpace_${tableInfo.className}">
	<sql id="PAGING_START">
       	<![CDATA[
       	
       	]]>
	</sql>

	<sql id="PAGING_END">
       	<![CDATA[
       	  LIMIT ${r'#{beginNum}'},${r'#{pageSize}'}
       	]]>
	</sql>
	
	<sql id="ORDERBY">
		<choose>
 			<when test="sortName!=null and sortName!=''">
	 			ORDER BY ${r'${sortName} ${sortOrder}' }, t.${tableInfo.primaryKey.columnName} desc
	 		</when>
		 	<otherwise>
		 		<!-- ORDER BY t.x DESC|ASC, t.${tableInfo.primaryKey.columnName} desc -->
		 	</otherwise>
	 	</choose>
	</sql>
	
	<sql id="SELECT_CONTENT">
    	<![CDATA[
		SELECT 
		<#list tableInfo.columns as column>
			t.${column.columnName} AS ${column.attrname}<#if column_has_next>,</#if>
		</#list>
		FROM ${tableInfo.tableName} t
        ]]>
	</sql>
	
	<sql id="SELECT_PARAMETER">
	    <where>
	    	<if test="qcStr != null and qcStr !=''">
			${r'${qcStr}'}
	   		</if>
	    	<#list tableInfo.columns as column>
	    	<#if column.attrType == 'Date'>
	    	<if test="${column.attrname}Begin != null and ${column.attrname}Begin != ''">
		    	<![CDATA[ and date_format(t.${column.columnName },'%Y/%m/%d') >= ${r'#{'}${column.attrname }Begin${r'}'} ]]>
		    </if>
		    <if test="${column.attrname}End != null and ${column.attrname}End != ''">
		  		<![CDATA[ and date_format(t.${column.columnName },'%Y/%m/%d') <= ${r'#{'}${column.attrname}End${r'}'} ]]>
		    </if>
	    	<#elseif column.attrname != tableInfo.primaryKey.attrname>
	    	<if test="${column.attrname} != null<#if column.attrType == 'String'> and ${column.attrname} != ''</#if>">
			and t.${column.columnName} = ${r'#{'}${column.attrname}${r'}'}
			</if>
			</#if>
			</#list>
		</where>
	</sql>
	
	<select id="selectByPrimaryKey" resultType="${tableInfo.classname}" parameterType="java.lang.String">
		<include refid="SELECT_CONTENT"/>
		where t.${tableInfo.primaryKey.columnName} = ${r'#{value}'}
	</select>
	
	<select id="selectByPrimaryKeys" resultType="${tableInfo.classname}" parameterType="java.util.List">
    	<include refid="SELECT_CONTENT"/>
    	where t.${tableInfo.primaryKey.columnName} in
     	<foreach collection="list" index="index" item="item" open="(" separator="," close=")">  
	  		${r'#{item}'}  
	    </foreach>
  	</select>
	 
	<insert id="insert" parameterType="${tableInfo.classname}"> 
		INSERT INTO ${tableInfo.tableName } (<#list tableInfo.columns as column>${column.columnName }<#if column_has_next>, </#if></#list>)
		VALUES(<#list tableInfo.columns as column>${r'#{'}${column.attrname }<#if column.attrType == 'Date'>, jdbcType=TIMESTAMP</#if>${r'}'}<#if column_has_next>, </#if></#list>)
    </insert>
	
	<delete id="deleteByPrimaryKey" parameterType="java.lang.String">
		delete from ${tableInfo.tableName} where ${tableInfo.primaryKey.columnName} = ${r'#{value}'}
	</delete>
	
	<delete id="deleteByPrimaryKeys" parameterType="java.util.List">
		delete from ${tableInfo.tableName} where ${tableInfo.primaryKey.columnName} in
		 <foreach collection="list" index="index" item="item" open="(" separator="," close=")">  
	        ${r'#{item}'}  
	     </foreach>
	</delete>
	
	<delete id="deleteByExample" parameterType="${tableInfo.classname}">
		delete t from ${tableInfo.tableName} t
		<include refid="SELECT_PARAMETER" />
	</delete>
	
	<update id="updateByPrimaryKeySelective"  parameterType="${tableInfo.classname}">
    	update ${tableInfo.tableName}
			<set>
		  	<#list tableInfo.columns as column>
		  	<#if column.attrname != tableInfo.primaryKey.attrname>
		  	<if test="${column.attrname } != null">${column.columnName} = ${r'#{'}${column.attrname }${r'}'},</if>
          	</#if>
		  	</#list>
           </set>
		 where ${tableInfo.primaryKey.columnName } = ${r'#{'}${tableInfo.primaryKey.attrname }${r'}'}
	</update>
	
	<select id="selectByExample" resultType="${tableInfo.classname}" parameterType="${tableInfo.classname}">
		<include refid="SELECT_CONTENT"/>
		<include refid="SELECT_PARAMETER"/>
		<include refid="ORDERBY"/>
	</select>

	<select id="countByExample" resultType="java.lang.Integer" parameterType="${tableInfo.classname}">
    	select count(*) from ${tableInfo.tableName} t
		<include refid="SELECT_PARAMETER"/>
    </select>
  
    <select id="selectByPage" resultType="${tableInfo.classname}" parameterType="${tableInfo.classname}">
		<include refid="PAGING_START"/>
		<include refid="SELECT_CONTENT"/>
		<include refid="SELECT_PARAMETER"/>
		<include refid="ORDERBY"/>
		<include refid="PAGING_END"/>
    </select>
	
</mapper>