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

/* Comentario */
ComentarioDeUnaLinea = "@"[^\\n]*
ComentarioMultilinea = "@@".*? "@@" 
Comentario = {ComentarioDeUnaLinea}|{ComentarioMultilinea}

/* Identificador */
Letra = [A-Za-zñÑ]
Digito = [0-9]
Identificador = "#"{Letra}({Letra}|{Digito})*

/* Número */
Numero = ("+"|"-")? {Digito}+ ("." {Digito}+)? 
%%

/* Comentarios o espacios en blanco */
{Comentario} { return textColor(yychar, yylength(), new Color(146, 146, 146)); }
{EspacioEnBlanco} { /*Ignorar*/ }

/* Cadena de Texto */
cadenaTxt = \"[^\"]+\" { return textColor(yychar, yylength(), new Color(144, 231, 44)); }

/* palabras reservadas y tipos de datos*/

iniciar|fin|funcion|crear|como|leer|mostrar|raiz|potencia|sen|cos|tan|aleatorio
|redondear|abs|logn|si|entonces|sino|comparar|para|hacer|mientras|repetir|cuando
|ciclar|desde|hasta|inc { return textColor(yychar, yylength(), new Color(0, 0, 255)); }

/* Tipos de datos */
decimal | entero | booleano | texto| false | true { return textColor(yychar, yylength(), new Color(255, 99, 188)); }

/* caracteres especiales */
"." | "+" | "-" | "*" | "/" | "%" { return textColor(yychar, yylength(), new Color(182, 149, 192)); }
"=" | "==" | ">" | "<" | ">=" | "<=" { return textColor(yychar, yylength(), new Color(192, 0, 191)); }
"{" | "}" | "(" | ")" | "!" | "#" |"$" { return textColor(yychar, yylength(), new Color(255, 181, 82)); }

and | or | not { return textColor(yychar, yylength(), new Color(184, 184, 184 )); }
";" | ":" | "," { /* Ignorar */ }

/* Identificador */
{Identificador}  { /* Ignorar */ }

. { /* Ignorar */ }