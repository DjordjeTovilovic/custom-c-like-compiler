
f:
		PUSH	%14
		MOV 	%15,%14
@f_body:
		ADDU	16(%14),24(%14),%0
		MOV 	%0,12(%14)
		MOV 	8(%14),%13
		JMP 	@f_exit
@f_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@main_body:
		MOV 	$1,-8(%14)
		MOV 	$2,-12(%14)
			PUSH	$7
			PUSH	$65
			PUSH	$6
			PUSH	-12(%14)
			PUSH	$5
			PUSH	-8(%14)
			CALL	f
			ADDS	%15,$24,%15
		MOV 	%13,%0
		MOV 	%0,-4(%14)
		MOV 	$0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET