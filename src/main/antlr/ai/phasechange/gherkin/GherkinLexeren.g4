lexer grammar GherkinLexeren;
@header {
  package ai.phasechange.gherkin;
}

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
ANDEN : A N D -> type(AND);
BACKGROUNDEN : B A C K G R O U N D -> type(BACKGROUND) ;
BUTEN : B U T -> type(BUT);
FEATUREEN: F E A T U R E -> type(FEATURE);
EXAMPLE : E X A M P L E -> type(SCENARIO);
EXAMPLESEN : E X A M P L E S -> type(EXAMPLES);
GIVENEN : G I V E N -> type(GIVEN);
OUTLINEEN : S C E N A R I O WS O U T L I N E -> type(OUTLINE);
RULEEN : R U L E -> type(RULE);
SCENARIOEN : S C E N A R I O -> type(SCENARIO) ;
SCENARIOS : S C E N A R I O S -> type(EXAMPLES);
TEMPLATE: S C E N A R I O WS T E M P L A T E -> type(OUTLINE);
THENEN : T H E N -> type(THEN);
WHENEN : W H E N -> type(WHEN);

TABLEROW : ('|'((~[|\r\n])|('\\\\|'))*)+(~[\\]'|')(~[\r\n])*;
TAG: AT (ANY | '#')+ ;
STAR : '*' ;
LT : '<' ;
GT : '>' ;
EMPTY : ENDLINE ;
fragment DOCSTRINGSEP1 : '"""' ;
fragment ESCAPE1 : '\\"\\"\\"';
DOCSTRING1 : WS? DOCSTRINGSEP1 (LT ANY GT)? ANY? WS? EMPTY (ESCAPE1 | '"' | ~["\\])*? EMPTY WS? DOCSTRINGSEP1;
fragment DOCSTRINGSEP2 : '\'\'\'' ;
fragment ESCAPE2 : '\\\'\\\'\\\'';
DOCSTRING2 : WS? DOCSTRINGSEP2 (LT ANY GT)? ANY? WS? EMPTY (ESCAPE2 | ~['\\])*? EMPTY WS? DOCSTRINGSEP2;
fragment DOCSTRINGSEP3 : '```' ;
fragment ESCAPE3 : '\\`\\`\\`';
DOCSTRING3 : WS? DOCSTRINGSEP3 (LT ANY GT)? ANY? WS? EMPTY (ESCAPE3 | ~['\\])*? EMPTY WS? DOCSTRINGSEP3;
POUND : '#' ;
COLON : ':' ;
ATSIGN : '@' ;
WS : [ \t]+ -> channel(HIDDEN);
COMMENT : POUND ~[\r\n]* -> channel(HIDDEN);
ANY: ~[ @#:\t\n\r<>]+ ;
fragment AT: '@' ;
// case insensitive chars
fragment A:('a'|'A');
fragment B:('b'|'B');
fragment C:('c'|'C');
fragment D:('d'|'D');
fragment E:('e'|'E');
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

