import compilerTools.TextColor;
import java.awt.Color;

%%
%class LexerColor
%type TextColor
%char
%{
    private TextColor textColor(long start, int size, Color color){
        return new TextColor((int) start, size, color);
    }
%}
/* Variables básicas de comentarios y espacios */
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]

ComentarioDeUnaLinea = "#" {EntradaDeCaracter}* {TerminadorDeLinea}?
ComentarioMultilinea = \*\*\*([^*]|(\*[^*])|(\*\*[^*]))*\*\*\*


/* Comentario */
Comentario = {ComentarioDeUnaLinea}|{ComentarioMultilinea}

/* Identificador */
Letra = [A-Za-z]
Digito = [0-9]
Identificador = {Letra}({Letra}|{Digito})*

/* Número */
Numero = 0 | [1-9][0-9]*
%%

/* Comentarios o espacios en blanco */
{Comentario} { return textColor(yychar, yylength(), new Color(146, 146, 146)); }
{EspacioEnBlanco} { /*Ignorar*/ }

/* Cadena de Texto */
cadenaTxt = \"[^\"]+\" { return textColor(yychar, yylength(), new Color(144, 231, 44)); }

/* palabras reservadas y tipos de datos*/
pantalla  | evento | sensor | infrarrojo | hora | beber | evento | alimentar | encender | apagar | nuevo | funciona | 
temperatura | inicio_granja |fin_granja | false | configurar | devuelve | con_retorno | definir | leer_sensor | si |
contrario | contrario_si |segun | caso | termina | fin_segun | para | hasta | incrementa | fin_para | fin_funcion |
mientras | funcion | inicio_programa | fin_programa | dispositivos | fin_dispositivos | 
enumeraciones | ventilador | alimentador | fin_si { return textColor(yychar, yylength(), new Color(0, 0, 255)); }

/* Tipos de datos */
cadena | bool | entero | float | false | edd | sdd | detener | esperar |
estructura | estados { return textColor(yychar, yylength(), new Color(255, 99, 188)); }

/* caracteres especiales */
"." | "+" | "-" | "*" | "/" | "%" { return textColor(yychar, yylength(), new Color(182, 149, 192)); }
"=" | "==" | ">" | "<" | ">=" | "<=" { return textColor(yychar, yylength(), new Color(192, 0, 191)); }
"{" | "}" | "(" | ")" | "!" { return textColor(yychar, yylength(), new Color(255, 181, 82)); }

and | or | not { return textColor(yychar, yylength(), new Color(184, 184, 184 )); }
";" | ":" | "$" | "," { /* Ignorar */ }

/* Identificador */
{Identificador}  { /* Ignorar */ }


. { /* Ignorar */ }