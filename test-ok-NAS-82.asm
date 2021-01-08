
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		MOV 	$0,-4(%14)
		MOV 	$1,-8(%14)
		MOV 	$0,-12(%14)
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET
inc:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@inc_body:
		MOV 	$6,-4(%14)
@inc_exit:
		MOV 	%14,%15
		POP 	%14
		RET
func:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@func_body:
		ADDS	-4(%14),$2,%0
		MOV 	%0,-4(%14)
@func_exit:
		MOV 	%14,%15
		POP 	%14
		RET