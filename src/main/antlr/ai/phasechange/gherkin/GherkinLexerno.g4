lexer grammar GherkinLexerno;
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
ANDNO : O G -> type(AND);
BACKGROUNDNO : B A K G R U N N -> type(BACKGROUND) ;
BUTNO : M E N -> type(BUT);
FEATURENO: E G E N S K A P -> type(FEATURE);
EXAMPLE : E K S E M P E L -> type(SCENARIO);
EXAMPLESNO : E K S E M P L E R -> type(EXAMPLES);
GIVENNO : G I T T -> type(GIVEN);
OUTLINENO : A B S T R A K T WS S C E N A R I O -> type(OUTLINE);
RULENO : R E G E L -> type(RULE);
SCENARIONO : S C E N A R I O -> type(SCENARIO) ;
TEMPLATENO : S C E N A R I O M A L -> type(OUTLINE);
THENNO : S ANG -> type(THEN);
WHENNO : N ANG R -> type(WHEN);

TABLEROW : ('|'((~[|\r\n])|('\\\\|'))*)+(~[\\]'|')(~[\r\n])*;
TAG: AT (ANY | '#')+ ;
STAR : '*' ;
LT : '<' ;
GT : '>' ;
EMPTY : ENDLINE ;
fragment DOCSTRINGSEP1 : '"""' ;
fragment ESCAPE1 : '\\"\\"\\"';
DOCSTRING1 : WS? DOCSTRINGSEP1 LT? ANY? GT? WS? EMPTY (ESCAPE1 | '"' | ~["\\])*? EMPTY WS? DOCSTRINGSEP1;
fragment DOCSTRINGSEP2 : '\'\'\'' ;
fragment ESCAPE2 : '\\\'\\\'\\\'';
DOCSTRING2 : WS? DOCSTRINGSEP2 LT? ANY? GT? WS? EMPTY (ESCAPE2 | ~['\\])*? EMPTY WS? DOCSTRINGSEP2;
fragment DOCSTRINGSEP3 : '```' ;
fragment ESCAPE3 : '\\`\\`\\`';
DOCSTRING3 : WS? DOCSTRINGSEP3 LT? ANY? GT? WS? EMPTY (ESCAPE3 | ~['\\])*? EMPTY WS? DOCSTRINGSEP3;
POUND : '#' ;
COLON : ':' ;
ATSIGN : '@' ;
WS : [ \t]+ -> channel(HIDDEN);
COMMENT : POUND ~[\r\n]* -> channel(HIDDEN);
ANY: ~[ @#:\t\n\r<>]+ ;
fragment AT: '@' ;
// case insensitive chars
fragment A:('a'|'A');
fragment ANG : ('å' | 'Å');
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

