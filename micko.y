%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "defs.h"
  #include "symtab.h"
  #include "codegen.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);

  extern int yylineno;
  int out_lin = 0;
  char char_buffer[CHAR_BUFFER_LENGTH];
  int error_count = 0;
  int warning_count = 0;
  int var_num = 0;
  int fun_idx = -1;
  int fcall_idx = -1;
  int lab_num = -1;
  int gl_var_type = -1;
  int gl_return_val = 0;
  int gl_args_type = 0;
  int gl_args[20];
  FILE *output;
%}

%union {
  int i;
  char *s;
}

%token <i> _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token <s> _ID
%token <s> _INT_NUMBER
%token <s> _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token <i> _AROP
%token <i> _RELOP
%token _COMMA
%token _INC
%token _ITERATE
%token _STEP
%token _COLON
%token _BRANCH
%token _FIRST
%token _SECOND
%token _THIRD
%token _OTHERWISE
%token _END_BRANCH
%token _QMARK
%token <i> _MOP


%type <i> num_exp exp literal function_call arguments rel_exp
%type <i> args pars if_part cond_exp m_exp
%type <s> vars var_inc 

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : global_list function_list
    {  
      if(lookup_symbol("main", FUN) == NO_INDEX)
        err("undefined reference to 'main'");
    }
  ;

global_list
  :
  | global_list global_var
  ;

global_var
  : _TYPE _ID _SEMICOLON
    {
      int idx = lookup_symbol($2, GVAR);
      if (idx != NO_INDEX) {
        err("redefinition of '%s'", $2);
      }
      else {
        insert_symbol($2, GVAR, $1, NO_ATR, NO_ATR);
        code("\n%s:\n\t\tWORD\t1", $2); 
      }
    }

function_list
  : function
  | function_list function
  ;

function
  : _TYPE _ID
    {
      fun_idx = lookup_symbol($2, FUN);
      if(fun_idx == NO_INDEX)
        fun_idx = insert_symbol($2, FUN, $1, NO_ATR, NO_ATR);
      else 
        err("redefinition of function '%s'", $2);

      code("\n%s:", $2);
      code("\n\t\tPUSH\t%%14");
      code("\n\t\tMOV \t%%15,%%14");
    }
  _LPAREN parameters _RPAREN body
    {
      if(gl_return_val == 0 && get_type(fun_idx) != VOID)
        warn("Function should return a value");
      gl_return_val = 0;
      clear_symbols(fun_idx + 1);
      var_num = 0;

      code("\n@%s_exit:", $2);
      code("\n\t\tMOV \t%%14,%%15");
      code("\n\t\tPOP \t%%14");
      code("\n\t\tRET");
    }
  ;

parameters
  : /* empty */
    { set_atr1(fun_idx, 0); }
  | pars
    {
      set_atr1(fun_idx, $1);
    }
  ;

pars
  : _TYPE _ID
    {
      if($1 == VOID)
          err("parameter cannot be VOID");
      insert_symbol($2, PAR, $1, 1, NO_ATR);
      set_atr2(fun_idx, $1);
      $$ = 1;
    }
  | pars _COMMA _TYPE _ID
    {
      if($3 == VOID)
          err("parameter cannot be VOID");
      $$ = $$ + 1;
      insert_symbol($4, PAR, $3, $$, NO_ATR);
      set_atr2(fun_idx, get_atr2(fun_idx)*10 + $3);
    }
  ;

body
  : _LBRACKET variable_list 
    {
      if(var_num)
        code("\n\t\tSUBS\t%%15,$%d,%%15", 4*var_num);
      code("\n@%s_body:", get_name(fun_idx));
    }
  statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : _TYPE { gl_var_type = $1; } vars _SEMICOLON 
    {
      if($1 == VOID)
        err("variable cannot be VOID");
    }
  ;

vars
  : _ID 
    {
      int i = lookup_symbol($1,VAR|PAR);
      if(i == -1) {
        insert_symbol($1, VAR, gl_var_type, ++var_num, NO_ATR);
      }
      else
        err("duplicated local var");
    }
  | vars _COMMA _ID
    { 
      int i = lookup_symbol($3,VAR|PAR);
      if(i == -1) {
        insert_symbol($3, VAR, gl_var_type, ++var_num, NO_ATR);
      }
      else
        err("duplicated local var");
      // print_symtab();
    }
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | inc_statement
  | assignment_statement
  | if_statement
  | iterate_statement
  | branch_statement
  | function_statement
  | return_statement
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

