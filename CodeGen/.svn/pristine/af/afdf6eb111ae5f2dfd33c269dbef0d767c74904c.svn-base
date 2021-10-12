package com.bw.scpw.${module_name}.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bw.scpw.exception.BaseRuntimeException;
import com.bw.scpw.exception.NormalRuntimeException;
import com.bw.scpw.${module_name}.biz.${tableInfo.className}Service;
import com.bw.scpw.${module_name}.model.${tableInfo.className};
import com.bw.scpw.uaphelper.common.Page;
import com.bw.scpw.uaphelper.rest.UapRestUtils;
import com.sgcc.uap.rest.annotation.IdRequestBody;
import com.sgcc.uap.rest.annotation.QueryRequestParam;
import com.sgcc.uap.rest.support.IDRequestObject;
import com.sgcc.uap.rest.support.RequestCondition;
import com.sgcc.uap.rest.support.WrappedResult;

/**
 * ${tableInfo.tableComment} Controller
 * 
 * @author  ${author! }
 * ${date! }
 */
@Controller
@RequestMapping("/${tableInfo.className}")
public class ${tableInfo.className}Controller
{

    private static final Logger LOGGER = LoggerFactory.getLogger(${tableInfo.className}Controller.class);

    @Autowired
    private ${tableInfo.className}Service ${tableInfo.className}Service;

    /**
     * 新增
     * @param info
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public WrappedResult add(@RequestBody ${tableInfo.className} info)
    {
        ${tableInfo.className}Service.add(info);
        return WrappedResult.successWrapedResult("添加成功");
    }

    /**
     * 更新
     * @param info
     * @return
     */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public WrappedResult update(@RequestBody ${tableInfo.className} info)
    {
        ${tableInfo.className}Service.update(info);
        return WrappedResult.successWrapedResult("更新成功");
    }

    /**
     * 删除
     * @param idObject
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public WrappedResult delete(@IdRequestBody IDRequestObject idObject)
    {
        ${tableInfo.className}Service.delete(idObject.getIds());
        return WrappedResult.successWrapedResult("删除成功");
    }

    /**
     * 查询
     * @param params
     * @return
     */
    @RequestMapping("/query")
    @ResponseBody
    public WrappedResult query(@QueryRequestParam("params") RequestCondition params)
    {
        ${tableInfo.className} query = new ${tableInfo.className}();
        UapRestUtils.bindModel(params, query);
        Page<${tableInfo.className}> list = ${tableInfo.className}Service.findAll(query);
        return WrappedResult.successWrapedResult(list);
    }

    /**
     * 查询单条记录
     */
    @RequestMapping("/{id}")
    @ResponseBody
    public WrappedResult query(@PathVariable String id)
    {
        ${tableInfo.className} info = ${tableInfo.className}Service.findById(id);
        return WrappedResult.successWrapedResult(info);
    }
    
    @ExceptionHandler(
    { Exception.class })
    @ResponseBody
    public WrappedResult exceptionHandler(Exception ex, HttpServletRequest request)
    {
        LOGGER.error("{} 请求发生异常", request.getRequestURI(), ex);
        String msg = ex.getMessage();
        if (!(ex instanceof BaseRuntimeException) && !(ex instanceof NormalRuntimeException))
        {
            msg = "操作失败";
        }
        return WrappedResult.failedWrappedResult(msg);
    }
}
