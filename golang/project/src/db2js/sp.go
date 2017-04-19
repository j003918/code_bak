// sp
package main

//"fmt"

var (
	MYSQL_SP_DROP   = `DROP PROCEDURE IF EXISTS SP_JHF_TEST_ADD;`
	MYSQL_SP_CREATE = `CREATE PROCEDURE SP_JHF_TEST_ADD (n1 INT, n2 INT, OUT out1 INT,OUT out2 INT)
	BEGIN 
		SET out1 = n1 + n2;
		SET out2 = out1*out1;
	END;`
	MYSQL_SP_EXEC   = `call SP_JHF_TEST_ADD(?,?,@out1,@out2);`
	ORCLE_SP_CREATE = `create or replace procedure COMM.SP_JHF_TEST_ADD
	(
	n1 in number,
    n2 in number,
	out1 out number,
	out2 out number
	) is
	begin
		out1 := n1 + n2;
		out2 := out1*out1;
	end;`

	ORCLE_SP_EXEC = `exec COMM.SP_JHF_TEST_ADD`
)