function_statement
  : function_call _SEMICOLON
  ; 

inc_statement
  : var_inc _SEMICOLON
    {
      int idx = lookup_symbol($1, (VAR|PAR|GVAR));
      if (idx == NO_INDEX)
        err("'%s' undeclared", $1);
      else {
        code("\n\t\t%s\t", ar_instructions[ADD + (get_type(idx) - 1) * AROP_NUMBER]);
        gen_sym_name(idx);
        code(",$1,");
        gen_sym_name(idx);
      }
    }
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
    {
      int idx = lookup_symbol($1, VAR|PAR|GVAR);
      if(idx == NO_INDEX)
        err("invalid lvalue '%s' in assignment", $1);
      else {
        if(get_type(idx) != get_type($3))
          err("incompatible types in assignment");
      }
      gen_mov($3, idx);
    }
  ;

num_exp
  : m_exp
  | num_exp _AROP m_exp
    {
      if(get_type($1) != get_type($3))
        err("invalid operands: arithmetic operation");
      int t1 = get_type($1);    
      code("\n\t\t%s\t", ar_instructions[$2 + (t1 - 1) * AROP_NUMBER]);
      gen_sym_name($1);
      code(",");
      gen_sym_name($3);
      code(",");
      free_if_reg($3);
      free_if_reg($1);
      $$ = take_reg();
      gen_sym_name($$);
      set_type($$, t1);
    }
  ;

  m_exp
  : exp
  | m_exp _MOP exp
    {
      if(get_type($1) != get_type($3))
        err("invalid operands: arithmetic operation");
      int t1 = get_type($1);    
      code("\n\t\t%s\t", m_instructions[$2 + (t1 - 1) * MOP_NUMBER]);
      gen_sym_name($1);
      code(",");
      gen_sym_name($3);
      code(",");
      free_if_reg($3);
      free_if_reg($1);
      $$ = take_reg();
      gen_sym_name($$);
      set_type($$, t1);
    }
  ;

exp
  : literal
  | _ID
    {
      $$ = lookup_symbol($1, VAR|PAR|GVAR);
      if($$ == NO_INDEX)
        err("'%s' undeclared", $1);
        // print_symtab();

    }
  | var_inc 
    {
      $$ = lookup_symbol($1, VAR|PAR|GVAR);
      if($$ == NO_INDEX) {
        err("'%s' undeclared or trying to increment something that is not a variable or parameter", $1);
      }

        // err("'%s' undeclared", $1);
      // else {
      //   code("\n\t\t%s\t", ar_instructions[ADD + (get_type(idx) - 1) * AROP_NUMBER]);
      //   gen_sym_name(idx);
      //   code(",$1,");
      //   gen_sym_name(idx);
      // }
    }
  | _LPAREN rel_exp _RPAREN _QMARK cond_exp _COLON cond_exp
    {
      int out = take_reg();
      lab_num++;
      if(get_type($5) != get_type($7))
        err("exp1 i exp2 nisu istog tipa");
      code("\n\t\t%s\t@false%d", opp_jumps[$2],lab_num);
      code("\n@true%d:", lab_num);
      gen_mov($5, out);
      code("\n\t\tJMP \t@exit%d", lab_num);
      code("\n@false%d:", lab_num);
      gen_mov($7, out);
      code("\n@exit%d:", lab_num);
      $$ = out;
    }
  | function_call
    {
      $$ = take_reg();
      gen_mov(FUN_REG, $$);
    }
  | _LPAREN num_exp _RPAREN
    { $$ = $2; }
  ;

cond_exp
  : _ID
    {
      if( ($$ = lookup_symbol($1, (VAR|PAR))) == NO_INDEX )
        err("'%s' undeclared", $1);
    }
  | literal
  ;

