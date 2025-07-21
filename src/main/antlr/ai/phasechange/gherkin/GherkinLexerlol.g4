lexer grammar GherkinLexerlol;
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
ANDEN : A N -> type(AND);
BACKGROUNDEN : B '4' -> type(BACKGROUND) ;
BUTEN : B U T -> type(BUT);
FEATUREEN: O H WS H A I -> type(FEATURE);
EXAMPLESEN : E X A M P L Z -> type(EXAMPLES);
GIVENEN : I WS C A N WS H A Z -> type(GIVEN);
OUTLINEEN : M I S H U N WS S R S L Y -> type(OUTLINE);
RULEEN : R U L E -> type(RULE);
SCENARIOEN : M I S H U N -> type(SCENARIO) ;
THENEN : D E N -> type(THEN);
WHENNO : W E N -> type(WHEN);

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

