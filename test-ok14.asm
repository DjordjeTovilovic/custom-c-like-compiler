
abs:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$20,%15
@abs_body:
		MULS	-16(%14),-4(%14),%0
		ADDS	$5,%0,%0
		MOV 	%0,-12(%14)
		ADDS	-12(%14),$1,-12(%14)
@branch0:
		CMPS	-12(%14),$1
		JEQ		@first0
		CMPS	-12(%14),$3
		JEQ		@second0
		CMPS	-12(%14),$5
		JEQ		@third0
		JMP 	@otherwise0
@first0:
		ADDS	-12(%14),$1,%0
		MOV 	%0,-12(%14)
		JMP 	@exit0
@second0:
		ADDS	-12(%14),$3,%0
		MOV 	%0,-12(%14)
		JMP 	@exit0
@third0:
		ADDS	-12(%14),$5,%0
		MOV 	%0,-12(%14)
		JMP 	@exit0
@otherwise0:
		SUBS	-12(%14),$3,%0
		MOV 	%0,-12(%14)
		JMP 	@exit0
@exit0:
@branch0:
		CMPS	-12(%14),$1
		JEQ		@first0
		CMPS	-12(%14),$3
		JEQ		@second0
		CMPS	-12(%14),$5
		JEQ		@third0
		JMP 	@otherwise0
@first0:
		ADDS	-12(%14),$1,%0
		MOV 	%0,-12(%14)
		JMP 	@exit0
@second0:
@branch1:
		CMPS	-16(%14),$1
		JEQ		@first1
		CMPS	-16(%14),$3
		JEQ		@second1
		CMPS	-16(%14),$5
		JEQ		@third1
		JMP 	@otherwise1
@first1:
		ADDS	-16(%14),$1,%0
		MOV 	%0,-16(%14)
		JMP 	@exit1
@second1:
		ADDS	-16(%14),$3,%0
		MOV 	%0,-16(%14)
		JMP 	@exit1
@third1:
		ADDS	-16(%14),$5,%0
		MOV 	%0,-16(%14)
		JMP 	@exit1
@otherwise1:
		SUBS	-16(%14),$3,%0
		MOV 	%0,-16(%14)
		JMP 	@exit1
@exit1:
		JMP 	@exit0
@third0:
		ADDS	-12(%14),$5,%0
		MOV 	%0,-12(%14)
		JMP 	@exit0
@otherwise0:
		SUBS	-12(%14),$3,%0
		MOV 	%0,-12(%14)
		JMP 	@exit0
@exit0:
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
main:
		PUSH	%14
		MOV 	%15,%14
@main_body:
			PUSH	$6
			PUSH	$5
			PUSH	$-5
			CALL	abs
			ADDS	%15,$12,%15
		MOV 	$0,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET