package ${txnpackage_name };

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bw.core.service.IBaseService;
import com.bw.core.txn.BaseAppServiceImpl;
import ${modelpackage_name }.${tableInfo.className };
import ${servicepackage_name }.${tableInfo.className }Service;

/**
 * ${tableInfo.tableComment} AppService实现
 * 
 * @author  ${author! }
 * ${date! }
 */
@Service("${tableInfo.classname }AppService")
public class ${tableInfo.className }AppService extends BaseAppServiceImpl<${tableInfo.className}>
{

    @Autowired
    private ${tableInfo.className }Service ${tableInfo.classname }Service;
    
    @Override
	protected IBaseService<${tableInfo.className}> getBaseService()
	{
		return ${tableInfo.classname }Service;
	}
}