/*
    Organizacion de Computadoras y Assembler
    Proyecto 3: ARM
    Ana Lucia Hernandez 17138
    María Fernanda López 17160
    20/04/2018
 */

/**     REGISTROS:
    R5: contiene direccion a indice en el arreglo de palabras
    R6: contiene direccion a indice en el arreglo de vocales
    R7: letra que se ingresó
    R8: lleva las veces que cada jugador ha jugado (como son 2 y son 10 palabras, comienza con 20)
    R9: numero random generado
    R11: contiene a quien le toca (jugador 1 o 2), 0 si es 1 y 1 si es 2
 **/

.data
.align 2

/* Se definen las variables a usar */

welcome1:
    .asciz "\n************** JUGADOR 1  **************"
welcome2:
    .asciz "\n************** JUGADOR 2  **************"
entrada:
    .asciz " %c"
ingreso_dato:
    .asciz "\nPalabra: %s \nIngrese la vocal: "
mal:
    .asciz "ADVERTENCIA: Ha ingresado mal algun caracter. Solo se puede del abecedario. Perderá su turno y 2 puntos."

ptos1: @@puntos del jugador 1
    .word 0
ptos2:  @@puntos del jugador 2
    .word 0
error:
    .asciz "¡ERROR! Puntos del jugador: %d \n"
correcto:
    .asciz "¡BIEN! Puntos del jugador: %d \n"
banco:
    .asciz "_glu ","g_to ","h_ja ","v_ca ","c_sa ","h_gar","p_so ","am_r ","cl_se","c_na ","v_so ","p_lo ","m_no ","c_ja ","ans_a","ant_s","and_s","oje_r","p_lo ","ci_lo","fl_r ","arr_z","c_ta ","ac_so","ab_so","f_nal","ag_ja","l_na ","n_do ","árb_l","r_ma ","r_íz ","ag_a ","f_ego","r_sa ","ag_do","gr_ve","_ire ","ran_ ","bich_","b_lsa"
letras:
    .asciz "IAOAAOIOAUAEAEIEEAEEOOIOUIUUOOAAUUOUAAAOO"
vocal:
    .asciz "a"
prueba:
	.asciz "%d"
ganador1:
    .asciz "\n\n ----->>¡FIN DEL JUEGO!<<-----\n El ganador es el Jugador 1 con %d puntos.\n"
ganador2:
    .asciz "\n\n ----->>¡FIN DEL JUEGO!<<-----\n El ganador es el Jugador 2 con %d puntos.\n"
ganador3:
    .asciz "\n\n ----->>¡FIN DEL JUEGO!<<-----\n Ha habido un empate, con ambos jugadores con %d puntos.\n"
inicio:
    .asciz "\n                                `. '+\n                              +'''';#'               #@@@ @   @  ,@@#   @       +@#`  @@@@\n                                ;;+''',              @    @   @ @#     @,@     ;@  @` @\n                               `''++';+              @    @   @ @      @ @      @   @ @\n                                `  .  '`             @@#. @   @`@ @@@ ;+;'#`    @   @ @@@;\n                                    .;.#             @    @  `+ @   @ @.,.@     @  ,# @\n                                   '' ;::            @    #+`@` '@ ,@ @   @     @`+@  @:;@\n                                   ','',`            @     ,'    .#'  ;`  ,     #'`   `,.\n                                 :,:;,;\n             ,;                  ;'   ,\n   .,,:,,,.,,.,.:`                    :\n    ;:,,,;;.':,,..:`                  :\n              '.....'                 ,\n              `;:.,,,.'               ;\n              `':;;;;...:`           '`           :#'   ``         .     ':   @@,    :\n                    ;;..,:`          .           #' ;@  @@   @     @@  ,#`'@ @  @;  @@   `@#@\n                       `';,:.    .''.;           #.  @ `@:#  @    .@'+ `@  @ @   @  @ @  @\n                             '@#'''+,,           #.  @ @` @  @    @  @  @@@` @  @. ;' @` ,@#`\n                             `;++++..            @#@@  @@@@@ @    @@@@@ @  @ @@@.  @@@@@.   @;\n                    ;''       +.;;+; `           +.    @   @ @   .#  `@ @  @ @  @  @   @ +  `@\n                   #'';:     ;';+                +,   ;:   @ @@@@+.   @ @@@` @  `@ @   @ :@@@\n                   ;'.'    .:+'                                   `\n                : .   '   ,++\n               `     ,'  '+`\n               `     '  +'   `\n              ` `    '`+`.+';'`\n              ,  .   ;'#,  :;+;\n                ` ` ''    .`;;\n                 .+;,    ,\n               :;;;    ; ,\n              ';';` ., `  ` `\n              '+;+    `  `.\n              #+.     .,"

instrucciones:
    .asciz "\t-*\t-*\t-*\t-*\t-*\t INSTRUCCIONES DEL JUEGO: \t-*\t-*\t-*\t-*\t-*\t\n\n\tLas reglas del juego son muy sencillas, únicamente hay que ingresar la letra faltante de la palabra mostrada en pantalla. \nCada jugador comenzará con un puntaje de cero puntos, si acierta ganará cinco puntos, de lo contrario perderá dos puntos. ¡Que gane el mejor!\n"