var_inc
  : _ID _INC
    {
      // int i = lookup_symbol($1, VAR|PAR|GVAR);
      // if(i == NO_INDEX)
      //   err("'%s' undeclared or trying to increment something that is not a variable or parameter", $1);
      // else
      $$ = $1;
    }    
  ;

literal
  : _INT_NUMBER
    { $$ = insert_literal($1, INT); }
  | _UINT_NUMBER
    { $$ = insert_literal($1, UINT); }
  ;

function_call
  : _ID 
    {
      fcall_idx = lookup_symbol($1, FUN);
      if(fcall_idx == NO_INDEX)
        err("'%s' is not a function", $1);
    }
  _LPAREN arguments _RPAREN
    {
      if(get_atr1(fcall_idx) != $4)
        err("wrong number of args to function '%s'", get_name(fcall_idx));
      if (gl_args_type != get_atr2(fcall_idx))
        err ("wrong parameter type in function call '%s'", get_name(fcall_idx));

      for(int i = get_atr1(fcall_idx) - 1; i >= 0; i--){  
        // printf("  =[ ////%d//// ]", get_atr1(fcall_idx));
        // printf("  =[%d ]", gl_args[i]);
        free_if_reg(gl_args[i]);
        code("\n\t\t\tPUSH\t");
        gen_sym_name(gl_args[i]);
      
        // print_symtab();
      }
      code("\n\t\t\tCALL\t%s", get_name(fcall_idx));
      if($4 > 0)
        code("\n\t\t\tADDS\t%%15,$%d,%%15", $4 * 4);
      set_type(FUN_REG, get_type(fcall_idx));
      // print_symtab();
      gl_args_type = 0;
      $$ = FUN_REG;
    }
  ;

arguments
  : /* empty */
    { $$ = 0; }
  | args
    { 
      $$ = $1;
    }
  ;

args
  : num_exp
    {
      gl_args_type = (gl_args_type * 10) + get_type($1);
      gl_args[0] = $1;
      $$ = 1;
    }
  | args _COMMA num_exp
    {
      gl_args_type = (gl_args_type * 10) + get_type($3);
      gl_args[$1] = $3;
      $$ = $$ + 1;
    }
  ;

iterate_statement
  : _ITERATE _ID
    {
      int i = lookup_symbol($2, VAR|PAR);
      if(i == NO_INDEX)
        err("'%s' undeclared", $2);
    }
  literal _COLON literal 
    {
      int i = lookup_symbol($2, VAR|PAR);
      if(get_type(i) != get_type($4) || get_type(i) != get_type($6))
          err("incompatible types in assignment");
      if (atoi(get_name($4)) < atoi(get_name($6)))
        err("itarate max value is less then the min value");

      gen_mov($4,i);
      $<i>$ = ++lab_num;
      code("\n@iterate%d:", lab_num);
    
      if(get_type(i) == INT) {
        code("\n\t\tCMPS\t");

        gen_sym_name(i);
        code(",");
        gen_sym_name($6);

        code("\n\t\tJLES\t@exit%d", $<i>$ );
      }
      else {
        code("\n\t\tCMPU\t");

        gen_sym_name(i);
        code(",");
        gen_sym_name($6);

        code("\n\t\tJLEU\t@exit%d", $<i>$ );
      }
    }
  statement _STEP literal 
    {
      int i = lookup_symbol($2, VAR|PAR);
      if(get_type(i) != get_type($4) || get_type(i) != get_type($10))
          err("incompatible types in assignment");

      if(get_type(i) == INT)
        code("\n\t\tSUBS\t");
      else
        code("\n\t\tSUBU\t");
      
      gen_sym_name(i);

      code(",");
      gen_sym_name($10);
      code(",");

      gen_sym_name(i);

      code("\n\t\tJMP \t@iterate%d", $<i>7);
      code("\n@exit%d:", $<i>7);
    } 
  _SEMICOLON
  ;

