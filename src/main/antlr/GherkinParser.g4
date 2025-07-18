parser grammar GherkinParser;
options {
    tokenVocab = GherkinLexeren;
}
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


scenarioLine :  (SCENARIO | OUTLINE)? COLON other? ;
examplesLine :  EXAMPLES COLON other? ;
featureLine : FEATURE COLON other? ;
backGroundLine : BACKGROUND COLON other? ;
stepLine : (GIVEN | WHEN | THEN | AND | BUT | STAR) other? ;
ruleLine : RULE COLON other? ;
// needs to handle all forms of whitespace prior to the description
descriptionHelper : noline? (description noline+)* ;
description : other ;
languageLine : POUND LANGUAGE COLON ANY ;
featureDescHelper : noline? (featureDesc noline+)* ;
featureDesc : anything ;

keyword : BACKGROUND | EXAMPLES | FEATURE | OUTLINE | RULE | SCENARIO ;
other : ((ANY | keyword)
    (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | keyword)
    (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
  (ANY (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
  keyword;

anything: (ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN)
 (ATSIGN | ANY | AND | BUT | GIVEN | LANGUAGE | STAR | TAG | THEN | WHEN | COLON | keyword)*;
tagline : TAG+;

