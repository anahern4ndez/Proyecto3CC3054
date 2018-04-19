

/*
 Organizacion de Computadoras y Assembler
    Ana Lucia Hernandez 17138
    María Fernanda López 17160
    20/04/2018
 */

.data
.align 2
//se definen las variables a usar
N:
.word   10
formato:
    .asciz "Su nombre en mayusculas (10 caracteres maximo): %s\n"
entrada:
    .asciz "%s"
ingreso_dato:
    .asciz "\nIngrese su nombre: "
mal:
    .asciz "Ha ingresado mal algun caracter. Solo se puede del abecedario."
valor:
    .asciz " "
arreglo:
    .asciz "          "
arreglosalida:
    .asciz "          "


//Empieza el encabezado
.text
.align 2

.global main
.type main,%function


main:
    stmfd sp!,{lr}

ingreso: /* ingreso de nombre */
    ldr r8,=arreglosalida
    ldr r5,=arreglo //carga la primera posicion del arreglo que se va a ingresar
    sub r8, r8, #1
    sub r5,r5,#1
    mov r7,#0
    ldr r6,=N //carga el tama  o del arreglo
    ldr r6,[r6]

    ldr r0,=ingreso_dato
    bl puts

    @ ingreso de datos
    @ r0 contiene formato de ingreso
    @ r1 contiene direccion donde almacena dato leido
    ldr r0,=entrada
    ldr r1,=arreglo

    bl scanf//leemos
    mov r0, #1
    mov r7,#0


uppercase:   /* ciclo para cambiar los valores del arreglo y guardarlos en uno nuevo */
    ldrb r10,[r5,#1]! @@carga en r10 el valor actual del arreglo

    /* programacion defensiva */
    cmp r10, #65
    cmpge r10, #90
    cmpgt r10, #97
    blt mal_ingreso
    cmp r10, #123
    bgt mal_ingreso

    /* cambio a mayusculas y store del nuevo valor en el arreglo de salida */
    and r10, #0b11011111
    ldr r9,[r8,#1]! //carga en r9 el valor actual del arreglo de salida
    str r10, [r8]
    mov r9,r10//movemos el valor
    add r7,r7,#1 //testamos
    cmp r6,r7//testeamos el valor
    bne uppercase

print:  /* se imprime todo el arreglo */
    ldr r0,=formato//asiganmos el formato
    ldr r1, =arreglosalida
    bl printf//imprimimos

fin:
    mov r0,#0
    mov r3,#0
    ldmfd sp!,{lr}
    bx lr

mal_ingreso:
    cmp r10, #0
    beq print
    ldr r0,=mal /* mensaje de error*/
    bl puts
    bl getchar @para que borre la informacion del buffer de teclado
    b ingreso



