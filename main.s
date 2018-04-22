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
    R8: lleva las veces que cada jugador ha jugado (como son 2 y son 10 palabras, comienza con 20)
 **/

.data
.align 2

@@se definen las variables a usar
N:
    .word   10
welcome1:
    .asciz "\n******* JUGADOR 1  **************"
entrada:
    .asciz " %c"
ingreso_dato:
    .asciz "\nPalabra: %s \nIngrese la vocal: "
mal:
    .asciz "Ha ingresado mal algun caracter. Solo se puede del abecedario."

ptos1: @@puntos del jugador 1
    .word 0
ptos2:  @@puntos del jugador 2
    .word 0
welcome2:
    .asciz "\n******* JUGADOR 2  **************"
error:
    .asciz "¡ERROR! Puntos del jugador: %d \n"
correcto:
    .asciz "¡BIEN! Puntos del jugador: %d \n"
banco:
    .asciz "_glu ","g_to ","h_ja ","v_ca ","c_sa ","h_gar","p_so ","am_r ","cl_se","c_na ","v_so ","p_lo ","m_no ","c_ja ","ans_a","ant_s","and_s","oje_r","p_lo ","ci_lo","fl_r ","arr_z","c_ta ","ac_so","ab_so","f_nal","ag_ja","l_na ","n_do ","árb_l","r_ma","r_íz ","ag_a ","f_ego","r_sa ","ag_do","gr_ve","_ire ","ran_ ","bich_","b_lsa"
letras:
    .asciz "iaoaaoioauaeaeieeaeeooiouiuuooaauuouaaaoo"
vocal:
    .asciz "a"
random:
	.word   0
prueba:
	.asciz "%d"
