
func1:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@func1_body:
		MOV 	8(%14),-4(%14)
		MOV 	$3,-8(%14)
		MOV 	-4(%14),%13
		JMP 	@func1_exit
@func1_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@main_body:
			PUSH	$4
			CALL	func1
			ADDS	%15,$4,%15
		MOV 	%13,%0
		MOV 	%0,-4(%14)
		MOV 	-4(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET