package ai.phasechange.gherkin.ast

interface GherkinAst
interface GherkinVariableString : GherkinAst {
    val name: String
    val variables: List<String>?
}
abstract class AbstractGherkin : GherkinAst
