/* �ק�m�W */
declare @emp_id varchar(10) = '110101',	/*���u�N��*/
		@emp_name nvarchar(10) = '���j�P', /*�m�W*/
		@whoAreYou varchar(10) = 'SYS' /*���ʤH��*/
update emp_data set emp_name=@emp_name,nick_name=@emp_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update user_data set [user_name]=@emp_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update cust_data set cust_name=@emp_name,update_time=GETDATE(),update_user=@whoAreYou where cust_id = (select cust_id from emp_data where emp_id=@emp_id)

/* �ק��´ */
declare @emp_id varchar(10) = '110101',	/*���u�N��*/
		@org_id varchar(10) = 'A6800', /*��´*/
		@whoAreYou varchar(10) = 'SYS' /*���ʤH��*/
update emp_comp set org_id=@org_id,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update emp_data set org_id=@org_id,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id

/* �ק�¾�� */
declare @emp_id varchar(10) = '110101',	/*���u�N��*/
		@prof_name nvarchar(20) = '�Ʋz', /*¾��*/
		@whoAreYou varchar(10) = 'SYS' /*���ʤH��*/
update emp_comp set prof_name=@prof_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id
update emp_data set prof_name=@prof_name,update_time=GETDATE(),update_user=@whoAreYou where emp_id=@emp_id

/* �ק令��¾ */
declare @emp_id varchar(10) = '110101'	/*���u�N��*/
update emp_data set [state]=2 where emp_id=@emp_id
update user_data set [state]=2 where emp_id=@emp_id
update cust_data set [state]=2 where cust_id = (select cust_id from emp_data where emp_id=@emp_id)