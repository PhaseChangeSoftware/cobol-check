parser grammar GherkinParser;
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
WHEN,
TABLEROW,
TAG,
STAR,
EMPTY,
DOCSTRING1,
DOCSTRING2,
DOCSTRING3,
POUND,
COLON,
ATSIGN,
WS,
COMMENT,
ANY
}
startRule : gherkinDocument;
gherkinDocument : feature? EMPTY*? EOF ;

noline : EMPTY  ;
feature : noline* featureHeader (EMPTY background)? (EMPTY scenarioDefinition)* (EMPTY rule)* ;
featureHeader : tags? featureLine featureDescHelper ;

rule : noline* ruleHeader background? scenarioDefinition* ;
ruleHeader : tags? ruleLine descriptionHelper ;

background : noline* backGroundLine descriptionHelper step* ;

scenarioDefinition : noline* tags? (scenario | scenarioOutline) ;
scenario : scenarioLine descriptionHelper (step (EMPTY step)*)*;
scenarioOutline: scenarioOutlineLine outlineDescriptionHelper (outlineStep (EMPTY outlineStep)*)*  examplesDefinition+ ;
examplesDefinition : noline* tags? examplesLine descriptionHelper dataTable? ;

step : noline* stepLine (EMPTY stepArg)? ;
stepArg : (dataTable | docString) ;
outlineStep : noline* outlineStepLine (EMPTY stepArg) ;

dataTable : noline* TABLEROW (noline+ TABLEROW)* ;
docString : DOCSTRING1 | DOCSTRING2 | DOCSTRING3 ;
tags : noline* tagline (noline+ tagline)* noline+ ;

scenarioOutlineLine: OUTLINE COLON other? ;
scenarioLine :  (SCENARIO)? COLON other? ;
examplesLine :  EXAMPLES COLON other? ;
featureLine : FEATURE COLON other? ;
backGroundLine : BACKGROUND COLON other? ;
stepLine : (GIVEN | WHEN | THEN | AND | BUT | STAR) other? ;
outlineStepLine : (GIVEN | WHEN | THEN | AND | BUT | STAR) parameterizedText? ;
ruleLine : RULE COLON other? ;
// needs to handle all forms of whitespace prior to the description
descriptionHelper : noline? (description noline+)* ;
outlineDescriptionHelper: noline? (parameterizedText noline+)* ;
description : other ;
featureDescHelper : noline? (featureDesc noline+)* ;
featureDesc : anything ;

parameterizedText : VARIABLE | other ;
keyword : BACKGROUND | EXAMPLES | FEATURE | OUTLINE | RULE | SCENARIO ;
other : ((ANY | keyword)
    (ATSIGN | ANY | AND | BUT | GIVEN | STAR | TAG | THEN | WHEN | keyword)
    (ATSIGN | ANY | AND | BUT | GIVEN | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
  (ANY (ATSIGN | ANY | AND | BUT | GIVEN | STAR | TAG | THEN | WHEN | COLON | keyword)*) |
  keyword;

anything: (ANY | AND | BUT | GIVEN | STAR | TAG | THEN | WHEN)
 (ATSIGN | ANY | AND | BUT | GIVEN | STAR | TAG | THEN | WHEN | COLON | keyword)*;
tagline : TAG+;