inicio:
    .asciz "                                                           `\n                                                                       ##:\n                                                                      #'''\n                                                               `+@@#, `''',\n                                                             `@+''';'#,#''#                                                                     ;\n                                                            `#'''''''''#+''`                                  `.,   ;       #       '@@@`      #@`                ``         `,::;;\n                                                            #'''''''''''#'''                             `@@@@@@@` `@:     :@:     @@@@@@      @@@              +@@@@'     .@@@@@@@;\n                                                           `';''++#'''';'#;#                             @@@@@@@@, :@+     '@;    @@@@@@@`     @@@             @@@@@@@+    @@@@@@@@+\n                                                            ##',.@+'''''''''                             @@@@@@@@  :@+     '@;   @@@@#;@@     .@@@;           #@@@@@@@@.   @@@@@@@@\n                                                               .+'''''''''''`                            :@@:,.`   :@'     +@;  `@@@.   ,     #@@@@           @@@@..+@@@   @@;\n                                                               .+##+@''''''';                            `@@       ;@'     +@:  @@@`          @@`@@           .@@@   ;@@`  '@:\n                                                                  ,#';''''''#                            `@@       ;@'     +@:  @@;           @@ @@.            @@    @@#  '@:\n                                                                 #+'''''''''+                             @@       ;@;     #@,  @@           `@@ +@#            @@    .@@  '@:\n                                                               `#';'''+#+'';'                            `@@       ;@;     #@, ;@#           ;@@ `@@            @@     @@  '@:\n                                                               #''''++'+'''''`                           `@@       ;@;     #@. #@.           @@:  @@            @@     @@  '@:\n                                                              .''''#.`'''';;',                           `@@:;+@@  ;@;     #@` @@            @@`  @@.           @@     #@. '@:\n                                                              .'''@` #''+@@+'+                           @@@@@@@@  ;@;     @@  @@   @@@@@@   @@   '@#           @@     +@, '@@@@@@+\n                                                               +#;   ###`  ,+#                           @@@@@@@@  :@'     @@  @@  `@@@@@@   @@   `@@           @@     +@: '@@@@@@@\n                                                                           #+',                          :@@@@@#   ,@'     @@  @@   @@@@@@  .@@@@@@@@@.         @@     #@: '@@@@@@#\n                                                                          #+''#                          `@@       ,@+     @@  @@   '+++@#  '@@@@@@@@@@         @@     #@. '@@#+',\n                                                                         , ; ''                          `@@       .@#     @@  @@      .@#  @@@@@@@@@@@         @@     @@  '@:\n                                                                         +,  ''                          `@@        @#     @@  #@.     .@#  @@@@@@@@@@`         @@     @@  '@:\n                                                                          #  ''.                         `@@        @@     @@  ;@#     .@#  @@     .@@          @@    `@@  '@:\n                                                                       `# . `#'+                         `@@        @@     @@   @@     .@#  @@      @@          @@    #@@  '@:\n                                                                       ++`  ,:::                         `@@        @@    :@#   @@`    .@#  @@      @@          @@    @@,  '@:\n                                                                      ++#:  #:::'                        `@@        @@'   @@,   @@@    #@# ,@#      @@          @@   @@@   '@:   .#\n                                                                      ###+  ;:::#                        `@@        +@@+`@@@     @@@  '@@: '@;      @@          @@.@@@@'   '@@@@@@@;\n                                                                     .+,#+`.::::#                        `@@         @@@@@@@     @@@@@@@@  #@.      @@`         @@@@@@@    '@@@@@@@:\n                                                                     ,++@# #':::#                        `@@         +@@@@@`      @@@@@@;  @@       @@.         @@@@@@     `@@@@@@@\n                                                                     .':::+:::::,                         @#          +@@@.       .@@@@+   ;@       ,@          @@@@:       `;++:`\n                                                                     `:::::::::#                          ,             `           ,;`              `          `.\n                                                                    #+':::::;:#\n                                                                   #,,'+::::';\n                                                                  `,,,,'::::#:\n                                                                  +,,,;;#::+,;\n                                                                  +,,,,  '':,;\n                                                                  ;,,#     `,'\n                          `,:`                                    ;,,`      ,+\n                       `:#':,''                                   ',#       .+\n                 ``,'##',.,,,,,#                                  '#        ,+\n     ,+###@@@@##++;,..,,,,,,,,,.#                                           ,+\m     ,,,,,.,,,,,,,,,,,,,,,,,,,,,,#                                          :+\n      ;,,,,,,,,,,,,,,,,,,,,,,,,,,,+`                                        :+\n      ;,,,,,,,,,,,,,,,,,,,,,,,,,,,,#                                        :'\n       #,,,,,,,,,,,,.:+#####+;,,,,,,#                                       :'\n        '+,,,,,,,,,+#. .',.,,,,,,,,,,#                                      ,'\n         `'##++##+:    #,,,,,,,,,,,,,,#                                     ,;\n                       ,#####';,,,,,,,,#                                    .;\n                            +,,,,,,,,,,,#                                   ,:\n                            :,,,,,,,,,,,,#                                 `,:\n                             :#;,,,,,,,,,,'                                ,,:\n                               .'##+;:.,,,,;                               +,.\n                               ;#':,,,::,,,:,                              #,`\n                             ++,,,,,,,,,,,,,:.                             ;,\n                            #.,,,,,,,,,,,,,,,'`                            ,'\n                            +,,,,,,,,,,,,,,,,,+`                           ,+\n                            `#,,,,,,,,:;;;,,,,,#                          :,,                        `''`        .                     ,           .        '@@'          `\n                              '+;;+##;,',,,,,,,,#                         +,                        #@@@@:       @'       `           ,@.        #@@@.    `@@@@@@        @@\n                                       ',.,,,,,,,#                        ;:                      `@@@@@@@      ;@@      :@           #@@       @@@@@@    @@@@@@@#       @@.         @@@@\n                                       `#:,,,,,,,,+                       ,+                      '@@@@@@@#     @@@.     #@.          @@@      @@@@@@@@  +@@@##@@@      .@@@        @@@@@@\n                                        +,,,,,,,,,,+                     ,,+                      +@@:  +@@     @@@@     #@.          @@@+     @@@:,@@@  #@@   `@@'     #@@@       @@@@@@@\n                                        .##,.,,,,,,,'                    #,.                      +@:    @@.    @@@@     #@.         ,@@@@     @@@   @@` `@@    ;@@     @@@@:     `@@@;+@@\n                                          `'@',,,,,,,+                +#@:,                       +@:    +@+   ;@#@@`    #@.         #@'@@     +@@   +@;  @@     @@     @@;@@     +@@    .\n                                             `;#+,,,,,+             :#'',,,                       +@:    .@@   @@:+@#    #@.         @@`@@;     @@   ;@'  @@     @@    `@@ @@     @@`\n                                               :###+:,,#           +'';',,:                       +@:     @@   @@ `@@    #@.         @@ :@@     @@   +@:  @@     @@    '@# @@`    @@\n                                               :,,,,,,,,#`        #''''',,;                       +@:     @@   @@  @@    #@.         @@  @@     @@   @@`  @@     @@    @@, #@'    @@\n                                               #+##+'+#+,':   '@#@'';;'+,,+                       +@:    `@@  `@@  @@,   #@.        ;@#  @@     @@  #@@   @@     @@    @@  .@@    @@+\n                                                        '',@`@#+@''';;'+,,+                       +@:    ,@@  '@#  ;@#   #@.        @@:  @@;    @@@@@@+   @@    +@@    @@   @@    +@@+\n                                                         .+'@##@''''''',,,;                       +@:    #@'  @@,   @@   #@.        @@`  ,@@    @@@@@@    @@    @@:   `@@   @@`    @@@@+\n                                                         #'''''';'''''+,,,,                       +@:    @@`  @@    @@   #@`        @@    @@    @@@@@@#   @@   @@@    ;@#   #@:    +@@@@@\n                                                         #'';;+';'''''',,,                        @@:   @@@   @@''''@@+: #@`        @@'''+@@+.  @@@@@@@`  @@:+@@@#    #@+'''#@@+    '@@@@@\n                                                          #+';'#'''''+,,,,                        @@@@@@@@'   @@@@@@@@@@ @@`       .@@@@@@@@@@  @@  `@@#  @@@@@@@     @@@@@@@@@@,     :@@@,\n                                                           `'#@@@+''+;,,,+                        @@@@@@@@   `@@@@@@@@@@ @@`       '@@@@@@@@@@  @@   ,@@  @@@@@@      @@@@@@@@@@;       @@@\n                                         '+`                   :.:'',,,,,'                        #@@@@@@`   ;@@@@@@@@@# @@`       #@@@@@@@@@'  @@    @@  @@@@@@'     @@@@@@@@@@        `@@\n                                        #;;+.                 +',,,,,,,,:                         '@++#;     #@.     @@  @@`       @@      @@   @@    @@  @@  #@@    `@@     @@,         @@\n                                       :;;;;+`              #+,,'',,,,,::                         '@:        @@      @@  @@`       @@      @@   @@    @@  @@   @@:   ,@#     '@+         @@\n                                       #;;;;;#             :;,,,,#+@#+@,                          '@:        @@      @@` @@`       @@      @@   @@   `@@  @@   @@@   '@;     .@@  @;     @@\n                                      '';;;;;;`            +;#,,#,,''                             '@:        @@      #@, @@`       @@      @@   @@   @@+  @@    @@.  @@`      @@  @@     @@\n                                    ` +';;;;;;:           #;;;#@,,#.                              '@:        @@      ;@' @@:::::; .@@      #@.  @@:'@@@   @@    @@@  @@       @@  @@@`  #@@\n                                    `;##;;;;;;'          .;;;;#+:+                                '@:        @@      ,@# @@@@@@@@;:@+      +@:  @@@@@@@   @@    `@@` @@       @@  #@@@@@@@:\n                                   , #@#;;+#;;+          #;;;#;;#                                 '@;       .@+      `@@ @@@@@@@@#'@:      ;@'  @@@@@@    @@     @@# @@       @@   @@@@@@@\n                                     +';;;;;;''         ;;;;#;;#                                  '@:        @.       @; ,@@@@@@@`.@       `@.  @@@@#     @@     `@@ @@       @@    @@@@@`\n                                  ,  +;;;;+;+;,         +;;#;;+                                   `@         .        ,            .        ,             `,      +`           `     ;++\n                                  .  +;;;':;+;`        +;;+;;+\n                                 `   @;;'; #+'        `';+';+\n                                 ; ` '##:  #++        #;'';#\n                                   , #     #'#       .;;+;#\n                                ;  : :     +''       #;#;#\n                                ,  :       ';,      ;;#;#\n                                   ;     . ';       '+;#\n                               ; ` :    `  ''      #;++`\n                               : . `    `  ;+     :;#'.\n                                 ,     :   ;#     +#;:\n                              ,  ,    `   `;'    #';+\n                              '  ,  . :   ,;.   ,;+@\n                              .  `   .    ;;    +@+\n                                     :    +'   #+'.      :'\n                             .      .     #+  ,;'+    `;#';#\n                             '      ;     +#  +##    #+;'#;'\n                             :     `      '+ ##'   ;#';';';;`\n                             `  `  '      ;;,''' .@';;';;;';:\n                                ;        .;++##.#+;'++#;;;+;+\n                            `     :      ;;'#;@++#'.``.;;;#;#\n                            ;     ,      #;;'''#`      ;;;#;#\n                            ;            ';;;+:        ;;;#;#\n                            `    :      `;;;#`       ` ;;;+;'\n                                 `      #;;#`          ;;;';.\n                                       ,;;+`        :  +;';'\n                                      `+'',            +;#;#\n                           .         `#';+         '   `@'#`\n                           ,        :+;;#         :    ;''.\n                           .      .#';''`        `.    @ #\n                           `   ;##'';+;+         '     . `\n                           `  #;'';;;;#         #\n                             ,;;;';;';,        #  ,\n                             #;;;;;+;#        +   `\n                             ';;;;';;.      `+     ,\n                            `;;;;;';#      ,:      `\n                            ';;;;#;;;     +         .   `\n                            #;;;+;;'    :,     :       .\n                            ';;;';;@  `.       `      ,\n                            ;;;+;;;:        '   ;    :\n                            ;;#;;;'                 ;\n                           '##+;;;'          .    `:\n                           #`;;;;#               '`\n                           ',;;;+.             ,;\n                           ++#'@.            `#`\n                            ,`.            ,+`\n                                        .''`\n                                     .,.`"

