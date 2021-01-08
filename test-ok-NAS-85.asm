
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$28,%15
@main_body:
		MOV 	$1,-4(%14)
		MOV 	$3,-8(%14)
		MOV 	-8(%14),-12(%14)
		MOV 	$2,-16(%14)
		MOV 	$3,-20(%14)
		MOV 	$0,-24(%14)
		ADDS	-12(%14),-16(%14),%0
		MOV 	%0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET
func:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@func_body:
		MOV 	$2,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@func_exit
@func_exit:
		MOV 	%14,%15
		POP 	%14
		RET