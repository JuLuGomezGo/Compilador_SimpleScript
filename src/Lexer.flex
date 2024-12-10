import compilerTools.Token;

%%
%class Lexer
%type Token
%line
%column
%{
    private Token token(String lexeme, String lexicalComp, int line, int column){
        return new Token(lexeme, lexicalComp, line+1, column+1);
    }
%}




/* Variables básicas de espacios */
CaracteresEsp = [-|.|,|;|:|$|@|?|*|¡|¿|!|%|&|/|\|^|~|`|{|}|[|]|<|>|+|=|']
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]

cadenaTxt = \"[^\"]+\"

/* Comentario */
ComentarioDeUnaLinea = "@"[^\\n]*
ComentarioMultilinea = "@@".*? "@@" 
Comentario = {ComentarioDeUnaLinea}|{ComentarioMultilinea}


/* Identificador */
Letra = [A-Za-zñÑ]
Digito = [0-9]
Identificador = "#"{Letra}({Letra}|{Digito})*

IdentificadorInvalido =  "#" {Digito} ({Letra}|{Digito}|{CaracteresEsp})* | 
                        ({CaracteresEsp}|{Letra})+ ({CaracteresEsp}|{Letra}|{Digito})* | 
                        {CaracteresEsp}+ 

/* Número */
Numero = ("+"|"-")? {Digito}+ ("." {Digito}+)? 
NumeroMalFormado =  {Digito}*\.{Digito}*\.{Digito}* | {Digito}+([a-zA-Z_]|{CaracteresEsp})+
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco}|{ComentarioMultilinea} { /*Ignorar*/ }
  
  
/* palabras reservadas y tipos de datos*/
decimal {return token(yytext(), "TIPO DATO", yyline, yycolumn);}
entero {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}
booleano {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}
texto {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}


iniciar {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
fin {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}

funcion {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
crear { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
como { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
leer { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
mostrar { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
raiz { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
potencia { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
sen { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
cos { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
tan { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
aleatorio { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
redondear { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
abs { return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
logn {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}

si {return token(yytext(), "SI", yyline, yycolumn);}
entonces {return token(yytext(), "ENTONCES", yyline, yycolumn);}
sino {return token(yytext(), "SINO", yyline, yycolumn);}

comparar {return token(yytext(), "COMPARAR", yyline, yycolumn);}
para {return token(yytext(), "PARA", yyline, yycolumn);}
hacer {return token(yytext(), "HACER", yyline, yycolumn);}

mientras {return token(yytext(), "MIENTRAS", yyline, yycolumn);}

para {return token(yytext(), "PARA", yyline, yycolumn);}

repetir {return token(yytext(), "REPETIR", yyline, yycolumn);}
cuando {return token(yytext(), "CUANDO", yyline, yycolumn);}

ciclar{ return token(yytext(), "CICLAR", yyline, yycolumn); }
desde {return token(yytext(), "DESDE", yyline, yycolumn);}
hasta {return token(yytext(), "HASTA", yyline, yycolumn);}
inc {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}




/* CADENA DE TEXTO*/
{cadenaTxt} {return token(yytext(), "CADENA_TXT", yyline, yycolumn);}

/* caracteres especiales */

"." {return token(yytext(), "PUNTO", yyline, yycolumn);}
"+" {return token(yytext(), "SUMA", yyline, yycolumn);}
"-" {return token(yytext(), "RESTA", yyline, yycolumn);}
"*" {return token(yytext(), "MULTIPLICACION", yyline, yycolumn);}
"/" {return token(yytext(), "DIVISION", yyline, yycolumn);}
"%" {return token(yytext(), "RESIDUO", yyline, yycolumn);}
"=" {return token(yytext(), "ASIGNACION", yyline, yycolumn);}
"==" {return token(yytext(), "IGUALQUE", yyline, yycolumn);}
">" {return token(yytext(), "MAYOR_QUE", yyline, yycolumn);}
"<" {return token(yytext(), "MENOR_QUE", yyline, yycolumn);}
">=" {return token(yytext(), "MAYOR_IG", yyline, yycolumn);}
"<=" {return token(yytext(), "MENOR_IG", yyline, yycolumn);}
"{" {return token(yytext(), "LLAVE_ABRE", yyline, yycolumn);}
"}" {return token(yytext(), "LLAVE_CIERRA", yyline, yycolumn);}
"(" {return token(yytext(), "PARENT_ABRE", yyline, yycolumn);}
")" {return token(yytext(), "PARENT_CIERRA", yyline, yycolumn);}
"&" {return token(yytext(), "AND", yyline, yycolumn);}
"|" {return token(yytext(), "OR", yyline, yycolumn);}
"!" {return token(yytext(), "NOT", yyline, yycolumn);}
";" {return token(yytext(), "PUNTO_COMA", yyline, yycolumn);}
":" {return token(yytext(), "DOS_PUNTOS", yyline, yycolumn);}
"," {return token(yytext(), "COMA", yyline, yycolumn);}
"_" {return token(yytext(), "GUION_BAJO", yyline, yycolumn);}
"#" {return token(yytext(), "INDIC_VAR", yyline, yycolumn);}
"$" {return token(yytext(), "INDIC_FUNC", yyline, yycolumn);}


/* Identificador */
{Identificador} { return token(yytext(), "IDENTIFICADOR", yyline, yycolumn); }
{IdentificadorInvalido} { return token(yytext(), "IDENTIFICADOR_INVA", yyline, yycolumn); }

/* Número */
{Numero} {return token(yytext(), "NUMERO", yyline, yycolumn);}
{NumeroMalFormado} { return token(yytext(), "NUMERO_INVA", yyline, yycolumn); }

/* Caracter no reconocido */
. { return token(yytext(), "SIMBOLO_INVA", yyline, yycolumn); }