/** Empieza el programa **/
.text
.align 2

.global main
.type main,%function


main:
    stmfd sp!,{lr}
    mov r11, #0
    mov r8, #10
    mov r2, #0
    mov r0, #0
    ldr r0, =inicio
    bl puts
    ldr r0,=instrucciones
    bl puts

    /* Links a subrutina 1 */
    bl ingreso

    /* salida a SO */
    mov r0,#0
    mov r3,#0
    ldmfd sp!,{lr}
    bx lr
        
/* Inicio de subrutinas */
ingreso: /* ingreso de vocal */
    cmp r11, #0 @@para verificar el turno de qué jugador toca
    ldreq r0,=welcome1
    ldrne r0,=welcome2
    bl puts

    push {lr}
    bl aleatorios
    pop {lr}
    and r0,#0b11111 @@este me sirve para ver el numero
   	mov r1,r0 @@este es para sumarle la posicion aqui y en letras
    push {lr}
    mov r10,r0
    cmp r10, #30
    subeq r10, #9
    cmp r10, #31
    subeq r10, #9
    ldr r0,=prueba
 //   bl printf
    pop {lr}

    mov r9, #6
    mul r2,r9,r10
    ldr r5,=banco @@carga la primera posicion del banco de palabras
    add r5,r5,r2    @@ se corre hacia la posición del arreglo de palabras indicada por el número random generado

    push {lr}
    ldr r0,=ingreso_dato
    mov r1, r5
    bl printf
    pop {lr}

    @ ingreso de datos
    @ r0 contiene formato de ingreso
    @ r1 contiene la direccion a la vocal que ingreso
    push {lr}
    ldr r0,=entrada
    ldr r1,=vocal
    bl scanf
    pop {lr}

    ldr r7,=vocal
    ldrb r4, [r7]

    /* programacion defensiva */
    cmp r4, #65
    push {lr}
    bllt mal_ingreso
    pop {lr}
    cmp r4, #123
    push {lr}
    blgt mal_ingreso
    pop {lr}
    and r4, #0b11011111 @se convierte a mayusculas, como programacion defensiva
    mov r2, r10
    push {lr}

    bl getchar @@eliminar del buffer
    pop {lr}
    push {lr}
    bl encontrar_palabra
    pop {lr}
    pop {lr}
    mov pc, lr @@regreso al main


encontrar_palabra: /* subrutina para verificar si la letra que se ingresó es la correcta */
    ldr r0,=letras
    add r0, r10
    ldrb r9, [r0]
    cmp r4, r9
    push {lr}
    blne pierde @si se ingreso la que no es, se le resta dos puntos
    bleq gana @ si ingreso la que es, gana 5 puntos
    pop {lr}    @regreso a lugar de llamada
    mov pc, lr


pierde: @el jugador ingreso mal la letra
    cmp r11, #0
    ldreq r0,=ptos1
    ldrne r0,=ptos2
    moveq r11, #1    @@si esta jugando el jugador 1, que cambie
    movne r11, #0 @@si esta jugando el jugador 2, que cambie
    ldr r1, [r0]
    cmp r1, #1
    subgt r1, #2
    movle r1, #0
    strb r1, [r0]  @ puntos <- puntos -2

    push {lr}
    ldr r0,=error
    bl printf
    subs r8, #1 @@resta 1 a la cantidad de veces que se ha jugado
    pop {lr}
    bne ingreso @@mientras no sea 0, que siga jugando
    push {lr}
    bl final
    pop {lr}
    pop {lr}    @regresa hacia donde fue llamado
    mov pc, lr  @@ si el contador es 0, que se termine el programa

gana:   @el jugador ingreso bien la palabra
    mov r0, #0
    cmp r11, #0
    ldreq r0,=ptos1
    ldrne r0,=ptos2
    moveq r11, #1    @@si esta jugando el jugador 1, que cambie
    movne r11, #0 @2si esta jugando el jugador 2, que cambie
    ldr r1, [r0]
    add r1, #5
    strb r1, [r0]  @@ puntos <- puntos + 5
    push {lr}
    ldr r0,=correcto
    bl printf
    pop {lr}
    subs r8, #1 @resta 1 a la cantidad de veces que se ha jugado
    bne ingreso
    push {lr}
    bl final
    pop {lr}
    pop {lr}    @regresa hacia donde fue llamado
    mov pc, lr @@si el contador es 0, que se termine el programa

final: @@ El juego termina, se hace display a qué jugador ganó con su punteo o si hubo algún empate
    ldr r0,=ptos1
    ldr r0, [r0]
    ldr r1,=ptos2
    ldr r1, [r1]
    cmp r0, r1
    movgt r1, r0
    push {lr}
    ldrgt r0,=ganador1
    ldrlt r0,=ganador2
    ldreq r0,=ganador3
    bl printf
    pop {lr}    @@regresa hacia donde fue llamado
    mov pc, lr

mal_ingreso: @ programación defensiva
    push {lr}
    ldr r0,=mal /* mensaje de error*/
    bl puts
    pop {lr}
    mov pc, lr @regreso a lugar de llamada



