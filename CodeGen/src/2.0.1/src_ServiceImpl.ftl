package ${servicepackage_name }.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bw.core.dao.IBaseDao;
import com.bw.core.service.impl.BaseServiceImpl;
import ${daopackage_name }.impl.${tableInfo.className }Dao;
import ${modelpackage_name }.${tableInfo.className };
import ${servicepackage_name }.${tableInfo.className }Service;

/**
 * ${tableInfo.tableComment} Service实现
 * 
 * @author  ${author! }
 * ${date! }
 */
@Service("${tableInfo.classname }Service")
public class ${tableInfo.className }ServiceImpl extends BaseServiceImpl<${tableInfo.className}> implements ${tableInfo.className }Service
{

    @Autowired
    private ${tableInfo.className }Dao ${tableInfo.classname }Dao;

	@Override
	protected IBaseDao<${tableInfo.className}> getBaseDao()
	{
		return ${tableInfo.classname }Dao;
	}
}