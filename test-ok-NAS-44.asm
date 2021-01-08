
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$28,%15
@main_body:
		MOV 	$5,-4(%14)
		MOV 	$1,-8(%14)
		MOV 	$0,-16(%14)
		MOV 	$-1,-20(%14)
		MOV 	$0,-24(%14)
		MOV 	$1,-28(%14)
		SUBS	-20(%14),$3,%0
		MOV 	%0,-12(%14)
		MOV 	$-4,%13
		JMP 	@main_exit
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET