

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
//se definen las variables a usar
N:
    .word   10
welcome1:
    .asciz "******* JUGADOR 1  **************"
entrada:
    .asciz " %c"
ingreso_dato:
    .asciz "\nPalabra: %s \nIngrese la vocal: "
mal:
    .asciz "Ha ingresado mal algun caracter. Solo se puede del abecedario."

ptos1: //puntos del jugador 1
    .word 0
ptos2:  //puntos del jugador 2
    .word 0
welcome2:
    .asciz "******* JUGADOR 2  **************"
error:
    .asciz "¡ERROR! Puntos del jugador: %d \n"
correcto:
    .asciz "¡BIEN! Puntos del jugador: %d \n"
banco:
    .asciz "_glu ","g_to ","p_rro ","v_ca ","c_sa ","h_gar ","b_lón ","am_r ","cl_se ","j_bón ","d_cha ","t_nis ","d_cha ","t_nis ","ans_a ","ant_s ","and_s ","oje_r ","p_lo ","p_ño ","ar_ma ","arr_z ","áng_l ","ac_so ","ab_so ","f_nal ","ag_ja ","paj_r ","n_do ","árb_l ","r_ma ","r_íz ","ag_a ","f_ego ","r_sa ","ag_do ","gr_ve ","_ire ","ran_ ","bich_ ","b_lsa "
letras:
    .asciz "iaeaaoaoaaueueieeaeuooeauiuauoaauuouaaaoo"
vocal:
    .asciz " "


//Empieza el programa
.text
.align 2

.global main
.type main,%function


main:
    stmfd sp!,{lr}
    mov r11, #0

    //Links a subrutinas
    bl ingreso

    //salida a SO
    mov r0,#0
    mov r3,#0
    ldmfd sp!,{lr}
    bx lr

/* Inicio de subrutinas */
ingreso: /* ingreso de nombre */
    ldr r0,=welcome1
    bl puts

    mov r10, #10 //prueba
    mov r9, #6
    mul r2,r9, r10
    ldr r5,=banco //carga la primera posicion del banco de palabras
    sub r5, #1
    add r5, r2

    ldr r0,=ingreso_dato
    mov r1, r5
    bl printf

    @ ingreso de datos
    @ r0 contiene formato de ingreso
    @ r7 contiene la direccion a la vocal que ingreso
    ldr r0,=entrada
    ldr r1,=vocal
    bl scanf//leemos

    ldr r7,=vocal
    ldrb r4, [r7]
    mov r2, r10
    bl getchar //eliminar del buffer
    bl encontrar_palabra

    mov pc, lr //regreso al main


encontrar_palabra:
    ldr r0,=letras
    sub r0, #1
    add r0, #10
    ldrb r9, [r0]
    cmp r4, r9
    blne pierde
    bleq gana
    pop {lr}


pierde: //el jugador ingreso mal la letra
    ldr r0,=welcome1
    bl puts
    ldr r0,=error
    ldr r1,=ptos1
    bl printf
    pop {lr}
    b ingreso

gana:   //el jugador ingreso bien la palabra
    mov r0, #0
    cmp r11, #0
    ldreq r0,=ptos1
    ldrne r0,=ptos2
    moveq r11, #1    //si esta jugando el jugador 1, que cambie
    movne r11, #0 //si esta jugando el jugador 2, que cambie
    ldrb r0, [r0]
    add r1, r0, #1
//    strb r1, [r0]  // esto hay que arreglarlo porque tira un segmentation fault
    mov r1, r0
    ldr r0,=correcto
    bl printf
    pop {lr}
    b ingreso



