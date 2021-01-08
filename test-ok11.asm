
abs:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$20,%15
@abs_body:
		MULS	-16(%14),-4(%14),%0
		ADDS	$5,%0,%0
		MOV 	%0,-12(%14)
		ADDS	-12(%14),$1,-12(%14)
@if0:
		CMPS 	8(%14),$0
		JGES	@false0
@true0:
		SUBS	$0,8(%14),%0
		MOV 	%0,-8(%14)
		JMP 	@exit0
@false0:
		MOV 	8(%14),-8(%14)
@exit0:
		ADDS	-8(%14),$1,-8(%14)
		MOV 	-8(%14),%13
		JMP 	@abs_exit
@abs_exit:
		MOV 	%14,%15
		POP 	%14
		RET
ke:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@ke_body:
		MOV 	8(%14),%13
		JMP 	@ke_exit
@ke_exit:
		MOV 	%14,%15
		POP 	%14
		RET
abc:
		PUSH	%14
		MOV 	%15,%14
@abc_body:
@abc_exit:
		MOV 	%14,%15
		POP 	%14
		RET
kk:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@kk_body:
@kk_exit:
		MOV 	%14,%15
		POP 	%14
		RET
foo:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$4,%15
@foo_body:
		MOV 	-4(%14),%13
		JMP 	@foo_exit
@foo_exit:
		MOV 	%14,%15
		POP 	%14
		RET
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$8,%15
@main_body:
			PUSH	$4
			PUSH	$2
			CALL	ke
			ADDS	%15,$8,%15
		MOV 	%13,%0
		MOV 	%0,-8(%14)
			PUSH	$3
			PUSH	$2
			PUSH	$1
			CALL	abc
			ADDS	%15,$12,%15
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