@@Empieza el programa
.text
.align 2

.global main
.type main,%function


main:
    stmfd sp!,{lr}
    mov r11, #0
    mov r8, #5
    mov r2, #0
    mov r0, #0
    ldr r0, =inicio
    bl puts

    /* Links a subrutinas */
    bl ingreso

    /* salida a SO */
    pop {lr}
    mov r0,#0
    mov r3,#0
    ldmfd sp!,{lr}
    bx lr
        
/* Inicio de subrutinas */
ingreso: /* ingreso de nombre */
    cmp r11, #0

    ldreq r0,=welcome1
    ldrne r0,=welcome2
    bl puts
    ldr r3,=random
    ldr r2, [r3]    @@entra como parametro, para asegurarse que no sea el mismo dos veces
    bl aleatorios
    and r0,#0b11111
	@@este me sirve para ver el numero
   	mov r1,r0
        @@este es para sumarle la posicion aqui y en letras
 	 mov r10,r0
    ldr r0,=prueba
    bl printf

    mov r9, #6
    mul r2,r9,r10
    ldr r5,=banco @@carga la primera posicion del banco de palabras
    add r5,r5,r2

    ldr r0,=ingreso_dato
    mov r1, r5
    bl printf

    @ ingreso de datos
    @ r0 contiene formato de ingreso
    @ r1 contiene la direccion a la vocal que ingreso
    ldr r0,=entrada
    ldr r1,=vocal
    bl scanf

    ldr r7,=vocal
    ldrb r4, [r7]
    mov r2, r10
    bl getchar @@eliminar del buffer
    bl encontrar_palabra

    mov pc, lr @@regreso al main


encontrar_palabra:
    ldr r0,=letras
    add r0, r10
    ldrb r9, [r0]
    cmp r4, r9
    blne pierde
    bleq gana
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
    ldr r0,=error
    bl printf
    subs r8, #1 @@resta 1 a la cantidad de veces que se ha jugado
    pop {lr}
    bne ingreso @@mientras no sea 0, que siga jugando
    mov pc, lr  @@ si el contador es 0, que se termine el programa

gana:   @el jugador ingreso bien la palabra
    mov r0, #0
    cmp r11, #0
    ldreq r0,=ptos1
    ldrne r0,=ptos2
    moveq r11, #1    @@si esta jugando el jugador 1, que cambie
    movne r11, #0 @2si esta jugando el jugador 2, que cambie
    ldr r1, [r0]
    add r1, #1
    strb r1, [r0]  @@ puntos <- puntos + 1
    ldr r0,=correcto
    bl printf
    subs r8, #1 @resta 1 a la cantidad de veces que se ha jugado
    pop {lr}
    bne ingreso
    mov pc, lr @@si el contador es 0, que se termine el programa




