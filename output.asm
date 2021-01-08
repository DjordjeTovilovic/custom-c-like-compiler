
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$20,%15
@main_body:
		MOV 	$1,-16(%14)
		MOV 	$0,-20(%14)
		MOV 	$4,-4(%14)
		MOV 	$0,-8(%14)
@branch0:
		CMPS	-16(%14),$1
		JEQ		@first0
		CMPS	-16(%14),$3
		JEQ		@second0
		CMPS	-16(%14),$5
		JEQ		@third0
		JMP 	@otherwise0
@first0:
		ADDS	-16(%14),$1,%0
		MOV 	%0,-16(%14)
		JMP 	@exit0
@second0:
@branch1:
		CMPS	-4(%14),$1
		JEQ		@first1
		CMPS	-4(%14),$3
		JEQ		@second1
		CMPS	-4(%14),$5
		JEQ		@third1
		JMP 	@otherwise1
@first1:
		ADDS	-4(%14),$1,%0
		MOV 	%0,-4(%14)
		JMP 	@exit1
@second1:
		ADDS	-4(%14),$3,%0
		MOV 	%0,-4(%14)
		JMP 	@exit1
@third1:
		ADDS	-4(%14),$5,%0
		MOV 	%0,-4(%14)
		JMP 	@exit1
@otherwise1:
		SUBS	-4(%14),$3,%0
		MOV 	%0,-4(%14)
		JMP 	@exit1
@exit1:
		JMP 	@exit0
@third0:
		ADDS	-16(%14),$5,%0
		MOV 	%0,-16(%14)
		JMP 	@exit0
@otherwise0:
		SUBS	-16(%14),$3,%0
		MOV 	%0,-16(%14)
		JMP 	@exit0
@exit0:
		MOV 	-8(%14),%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET