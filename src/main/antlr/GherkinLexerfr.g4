lexer grammar GherkinLexerfr;
tokens {
  AND,
  BACKGROUND,
  BUT,
  FEATURE,
  EXAMPLES,
  GIVEN,
  OUTLINE,
  RULE,
  SCENARIO,
  THEN,
  WHEN
}
//Lexer rules
fragment QUE: Q U (E | '\'') ;
fragment ETANT: (E | EACUTE) T A N T ;
fragment DONNE: D O N N EACUTE E? S? ;
ANDFR : E T (WS QUE)? -> type(AND);
BACKGROUNDFR : C O N T E X T E -> type(BACKGROUND) ;
BUTFR : M A I S (WS QUE)? -> type(BUT);
FEATUREFR: F O N C T I O N N A L I T EACUTE -> type(FEATURE);
EXAMPLE : E X E M P L E -> type(SCENARIO);
EXAMPLESFR : E X E M P L E S -> type(EXAMPLES);
GIVENFR : S O I T -> type(GIVEN);
GIVENFR2 : S A C H A N T (WS QUE)? -> type(GIVEN);
GIVENFR3 : ETANT (WS DONNE)? (WS QUE)? -> type(GIVEN);
OUTLINEFR : P L A N WS D U WS S C EACUTE N A R I O -> type(OUTLINE);
RULEFR : R EGRAVE G L E -> type(RULE);
SCENARIOFR : S C EACUTE N A R I O -> type(SCENARIO) ;
THENFR : A L O R S -> type(THEN);
THENFR2 : D O N C -> type(THEN);
WHENFR : Q U A N D -> type(WHEN);
WHENFR2 : L O R S QUE O? N? -> type(WHEN) ;

TABLEROW : ('|'((~[|\r\n])|('\\\\|'))*)+(~[\\]'|')(~[\r\n])*;
TAG: AT (ANY | '#')+ ;
STAR : '*' ;

EMPTY : ENDLINE ;
LANGUAGE : L A N G U A G E ;
fragment DOCSTRINGSEP1 : '"""' ;
fragment ESCAPE1 : '\\"\\"\\"';
DOCSTRING1 : WS? DOCSTRINGSEP1 ANY? WS? EMPTY (ESCAPE1 | '"' | ~["\\])*? EMPTY WS? DOCSTRINGSEP1;
fragment DOCSTRINGSEP2 : '\'\'\'' ;
fragment ESCAPE2 : '\\\'\\\'\\\'';
DOCSTRING2 : WS? DOCSTRINGSEP2 ANY? WS? EMPTY (ESCAPE2 | ~['\\])*? EMPTY WS? DOCSTRINGSEP2;
fragment DOCSTRINGSEP3 : '```' ;
fragment ESCAPE3 : '\\`\\`\\`';
DOCSTRING3 : WS? DOCSTRINGSEP3 ANY? WS? EMPTY (ESCAPE3 | ~['\\])*? EMPTY WS? DOCSTRINGSEP3;
POUND : '#' ;
COLON : ':' ;
ATSIGN : '@' ;
WS : [ \t]+ -> channel(HIDDEN);
COMMENT : POUND ~[\r\n]* -> channel(HIDDEN);
ANY: ~[ @#:\t\n\r]+ ;
fragment AT: '@' ;
// case insensitive chars
fragment A:('a'|'A');
fragment ANG : ('å' | 'Å');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
fragment EACUTE: ('é' | 'É');
fragment EGRAVE: ('è' | 'È');
fragment F:('f'|'F');
fragment G:('g'|'G');
fragment H:('h'|'H');
fragment I:('i'|'I');
fragment J:('j'|'J');
fragment K:('k'|'K');
fragment L:('l'|'L');
fragment M:('m'|'M');
fragment N:('n'|'N');
fragment O:('o'|'O');
fragment P:('p'|'P');
fragment Q:('q'|'Q');
fragment R:('r'|'R');
fragment S:('s'|'S');
fragment T:('t'|'T');
fragment U:('u'|'U');
fragment V:('v'|'V');
fragment W:('w'|'W');
fragment X:('x'|'X');
fragment Y:('y'|'Y');
fragment Z:('z'|'Z');
fragment ENDLINE:('\n' | '\r');