branch_statement
  : _BRANCH _LPAREN _ID
    {
      int i = lookup_symbol($3, VAR);
      if(i == NO_INDEX) 
        err("'%s' undeclared", $3);
    }
  _SEMICOLON literal _COMMA literal _COMMA literal _RPAREN
    {
      int i = lookup_symbol($3, VAR);
      if(get_type(i) != get_type($6) || get_type(i) != get_type($8)
        || get_type(i) != get_type($10)) {
          err("incompatible types in assignment");
        }

      code("\n@branch%d:", ++lab_num);

      if(get_type(i) == INT) {
        code("\n\t\tCMPS\t");
        gen_sym_name(i);
        code(",");
        gen_sym_name($6);
        code("\n\t\tJEQ\t\t@first%d", lab_num);


        code("\n\t\tCMPS\t");
        gen_sym_name(i);
        code(",");
        gen_sym_name($8);
        code("\n\t\tJEQ\t\t@second%d", lab_num);

        code("\n\t\tCMPS\t");
        gen_sym_name(i);
        code(",");
        gen_sym_name($10);
        code("\n\t\tJEQ\t\t@third%d", lab_num);
      }
      else {

        code("\n\t\tCMPU\t");
        gen_sym_name(i);
        code(",");
        gen_sym_name($6);
        code("\n\t\tJEQ\t\t@first%d", lab_num);

        code("\n\t\tCMPU\t");
        gen_sym_name(i);
        code(",");
        gen_sym_name($8);
        code("\n\t\tJEQ\t\t@second%d", lab_num);

        code("\n\t\tCMPU\t");
        gen_sym_name(i);
        code(",");
        gen_sym_name($10);
        code("\n\t\tJEQ\t\t@third%d", lab_num);
      }
      code("\n\t\tJMP \t@otherwise%d", lab_num);
    }
  _FIRST 
    {
      code("\n@first%d:", lab_num);
    }
  statement
    {
      code("\n\t\tJMP \t@exit%d", lab_num);
    }
  _SECOND
    {
      code("\n@second%d:", lab_num);
    }
  statement
    {
      code("\n\t\tJMP \t@exit%d", lab_num);
    }
  _THIRD 
    {
      code("\n@third%d:", lab_num);
    }
  statement
    {
      code("\n\t\tJMP \t@exit%d", lab_num);
    }
  _OTHERWISE 
    {
      code("\n@otherwise%d:", lab_num);
    }
  statement
    {
      code("\n\t\tJMP \t@exit%d", lab_num);
    }
  _END_BRANCH
    {
      code("\n@exit%d:", lab_num--);
    }
  ;

if_statement
  : if_part %prec ONLY_IF
    { code("\n@exit%d:", $1); }
  | if_part _ELSE statement
    { code("\n@exit%d:", $1); }
  ;

if_part
  : _IF _LPAREN
    {
      $<i>$ = ++lab_num;
      code("\n@if%d:", lab_num);
    }
  rel_exp
    {
      code("\n\t\t%s\t@false%d", opp_jumps[$4], $<i>3);
      code("\n@true%d:", $<i>3);
    }
  _RPAREN statement
    {
      code("\n\t\tJMP \t@exit%d", $<i>3);
      code("\n@false%d:", $<i>3);
      $$ = $<i>3;
    }
  ;

rel_exp
  : num_exp _RELOP num_exp
    {
      if(get_type($1) != get_type($3))
        err("invalid operands: relational operator");
      $$ = $2 + ((get_type($1) - 1) * RELOP_NUMBER);
      gen_cmp($1, $3);
    }
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
    {
      if(get_type(fun_idx) == VOID)
        err("void functions shouln not return anything");
      if(get_type(fun_idx) != get_type($2))
        err("incompatible types in function return");
      gl_return_val++;
      gen_mov($2, FUN_REG);
      code("\n\t\tJMP \t@%s_exit", get_name(fun_idx));  
    }
  | _RETURN _SEMICOLON
   {
      if(get_type(fun_idx) != VOID)
          warn("'%s' should have a return statement", get_name(fun_idx));
      gl_return_val++;
    }
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;
  init_symtab();
  output = fopen("output.asm", "w+");

  synerr = yyparse();

  clear_symtab();
  fclose(output);
  
  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count) {
    // remove("output.asm");
    printf("\n%d error(s).\n", error_count);
  }

  if(synerr)
    return -1;  //syntax error
  else if(error_count)
    return error_count & 127; //semantic errors
  else if(warning_count)
    return (warning_count & 127) + 127; //warnings
  else
    return 0; //OK
}

