
f:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@f_body:
		MOV 	$2,-4(%14)
		MOV 	$3,-8(%14)
		SUBU	-8(%14),$1,%0
		MOV 	%0,%13
		JMP 	@f_exit
@f_exit:
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