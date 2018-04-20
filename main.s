

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
 **/

.data
.align 2
//se definen las variables a usar
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

ptos1: //puntos del jugador 1
    .word 0
ptos2:  //puntos del jugador 2
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


//Empieza el programa
.text
.align 2

.global main
.type main,%function


main:
    stmfd sp!,{lr}
    mov r11, #0

    //Links a subrutinas
    bl random
    mov r0, r1 //el random que se genero usarlo para ver qué palabra toca
    mov r1, r6
    bl ingreso

    //salida a SO
    mov r0,#0
    mov r3,#0
    ldmfd sp!,{lr}
    bx lr

/* Inicio de subrutinas */
ingreso: /* ingreso de nombre */
    mov r5, #0
    ldr r5,=banco //carga la primera posicion del banco de palabras
    mov r1, #5
    mul r0, r1
    adds r5, r0 //redirecciona a la posicion de la primera letra de la palabra
    mov r0, #0
    ldrb r2,=palabra
    sub r1, #1
    sub r2, #1
    push {lr}
    bl cargar_palabra

    push {lr}
    ldr r0,=ingreso_dato
    ldr r1,=palabra
    bl printf

    push {lr}
    ldr r0,=entrada
    ldr r1,r7
    bl scanf//leemos


    @ ingreso de datos
    @ r0 contiene formato de ingreso
    @ r1 contiene direccion donde almacena dato leido
    ldr r0,=entrada
    ldr r1,=arreglo
    bl scanf//leemos

    mov r0, #1
    mov r7,#0
    mov pc, lr //regreso al main

print:  /* se imprime todo el arreglo */
    ldr r0,=formato//asiganmos el formato
    ldr r1, =arreglosalida
    bl printf//imprimimos

mal_ingreso:
    cmp r10, #0
    beq print
    ldr r0,=mal /* mensaje de error*/
    bl puts
    bl getchar @para que borre la informacion del buffer de teclado
    b ingreso

cargar_palabra:
    ldrb r1, [r5, #1]!
    ldr r3, [r2, #1]!
    str r1, [r2]
    mov r3, r1
    add r0, #1
    cmp r0, #5
    bne cargar_palabra
    pop{lr}









