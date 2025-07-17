package ai.phasechange.gherkin

import GherkinLexer
import GherkinParser
import org.antlr.v4.runtime.CharStreams
import org.antlr.v4.runtime.CommonTokenStream

class PhaseChangeGherkinParserImpl() {
    private val errorListener = AntlrParserAccumulatingErrorListener()
    fun parse(fileText: String) {
        val lexer = GherkinLexer(CharStreams.fromString(fileText))

        // register an error listener, so that preprocessing stops on errors
        lexer.removeErrorListeners()
        lexer.addErrorListener(errorListener)

        // get a list of matched tokens
        val tokens = CommonTokenStream(lexer)

        // pass the tokens to the parser
        val parser = GherkinParser(tokens)

        // register an error listener, so that preprocessing stops on errors
        parser.removeErrorListeners()
        parser.addErrorListener(errorListener)

        // Reset error count from any previous uses
        errorListener.reset()
        // specify our entry point
        val ctx = parser.startRule()

    }
}