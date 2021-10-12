package ${controllerpackage_name };

import com.bw.core.controller.ExtendController;
import com.bw.core.txn.IBaseAppService;
import ${modelpackage_name }.${tableInfo.className };
import ${txnpackage_name }.${tableInfo.className }AppService;

/**
 * ${tableInfo.tableComment} Controller
 * 
 * @author  ${author! }
 * ${date! }
 */
public class ${tableInfo.className }Controller extends ExtendController<${tableInfo.className}>
{
    private ${tableInfo.className }AppService ${tableInfo.classname }AppService;
    
    @Override
	protected IBaseAppService<${tableInfo.className}> getBaseAppService()
	{
		return ${tableInfo.classname }AppService;
	}

    public void set${tableInfo.className }AppService(${tableInfo.className }AppService ${tableInfo.classname }AppService)
    {
        this.${tableInfo.classname }AppService = ${tableInfo.classname }AppService;
    }

}