<#assign tableInfos=tableInfo>
-- ***** 注意一定要指明父菜单编码 省得错乱
set @varmenuPid = '';
set @varmenuPCode = 'sys_common';
SELECT MENU_ID into @varmenuPid FROM T_BASE_MENU WHERE MENU_CODE = @varmenuPCode;

<#list tableInfos as tableInfo>
-- ******* ${tableInfo.tableComment } - ${tableInfo.classname}  begin ----
-- 菜单
set @varmenuId = uuid();
INSERT INTO T_BASE_MENU ( MENU_ID,MENU_NAME, URL, MENU_ORDER, STATUS, MENU_TYPE, MENU_ICON, CREATOR_ID, CREATE_TIME, MENU_CODE, PARENT_ID, DISPLAY_FLAG,
	 HIERARCHY, UPDATE_TIME, ORG )
VALUES( @varmenuId, '${tableInfo.tableComment }', '/bg/${tableInfo.classname}.html?method=index', 1, '1', 0 , '', '100000', now() , '${tableInfo.classname}',
	@varmenuPid, 1, NULL, now() , 10 );

set @varuuid = uuid();
INSERT INTO t_base_mb_auth ( ID, fd_url, fd_main_id, fd_type, fd_create_time, fd_name )
VALUES (@varuuid, '/bg/${tableInfo.classname}.html?method=load', @varmenuId, '01', now(), '列表数据');

-- 顶部按钮
set @varmenuBtnId = uuid();
INSERT INTO T_BASE_MENU_BUTTON ( B_ID, B_NAME, B_CODE, ORDER_NUM, MENU_ID, TYPE, F_NAME, B_CLASS, STATUS, B_URL )
VALUES(@varmenuBtnId, '新增', '${tableInfo.classname}_add', 1, @varmenuId, 1, '${tableInfo.classname}_add', 'btn-success', 1, 
'/bg/${tableInfo.classname}.html?method=add');

set @varuuid = uuid();
INSERT INTO t_base_mb_auth ( ID, fd_url, fd_main_id, fd_type, fd_create_time, fd_name )
VALUES (@varuuid, '/bg/${tableInfo.classname}.html?method=saveAdd', @varmenuBtnId, '02', now(), '保存');

set @varmenuBtnId = uuid();
INSERT INTO T_BASE_MENU_BUTTON ( B_ID, B_NAME, B_CODE, ORDER_NUM, MENU_ID, TYPE, F_NAME, B_CLASS, STATUS, B_URL )
VALUES(@varmenuBtnId, '删除', '${tableInfo.classname}_batchDel', 2, @varmenuId, 1, '${tableInfo.classname}_batchDel', 'btn-success', 1, 
'/bg/${tableInfo.classname}.html?method=batchDel');

-- 列表按钮
set @varmenuBtnId = uuid();
INSERT INTO T_BASE_MENU_BUTTON ( B_ID, B_NAME, B_CODE, ORDER_NUM, MENU_ID, TYPE, F_NAME, B_CLASS, STATUS, B_URL )
VALUES(@varmenuBtnId, '编辑', '${tableInfo.classname}_edit', 1, @varmenuId, 2, '${tableInfo.classname}_edit', 'fa-edit blue', 1, 
'/bg/${tableInfo.classname}.html?method=edit');

set @varuuid = uuid();
INSERT INTO t_base_mb_auth ( ID, fd_url, fd_main_id, fd_type, fd_create_time, fd_name )
VALUES (@varuuid, '/bg/${tableInfo.classname}.html?method=update', @varmenuBtnId, '02', now(), '更新');

set @varmenuBtnId = uuid();
INSERT INTO T_BASE_MENU_BUTTON ( B_ID, B_NAME, B_CODE, ORDER_NUM, MENU_ID, TYPE, F_NAME, B_CLASS, STATUS, B_URL )
VALUES(@varmenuBtnId, '删除', '${tableInfo.classname}_del', 2, @varmenuId, 2, '${tableInfo.classname}_del', 'fa-trash-o red', 1, 
'/bg/${tableInfo.classname}.html?method=delete');

-- ******* ${tableInfo.tableComment } - ${tableInfo.classname}  end ----
</#list>
		
commit;