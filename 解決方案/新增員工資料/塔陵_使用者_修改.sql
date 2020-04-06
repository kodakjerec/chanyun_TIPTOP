/* 修改姓名 */
declare @emp_id varchar(10) = '110101',	/*員工代號*/
		@emp_name nvarchar(10) = '王大同', /*姓名*/
		@whoAreYou varchar(10) = 'SYS' /*異動人員*/
update emp_data set emp_name=@emp_name,nick_name=@emp_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update user_data set [user_name]=@emp_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update cust_data set cust_name=@emp_name,update_time=GETDATE(),update_user=@whoAreYou where cust_id = (select cust_id from emp_data where emp_id=@emp_id)

/* 修改組織 */
declare @emp_id varchar(10) = '110101',	/*員工代號*/
		@org_id varchar(10) = 'A6800', /*組織*/
		@whoAreYou varchar(10) = 'SYS' /*異動人員*/
update emp_comp set org_id=@org_id,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update emp_data set org_id=@org_id,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id

/* 修改職稱 */
declare @emp_id varchar(10) = '110101',	/*員工代號*/
		@prof_name nvarchar(20) = '副理', /*職稱*/
		@whoAreYou varchar(10) = 'SYS' /*異動人員*/
update emp_comp set prof_name=@prof_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update emp_data set prof_name=@prof_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id

/* 修改成離職 */
declare @emp_id varchar(10) = '110101'	/*員工代號*/
update emp_data set [state]=2 where emp_id=@emp_id
update user_data set [state]=2 where emp_id=@emp_id
update cust_data set [state]=2 where cust_id = (select cust_id from emp_data where emp_id=@emp_id)