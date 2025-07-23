package ai.phasechange.gherkin

import ai.phasechange.gherkin.ast.GherkinDocument
import ai.phasechange.gherkin.ast.GherkinVisitor
import org.antlr.v4.runtime.CharStreams
import org.antlr.v4.runtime.CommonTokenStream
import org.antlr.v4.runtime.Lexer

class PhaseChangeGherkinParserImpl {
    private val errorListener = AntlrParserAccumulatingErrorListener()
    private fun getLexer(fileText: String): Lexer {
        val stream = CharStreams.fromString(fileText)
        val startLine = fileText.trimStart().substringBefore("\n")
        if (startLine.startsWith("#") && startLine.lowercase().contains("language")) {
            when {
                startLine.endsWith("ht") ->
                    return GherkinLexerht(stream)

                startLine.endsWith("em") ->
                    return GherkinLexerem(stream)

                startLine.endsWith("no") ->
                    return GherkinLexerno(stream)

                startLine.endsWith("en-lol") ->
                    return GherkinLexerlol(stream)

                startLine.endsWith("fr") ->
                    return GherkinLexerfr(stream)
            }
        }
        return GherkinLexeren(stream)
    }

    fun parse(fileText: String): GherkinDocument? {
        val lexer = getLexer(fileText)

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
        val visitor = GherkinVisitor()
        return visitor.visitGherkinDocument(ctx.gherkinDocument())
    }

    fun errors(): List<String> {
        return errorListener.messages
    }
}