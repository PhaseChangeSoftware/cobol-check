package ai.phasechange.gherkin

import ai.phasechange.gherkin.ast.GherkinVisitor
import io.github.oshai.kotlinlogging.KotlinLogging
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.util.stream.Stream
import kotlin.io.path.nameWithoutExtension
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.MethodSource

private val log = KotlinLogging.logger {}

class GherkinParserTest {
    @ParameterizedTest
    @MethodSource("provideTestData")
    fun test(file: Path) {
        assertNotNull(file)
        val contents = file.toFile().readText()
        val parser = PhaseChangeGherkinParserImpl()
        val document = parser.parse(contents)
        /*tokens.tokens.forEach {
            println(it)
        }*/
        println(contents)
        assert( parser.errors().isEmpty()) {
            "Syntax errors:${parser.errors().joinToString("\n")}"
        }
        if (
            file.nameWithoutExtension != "incomplete_feature_3" &&
            file.nameWithoutExtension != "empty"
        ) {
            assertNotNull(document) { "Document is null for $file" }
        }
        //assertEquals(expected, output);
    }

    companion object {
        @JvmStatic
        fun provideTestData(): Stream<Path> {
            val classLoader = GherkinParserTest::class.java.classLoader
            return Files.list(Paths.get("src/test/resources/gherkin"))
        }
    }
}