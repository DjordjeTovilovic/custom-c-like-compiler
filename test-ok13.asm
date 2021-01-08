
abs:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$20,%15
@abs_body:
		MULS	-16(%14),-4(%14),%0
		ADDS	$5,%0,%0
		MOV 	%0,-12(%14)
		ADDS	-12(%14),$1,-12(%14)
		MOV 	$5,-4(%14)
@iterate0:
		CMPS	-4(%14),$2
		JLES	@exit0
		MULS	-16(%14),$2,%0
		MOV 	%0,-8(%14)
		SUBS	-4(%14),$1,-4(%14)
		JMP 	@iterate0
@exit0:
		MOV 	$5,-12(%14)
@iterate1:
		CMPS	-12(%14),$2
		JLES	@exit1
		MOV 	$5,12(%14)
@iterate2:
		CMPS	12(%14),$2
		JLES	@exit2
		DIVS	-12(%14),$5,%0
		MOV 	%0,16(%14)
		SUBS	12(%14),$2,12(%14)
		JMP 	@iterate2
@exit2:
		SUBS	-12(%14),$1,-12(%14)
		JMP 	@iterate1
@exit1:
@if3:
		CMPS 	8(%14),$0
		JGES	@false3
@true3:
		SUBS	$0,8(%14),%0
		MOV 	%0,-8(%14)
		JMP 	@exit3
@false3:
		MOV 	8(%14),-8(%14)
@exit3:
		ADDS	-8(%14),$1,-8(%14)
		MOV 	-8(%14),%13
		JMP 	@abs_exit
@abs_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@main_body:
			PUSH	-8(%14)
			PUSH	$5
			PUSH	$-5
			CALL	abs
			ADDS	%15,$12,%15
		MOV 	%13,%0
		MOV 	%0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET