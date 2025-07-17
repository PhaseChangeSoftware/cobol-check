package ai.phasechange.gherkin

import GherkinParser
import com.sun.org.apache.xpath.internal.Arg
import io.github.oshai.kotlinlogging.KotlinLogging
import java.io.File
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.util.stream.Stream
import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

private val log = KotlinLogging.logger {}

class GherkinParserTest {
    @ParameterizedTest
    @MethodSource("provideTestData")
    fun test(file: Path) {
        assertNotNull(file)
        val contents = file.toFile().readText()
        PhaseChangeGherkinParserImpl().parse(contents)
        println(contents)
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