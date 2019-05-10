.data
  user_specifier: .asciz "%d %d %c"
  int_specifier: .asciz "%d"
  char_specifier: .asciz "%c"
  intOne: .space 4
  intTwo: .space 4
  char: .space 1
  newline: .asciz "\n"
  string: .asciz "invalid input!"
  errors: .asciz "Cant divide by zero!"

.global main
.text

//read the 3 user inputs broken up by the spaces
main:
  ldr x0, =user_specifier
  ldr x1, =intOne
  ldr x2, =intTwo
  ldr x3, =char
  bl scanf

//conditional statments checking for ADD SUB MUL DIV
  ldr x21, =char
  ldrb w22, [x21, #0]
  sub x23, x22, #43
  cbz x23, ADD

  ldr x21, =char
  ldrb w22, [x21, #0]
  sub x23, x22, #45
  cbz x23, SUB

  ldr x21, =char
  ldrb w22, [x21, #0]
  sub x23, x22, #42
  cbz x23, MUL

  ldr x21, =char
  ldrb w22, [x21, #0]
  sub x23, x22, #47
  cbz x23, DIV
//If input is not equal to +-*/ then print an error message
  ldr x0, =string
  bl printf

  ldr x0, =newline
  bl printf
  b exit
//add the inputs
ADD:
    ldr x1, =intOne
    ldr x1, [x1]
    ldr x2, =intTwo
    ldr x2, [x2]
    add x1, x2, x1
    ldr x0, =int_specifier
    bl printf
    ldr x0, =newline
    bl printf
    b exit
    //subtract the inputs
SUB:
  ldr x1, =intOne
  ldr x1, [x1]
  ldr x2, =intTwo
  ldr x2, [x2]
  sub x1, x1, x2
  ldr x0, =int_specifier
  bl printf
  ldr x0, =newline
  bl printf
  b exit
//multiply the inputs
MUL:
  ldr x1, =intOne
  ldr x1, [x1]
  ldr x2, =intTwo
  ldr x2, [x2]
  mul x1, x2, x1
  ldr x0, =int_specifier
  bl printf
  ldr x0, =newline
  bl printf
  b exit
//divide the inputs
DIV:
//first chech if the second number is equal to zero
  ldr x20, =intTwo
  ldrb w21, [x20,#0]
  //if it is brach to the error message and exit
  cbz w21, error
  ldr w1, =intOne
  ldr w1, [x1, #0]
  ldr w2, =intTwo
  ldr w2, [x2, #0]
  sdiv w1, w1, w2
  ldr x0, =int_specifier
  bl printf
  ldr x0, =newline
  bl printf
  b exit
//if secind int is 0
error:
  ldr x0, =errors
  bl printf
  ldr x0, =newline
  bl printf

exit:
  	mov x0, #0
  	mov x8, #93
  	svc #0
