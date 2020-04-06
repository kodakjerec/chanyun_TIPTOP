/*
操作說明:
1. 輸入: 分公司, 員工代號, 姓名, 組織, 職稱, 身分證, 性別
2. 建立成功後, 用admin帳號進入SYS01:使用者帳號維護, 幫使用者重置密碼為使用者帳號

參考資料:
//查詢分公司
select * from comp_data

//查詢組織
select * from org_data
*/
declare @whoAreYou varchar(10) = 'SYS' /*異動人員*/
declare @comp_id varchar(1) = '1',	/*分公司*/
		@emp_id varchar(10) = 'A200204',	/*員工代號*/
		@emp_name nvarchar(10) = '賴建成', /*姓名*/
		@org_id varchar(10) = 'A6110',	/*組織 A6800=陵管處*/
		@prof_name nvarchar(20) = '協理', /*職稱*/
		@personId varchar(10) = 'Q120153659', /*身分證*/
		@sex_type tinyint = 1 /*性別 1=男 2=女*/
		
declare @max_cust_id varchar(20) = '', /* 員工編號, 自動取得*/
		@max_cust_id_prefix varchar(3) = 'C'+substring(convert(varchar,GETDATE(),111),1,2), /* 搜尋序號最大直, 公式: C+yy */
		@pwd varchar(32) = 'fb04be7df6af108c922cc1e48c1ce14e'
		
/*1.取得目前最新號碼*/
set @max_cust_id = ( select MAX(cust_id) from cust_data where cust_id like @max_cust_id_prefix+'%')
/*2.最新號碼+1*/
set @max_cust_id = ISNULL(RIGHT(@max_cust_id,5),0)+1	
/*3.轉換回最新員工號碼*/
set @max_cust_id = @max_cust_id_prefix+REPLICATE('0',5-len(@max_cust_id))+@max_cust_id
--select @max_cust_id as '最新員工號碼'

/* 檢查是否已經新增過 */
IF ((select emp_id from emp_comp where emp_id=@emp_id) is not NULL)
BEGIN
	select '已新增過此員工代號:'+@emp_id as '錯誤'
	return
END

Insert into emp_comp 
values (@emp_id, @comp_id, @org_id, @prof_name, GETDATE(), @whoAreYou)

Insert into emp_data 
values (@emp_id, 1, @emp_name, NULL, @comp_id, '1,2', @org_id, 'A', @emp_name, NULL, NULL, NULL, NULL, @max_cust_id, NULL, NULL, @prof_name, @personId, 0,
replace(convert(char(10),GETDATE(),111),'/','-'), NULL,	@sex_type, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), @whoAreYou, GETDATE(), @whoAreYou)				

Insert into user_data
values (@emp_id, 1, 'AU01', @emp_id, @emp_name, @pwd, NULL, 0, NULL, NULL, NULL, GETDATE(), @whoAreYou, GETDATE(), @whoAreYou)

Insert into cust_data
values (@max_cust_id,1,1,@max_cust_id,'C',@emp_name,0,1,'A',NULL,@personId,NULL,0,@sex_type,NULL,NULL,NULL,NULL,NULL,NULL,'0',
NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,replace(convert(char(10),GETDATE(),111),'/','-'),NULL,NULL,NULL,NULL,NULL,'001',NULL,NULL,NULL,NULL,
'TW',NULL,GETDATE(),@whoAreYou,GETDATE(),@whoAreYou,NULL,0,NULL,NULL,NULL)

select '新增完畢, 請用admin帳號進入SYS01:使用者帳號維護, 幫使用者重置密碼為使用者帳號' as '注意,下一步!!'

/* 
--刪除員工帳號使用

declare @emp_id varchar(10)='110101'

delete
from emp_comp
where emp_id=@emp_id

delete
select *
from emp_data
where emp_id=@emp_id

delete
from user_data
where emp_id=@emp_id

delete
from cust_data
where cust_id = (select cust_id from emp_data where emp_id=@emp_id)
*/

/*
-- 查詢員工資料
declare @emp_id varchar(10)='110101'

select *
from emp_comp
where emp_id=@emp_id

select *
from emp_data
where emp_id=@emp_id

select *
from user_data
where emp_id=@emp_id

select *
from cust_data
where cust_id = (select cust_id from emp_data where emp_id=@emp_id)

*/