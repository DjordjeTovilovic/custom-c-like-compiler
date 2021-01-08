
abs:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$12,%15
@abs_body:
		MULS	8(%14),-12(%14),%0
		MOV 	%0,-8(%14)
		MULS	-12(%14),8(%14),%0
		DIVS	%0,-8(%14),%0
		ADDS	-4(%14),%0,%0
		MOV 	%0,-12(%14)
		DIVS	-4(%14),$2,%0
		MOV 	%0,-4(%14)
@if0:
		CMPS 	8(%14),$0
		JGES	@false0
@true0:
		SUBS	$0,8(%14),%0
		MOV 	%0,-4(%14)
		JMP 	@exit0
@false0:
		MOV 	8(%14),-4(%14)
@exit0:
@abs_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
@main_body:
			PUSH	$-5
			CALL	abs
			ADDS	%15,$4,%15
		MOV 	$0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET