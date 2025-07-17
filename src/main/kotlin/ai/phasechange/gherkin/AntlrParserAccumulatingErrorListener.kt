package ai.phasechange.gherkin


import io.github.oshai.kotlinlogging.KotlinLogging
import org.antlr.v4.runtime.BaseErrorListener
import org.antlr.v4.runtime.RecognitionException
import org.antlr.v4.runtime.Recognizer

private val log = KotlinLogging.logger {}

/**
 * [AntlrParserAccumulatingErrorListener] is an Antlr [BaseErrorListener] listener registered with Antlr,
 * which accumulates error [messages] during parsing, making them accessible after parsing has been completed.
 * After parsing, an application can check the [errorCount] property to determine if there were any parsing errors.
 * and accordingly report them up to User Interfaces
 *
 * @author [Anil Peres-da-Silva]
 */
class AntlrParserAccumulatingErrorListener : BaseErrorListener() {
    private val _messages = mutableListOf<String>()

    /**
     * List of individual parsing error messages generated during compilation. This allows programmatic
     * access to individual messages.
     */
    val messages: List<String>
        get() {
            return _messages
        }

    val errorCount: Int
        get() {
            return _messages.size
        }

    fun reset() {
        _messages.clear()
    }

    /**
     * An override of the Antlr Listener returns the error messages (if any)
     * to this listener class which aggregates / accumulates them
     * across the span of a complete program parse
     */
    override fun syntaxError(
        recognizer: Recognizer<*, *>?,
        offendingSymbol: Any?,
        line: Int,
        charPositionInLine: Int,
        msg: String?,
        e: RecognitionException?
    ) {
        "line $line:$charPositionInLine $msg".also {
            _messages.add(it)
            log.info { it }
        }
    }
}
