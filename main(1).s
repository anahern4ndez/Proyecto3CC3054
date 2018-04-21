/*
 Organizacion de Computadoras y Assembler
    Ana Lucia Hernandez 17138
    María Fernanda López 17160
    20/04/2018
 */

/**     REGISTROS:
    R11: contiene a quien le toca (jugador 1 o 2), 0 si es 1 y 1 si es 2
    R5: contiene direccion a indice en el arreglo de palabras
    R6: contiene direccion a indice en el arreglo de vocales
    R7: letra que se ingresó
    R9: numero random generado
 **/

.data
.align 2
@@se definen las variables a usar
N:
    .word   10
welcome1:
    .asciz "******* JUGADOR 1  **************"
entrada:
    .asciz "%c"
ingreso_dato:
    .asciz "\nPalabra: %s \nIngrese la vocal: "
mal:
    .asciz "Ha ingresado mal algun caracter. Solo se puede del abecedario."

ptos1: @@puntos del jugador 1
    .word 0
ptos2:  @@puntos del jugador 2
    .word 0
welcome2:
    .asciz "******* JUGADOR 2  **************"
error:
    .asciz "¡ERROR! Puntos del jugador: %d"
correcto:
    .asciz "¡BIEN! Puntos del jugador: %d"
banco:
    .asciz "_glu ","g_to ","p_rro ","v_ca ","c_sa ","h_gar ","b_lón ","am_r ","cl_se ","j_bón ","d_cha ","t_nis ","d_cha ","t_nis ","ans_a ","ant_s ","and_s ","oje_r ","p_lo ","p_ño ","ar_ma ","arr_z ","áng_l ","ac_so ","ab_so ","f_nal ","ag_ja ","paj_r ","n_do ","árb_l ","r_ma ","r_íz ","ag_a ","f_ego ","r_sa ","ag_do ","gr_ve ","_ire ","ran_ ","bich_ ","b_lsa "
letras:
    .asciz "iaeaaoaoaaueueieeaeuooeauiuauoaauuouaaaoo"
palabra:
    .asciz "     "
vocal:
    .asciz " "
mensaje:
	.asciz "El error comienza en ingreso es lo que sigue"


@@Empieza el programa
.text
.align 2

.global main
.type main,%function


main:
    stmfd sp!,{lr}
    mov r11, #0
    ldr r0,=welcome1
    bl puts
ciclo:
    @@Links a subrutinas

    mov r9, #3  @@el random que se genero usarlo para ver qué palabra toca
    mov r6, r1
    ldr r0,=mensaje
    bl puts
    bl ingreso

    @@salida a so
    mov r0,#0
    mov r3,#0
    ldmfd sp!,{lr}
    bx lr

/* Inicio de subrutinas */
ingreso: /* ingreso de nombre */

    mov r5, #0
    ldr r5,=banco @@carga la primera posicion del banco de palabras
    mov r1, #5
    mul r9, r1
    adds r5, r0 @@redirecciona a la posicion de la primera letra de la palabra
    mov r9, #0
    ldrb r2,=palabra
    sub r1, #1
    sub r2, #1
    mov r1, r5
    ldr r0,=mensaje
    bl puts
    bl cargar_palabra

    ldr r0,=ingreso_dato
    ldr r1,=palabra
    bl printf

    @ ingreso de datos
    @ r0 contiene formato de ingreso
    @ r7 contiene la direccion a la vocal que ingreso
    ldr r0,=entrada
    ldr r1,=vocal
    bl scanf	@@leemos

    ldr r7,=vocal
    bl encontrar_palabra

    mov r0, #1
    mov r7,#0
    mov pc, lr @@regreso al main

cargar_palabra:
   push {lr}
   ldr r0,=mensaje
   bl puts
   @@el segmentation fault esta en esta parte del codigo
    ldrb r0, [r5,#1]!
    ldr r0,=mensaje
    bl puts
    ldr r3, [r2, #1]!
    ldr r0,=mensaje
    bl puts
    str r0, [r2]
    ldr r0,=ingreso_dato
    bl puts
    mov r3, r0
    add r0, #1
    cmp r0, #0
    bne cargar_palabra
    pop {lr}

encontrar_palabra:
    push {lr}
    ldr r5,=banco
    add r5, r6
    cmp r5, r7
    b fin
    pop {lr}
fin:
    ldr r0,=error
    bl puts
   pop {lr}
/**
    bne pierde
    beq gana

//pierde: //el jugador ingreso mal la letra
    //aqui hace el print del mensaje que perdio
   // pop {lr}

//gana:   //el jugador ingreso bien la palabra
/**
    mov r0, #0
    cmp r11, #0
    ldreq r0,=ptos1
    ldrne r0,=ptos2
    add r0, #1
    pop {lr}
**/
random:
	xnm .req r0
	a .req r1

	mov a,#0xef00
	mul a,xnm
	add a,xnm
	lsr	a,#3
	add a,#924
	mul a,xnm
	sub a,xnm
	mul a,xnm
	add a,xnm

    cmp a, #0
    blt random
    cmpgt a, #39
    bgt random

	.unreq xnm
	add r0,a,#73

	.unreq a
	pop {lr}








