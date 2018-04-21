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
respuestas:	.asciz "i","a","a","a","o","a"
incorrecto:	.asciz	"El caracter que ingreso es invalido"
mensaje:	.asciz	"Por favor ingrese su nombre (max 10 caracteres)"
formatoC:	.asciz	"%c"
incorrecto2:	.asciz	"Por favor ingrese como maximo 10 caracteres"
.text
.align 2

.global main
.type main,%function

main:
	
	stmfd sp!,{lr}
	
	ldr r0,=mensaje
	bl puts
	
	mov r2,#2
	mov r3,#6
	mul r2,r2,r3
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
	pop {lr}

