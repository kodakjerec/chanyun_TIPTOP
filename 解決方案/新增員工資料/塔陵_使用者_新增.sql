/*
�ާ@����:
1. ��J: �����q, ���u�N��, �m�W, ��´, ¾��, ������, �ʧO
2. �إߦ��\��, ��admin�b���i�JSYS01:�ϥΪ̱b�����@, ���ϥΪ̭��m�K�X���ϥΪ̱b��

�ѦҸ��:
//�d�ߤ����q
select * from comp_data

//�d�߲�´
select * from org_data
*/
declare @whoAreYou varchar(10) = 'SYS' /*���ʤH��*/
declare @comp_id varchar(1) = '1',	/*�����q*/
		@emp_id varchar(10) = 'A200204',	/*���u�N��*/
		@emp_name nvarchar(10) = '��ئ�', /*�m�W*/
		@org_id varchar(10) = 'A6110',	/*��´ A6800=���޳B*/
		@prof_name nvarchar(20) = '��z', /*¾��*/
		@personId varchar(10) = 'Q120153659', /*������*/
		@sex_type tinyint = 1 /*�ʧO 1=�k 2=�k*/
		
declare @max_cust_id varchar(20) = '', /* ���u�s��, �۰ʨ��o*/
		@max_cust_id_prefix varchar(3) = 'C'+substring(convert(varchar,GETDATE(),111),1,2), /* �j�M�Ǹ��̤j��, ����: C+yy */
		@pwd varchar(32) = 'fb04be7df6af108c922cc1e48c1ce14e'
		
/*1.���o�ثe�̷s���X*/
set @max_cust_id = ( select MAX(cust_id) from cust_data where cust_id like @max_cust_id_prefix+'%')
/*2.�̷s���X+1*/
set @max_cust_id = ISNULL(RIGHT(@max_cust_id,5),0)+1	
/*3.�ഫ�^�̷s���u���X*/
set @max_cust_id = @max_cust_id_prefix+REPLICATE('0',5-len(@max_cust_id))+@max_cust_id
--select @max_cust_id as '�̷s���u���X'

/* �ˬd�O�_�w�g�s�W�L */
IF ((select emp_id from emp_comp where emp_id=@emp_id) is not NULL)
BEGIN
	select '�w�s�W�L�����u�N��:'+@emp_id as '���~'
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

select '�s�W����, �Х�admin�b���i�JSYS01:�ϥΪ̱b�����@, ���ϥΪ̭��m�K�X���ϥΪ̱b��' as '�`�N,�U�@�B!!'

/* 
--�R�����u�b���ϥ�

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
-- �d�߭��u���
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