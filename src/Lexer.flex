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
CaracteresEsp = [-|.|,|;|:|$|@|?|*|¡|¿]
TerminadorDeLinea = \r|\n|\r\n
EntradaDeCaracter = [^\r\n]
EspacioEnBlanco = {TerminadorDeLinea} | [ \t\f]

cadenaTxt = \"[^\"]+\"

/* Comentario */
ComentarioDeUnaLinea = "@" {EntradaDeCaracter}* {TerminadorDeLinea}?
ComentarioMultilinea = @*@*@*([^*]|(@*[^*])|(@*@*[^*]))*@*@*@*
Comentario = {ComentarioDeUnaLinea}|{ComentarioMultilinea}


/* Identificador */
Letra = [A-Za-zñÑ]
Digito = [0-9]
Identificador = "#"{Letra}({Letra}|{Digito})*

IdentificadorInvalido =  ({CaracteresEsp}|{Letra})+ ({CaracteresEsp}|{Letra}) | {Letra}({Letra}|{Digito}|{CaracteresEsp})* 

/* Número */
Numero = {Digito}+ | (("+"|"-"){Digito}+("."{Digito}+)? | (("+"|"-"){Digito}+))
NumeroMalFormado =  \.{Digito}+[a-zA-Z_]+ | {Digito}+([a-zA-Z_]|{CaracteresEsp})+ | {Digito}+\.{Digito}*\.({Digito}|{CaracteresEsp})*
%%

/* Comentarios o espacios en blanco */
{Comentario}|{EspacioEnBlanco}|{ComentarioMultilinea} { /*Ignorar*/ }
  
  
/* palabras reservadas y tipos de datos*/
float {return token(yytext(), "TIPO DATO", yyline, yycolumn);}
entero {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}
bool {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}

cadena {return token(yytext(), "TIPO_DATO", yyline, yycolumn);}


iniciar {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
fin {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}

funcion {return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn);}
crear{ return token(yytext(), "PALABRA_RESERVADA", yyline, yycolumn); }


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
"/" {return token(yytext(), "DIAGONAL", yyline, yycolumn);}
"=" {return token(yytext(), "ASIGNACION", yyline, yycolumn);}
"==" {return token(yytext(), "IGUALQUE", yyline, yycolumn);}
">" {return token(yytext(), "MAYOR_QUE", yyline, yycolumn);}
"<" {return token(yytext(), "MENOR_QUE", yyline, yycolumn);}
">=" {return token(yytext(), "MAYOR_IG", yyline, yycolumn);}
"<=" {return token(yytext(), "MENOR_IG", yyline, yycolumn);}
"{" {return token(yytext(), "LLAVE_ABRE", yyline, yycolumn);}
"}" {return token(yytext(), "LLAVE_CIERRA", yyline, yycolumn);}
"(" {return token(yytext(), "PAR_ABRE", yyline, yycolumn);}
")" {return token(yytext(), "PAR_CIERRA", yyline, yycolumn);}
"!" {return token(yytext(), "ADMIRACION", yyline, yycolumn);}
and {return token(yytext(), "AND", yyline, yycolumn);}
or {return token(yytext(), "OR", yyline, yycolumn);}
not {return token(yytext(), "NOT", yyline, yycolumn);}
";" {return token(yytext(), "PUNTO_COMA", yyline, yycolumn);}
":" {return token(yytext(), "DOS_PUNTOS", yyline, yycolumn);}
"," {return token(yytext(), "COMA", yyline, yycolumn);}
"_" {return token(yytext(), "GUION_BAJO", yyline, yycolumn);}


/* Identificador */
{Identificador} { return token(yytext(), "IDENTIFICADOR", yyline, yycolumn); }
{IdentificadorInvalido} { return token(yytext(), "IDENTIFICADOR_INVA", yyline, yycolumn); }

/* Número */
{Numero} {return token(yytext(), "NUMERO", yyline, yycolumn);}
{NumeroMalFormado} { return token(yytext(), "NUMERO_INVA", yyline, yycolumn); }

/* Caracter no reconocido */
. { return token(yytext(), "SIMBOLO_INVA", yyline, yycolumn); }
