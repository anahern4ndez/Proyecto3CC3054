/*Universidad del valle*/
/*Organizacion de computadoras y assembler*/
/*Laboratorio #10 progama No.2*/
/*Maria Fernanda Lopez - 17160*/
/*Paul Belches - 17088*/
/*Programa Modos de Direccionamiento PRE-INDEX */
/*Programa que traduce la cadena de caracteres de minuscula,
a mayuscula*/

.data
.align 2

cadena:		.asciz	"_glu ","g_to ","v_ca ","c_sa ","h_gar","b_lon"
formato:	.asciz	"%s"
cadena2:	.byte 'i','a','a','a','o','a'
inicio:		.asciz	"*******JUGADOR 1*****"
mensaje:	.asciz	"vocal correcta"
formatoC:	.asciz	"%c"
mensajeG:	.asciz	"Son iguales"
mensajeP:	.asciz  "Son diferentes"
vocal:		.asciz " "
entrada:	.asciz "%d"
.text
.align 2

.global main
.type main,%function

main:
	
	stmfd sp!,{lr}
	
	ldr r0,=inicio
	bl puts
	
	mov r2,#2
	mov r5,r2
	@@cantidad de espacios que hay que moverse por palabra
	mov r3,#6
	@@la palabra
	mul r2,r2,r3
	mov r3,r5
	bl cargar_palabra
fin:
	@salida	
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
cargar_palabra:
	push {lr}
	ldr r0,=cadena
        add r0,r0,r2
        mov r1,r0
        ldr r0,=formato
        bl printf
	bl ingreso_vocal
	mov r2,#2
	pop {lr}
	mov pc,lr
ingreso_vocal:
	push {lr}
	ldr r0,=entrada
	ldr r1,=vocal
	bl scanf
	ldr r4,=vocal
	ldr r0,=mensaje
	bl puts
	ldr r7,=cadena2
	add r7,r7,r3
	ldrb r1,[r7]
	ldr r0,=formatoC
	bl printf	
	pop {lr}
	mov pc,lr
gano:
	push {lr}
	ldr r0,=mensajeG
	bl puts
	pop {lr}
	mov pc,lr
perdio:
	push {lr}
	ldr r0,=mensajeP
	bl puts
	pop {lr}
	mov pc,lr

