lexer grammar GherkinLexerht;
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
// These have to be fragments to keep from disturbing the token order
fragment DESKRIPSYON: D E S K R I P S Y O N;
fragment DYAGRAM: D Y A G R A M ;
fragment PLAN: P L A N ;

//note: These must appear in this order, and any additional needed must be added at the end of the file
KARAKTERISTIK: K A R A K T E R I S T I K -> type(FEATURE);
MAK: M A K -> type(FEATURE);
FONKSYONALITE: F O N K S Y O N A L I T E -> type(FEATURE);
KONTEKS: K O N T EGRAVE K S -> type(BACKGROUND);
SENARYO: S E N A R Y O -> type(SCENARIO);
RULEHT: R U L E -> type(RULE) ;
OUTLINEHT: (PLAN | DYAGRAM) WS SENARYO -> type(OUTLINE);
OUTTWOHT: SENARYO WS DESKRIPSYON -> type(OUTLINE);
EGZANP: E G Z A N P -> type(EXAMPLES);
SIPOZE: S I P O Z E WS? K? E? -> type(GIVEN);
LE: L (E | EGRAVE) -> type(WHEN);
LESAA: L (E | EGRAVE) WS S A WS A -> type(THEN);
AKEPIE: A K -> type(AND);
EPI: E P I -> type(AND);
EH: E -> type(AND);
MEN: M E N -> type(BUT);

TABLEROW : ('|'((~[|\r\n])|('\\\\|'))*)+(~[\\]'|')(~[\r\n])*;
TAG: AT (ANY | '#')+ ;
STAR : '*' ;

EMPTY : ENDLINE ;
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
