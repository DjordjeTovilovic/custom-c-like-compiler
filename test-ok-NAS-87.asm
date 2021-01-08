
func:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$28,%15
@func_body:
		MOV 	$0,-4(%14)
		MOV 	$2,-8(%14)
		MOV 	$2,-12(%14)
		MOV 	-12(%14),-16(%14)
		MOV 	-8(%14),-20(%14)
		MOV 	$2,-24(%14)
		MOV 	8(%14),-28(%14)
		ADDU	-28(%14),8(%14),%0
		MOV 	%0,%13
		JMP 	@func_exit
@func_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
@main_body:
		MOV 	$0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET