grammar Gherkin;
startRule : gherkinDocument;
gherkinDocument : feature? EMPTY*? EOF ;

noline : EMPTY  ;
feature : noline* featureHeader (EMPTY background)? (EMPTY scenarioDefinition)* (EMPTY rule)* ;
featureHeader : (languageLine EMPTY)? tags? featureLine featureDescHelper ;

rule : noline* ruleHeader background? scenarioDefinition* ;
ruleHeader : tags? ruleLine descriptionHelper ;

background : noline* backGroundLine descriptionHelper step* ;

scenarioDefinition : noline* tags? scenario ;
scenario : scenarioLine descriptionHelper (step (EMPTY step)*)* examplesDefinition* ;

examplesDefinition : noline* tags? examplesLine descriptionHelper dataTable? ;

step : noline* stepLine (EMPTY stepArg)? ;
stepArg : (dataTable | docString) ;

dataTable : noline* TABLEROW (noline+ TABLEROW)* ;
docString : DOCSTRING1 | DOCSTRING2 | DOCSTRING3 ;
tags : noline* tagline (noline+ tagline)* noline+ ;


scenarioLine :  (SCENARIO | EXAMPLE) (OUTLINE)? COLON other? ;
examplesLine :  (SCENARIOS | EXAMPLES) COLON other? ;
featureLine : FEATURE COLON other? ;
backGroundLine : BACKGROUND COLON other? ;
stepLine : (GIVEN | WHEN | THEN | AND | BUT | STAR) other? ;
ruleLine : RULE COLON other? ;
// needs to handle all forms of whitespace prior to the description
descriptionHelper : noline? (description noline+)* ;
description : other ;
languageLine : '#' LANGUAGE ':' ANY ;
featureDescHelper : noline? (featureDesc noline+)* ;
featureDesc : anything ;

keyword : BACKGROUND | EXAMPLE | EXAMPLES | FEATURE | OUTLINE | RULE | SCENARIO | SCENARIOS ;
other : ((ANY | keyword)
    (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | keyword)
    (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
  (ANY (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
  keyword;

anything: (ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN)
 (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*;
tagline : TAG+;

//Lexer rules
TABLEROW : ('|'((~[|\r\n])|('\\\\|'))*)+(~[\\]'|')(~[|\r\n])*;
TAG: AT (ANY | '#')+ ;
STAR : '*' ;
AND : A N D ;
BACKGROUND : B A C K G R O U N D ;
BUT : B U T ;
EXAMPLE : E X A M P L E ;
EXAMPLES : E X A M P L E S ;
FEATURE : F E A T U R E ;
GIVEN : G I V E N ;
LANGUAGE : L A N G U A G E ;
OUTLINE : O U T L I N E ;
RULE : R U L E ;
SCENARIO : S C E N A R I O ;
SCENARIOS : S C E N A R I O S ;
THEN : T H E N ;
WHEN : W H E N ;

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