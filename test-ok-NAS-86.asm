
main:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$28,%15
@main_body:
		MOV 	$1,-4(%14)
		MOV 	$2,-8(%14)
		MOV 	$4,-12(%14)
		MOV 	$0,-16(%14)
		MOV 	$1,-20(%14)
		MOV 	$2,-24(%14)
		MOV 	$3,-28(%14)
@main_exit:
		MOV 	%14,%15
		POP 	%14
		RET
func:
		PUSH	%14
		MOV 	%15,%14
		SUBS	%15,$28,%15
@func_body:
		MOV 	$1,-4(%14)
		MOV 	$9,-8(%14)
		MOV 	$0,-12(%14)
		MOV 	$0,-16(%14)
		MOV 	$0,-20(%14)
		MOV 	$1,-24(%14)
		MOV 	$3,-28(%14)
@func_exit:
		MOV 	%14,%15
		POP 	%14
		RET