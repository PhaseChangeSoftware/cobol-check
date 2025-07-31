package ai.phasechange.gherkin.transpile

import ai.phasechange.gherkin.ast.*

class CutTranspiler : AbstractAstVisitor() {
    class VariableStore(
        val tagsList: List<GherkinTag>?,
        private val varMap: Map<String, List<String>>,
    ) {
        fun nthString(variable: String, index: Int): String {
            return varMap.getOrDefault(variable, emptyList())[index]
        }

        val rowIndices = varMap.values.first().indices
    }

    private val builder = StringBuilder()
    override fun visit(doc: GherkinDocument) {
        doc.feature?.also { visit(it) }
    }

    override fun visit(featureHeader: GherkinFeatureHeader) {
        featureHeader.featureLine.also { visit(it) }
        featureHeader.featureDescHelper.featureDescs?.forEach { visit(it) }
    }

    override fun visit(featureLine: GherkinFeatureLine) {
        builder.append("       TESTSUITE ")
        featureLine.other?.also {
            builder.append("'")
            builder.append(it.name)
            builder.append("'")
        }
        builder.append("\n")
    }

    override fun visit(featureDesc: GherkinFeatureDesc) {
        builder.append("      * ")
        builder.append(featureDesc.featureDesc.description)
        builder.append("\n")
    }

    override fun visit(scenario: GherkinScenario) {
        scenario.examplesDefinitions?.also { definitions ->
            // assume scenario has variables somewhere
            val varMap = processVariables(definitions)
            varMap.forEachIndexed { mapIndex, map ->
                for (idx in map.rowIndices) {
                    map.tagsList?.joinToString(" ") { it.tag }?.also {
                        builder.append("\n      *${it}: ")
                    }
                    visit(scenario.scenarioLine, map, mapIndex, idx)
                    visit(scenario.descriptionHelper, map, idx)
                    scenario.steps?.forEach { step ->
                        visit(step, map, idx)
                    }
                }
            }
        } ?: super.visit(scenario)
    }

    override fun visit(descriptionHelper: GherkinDescriptionHelper) {
        descriptionHelper.descriptions?.forEach { description ->
            builder.append("      * ${description.other.name}\n")
        }
    }

    private fun visit(descriptionHelper: GherkinDescriptionHelper, map: VariableStore, idx: Int) {
        descriptionHelper.descriptions?.forEach { description ->
            builder.append("      * ${subVariables(description.other, map, idx)}\n")
        }
    }

    private fun fetchDataRow(row: String): List<String> {
        val spl = row.split("|")
        return spl.subList(1, spl.size - 1)
    }

    private fun getTags(tags: GherkinTags): List<GherkinTag> {
        return tags.taglines.flatMap { it.tagline }
    }

    private fun processVariables(examples: List<GherkinExamplesDefinition>): List<VariableStore> {
        val ret = mutableListOf<VariableStore>()
        examples.map { example ->
            val tags = example.tags?.let { getTags(it) }
            example.dataTable?.also { dataTable ->
                val exampleMap = mutableMapOf<String, List<String>>()
                val rowList = dataTable.tableRows.map { row ->
                    fetchDataRow(row.name).map { it.trim() }
                }
                for (idx in rowList[0].indices) {
                    exampleMap[rowList[0][idx]] = rowList.subList(1, rowList.size).map { it[idx] }
                }
                ret.add(VariableStore(tags, exampleMap))
            }
        }
        return ret
    }

    private fun visit(scenarioLine: GherkinScenarioLine, variableStore: VariableStore, mapIndex: Int, idx: Int) {
        scenarioLine.other?.also {
            builder.append("\n       TESTCASE '")
            builder.append(subVariables(it, variableStore, idx))
            builder.append("${mapIndex}_$idx'\n")
        } ?: builder.append("\n      TESTCASE\n")
    }

    override fun visit(scenarioLine: GherkinScenarioLine) {
        scenarioLine.other?.also {
            builder.append("\n       TESTCASE '")
            builder.append(it.name)
            builder.append("'\n")
        }
    }

    private fun subVariables(other: GherkinVariableString, variableStore: VariableStore, idx: Int): String {
        var ret = other.name
        other.variables?.forEach { variable ->
            ret = ret.replace("<$variable>", variableStore.nthString(variable, idx))
        }
        return ret
    }

    private fun visit(step: GherkinStep, variableStore: VariableStore, idx: Int) {
        step.tags?.also {arg ->
            // parsing of tag specification goes here
            builder.append("      *${step.tags.taglines.forEach { tagline -> tagline.tagline.forEach { it.tag } }} ")
        }
        step.stepLine.other?.also { other ->
            builder.append("      *${step.stepLine.type.name} ")
            builder.append(subVariables(other, variableStore, idx))
            builder.append("\n")
        }
        step.stepArg?.also { arg ->
            arg.docString?.also { str ->
                splitDocstring(subVariables(str, variableStore, idx)).forEach {
                    builder.append("      * \"")
                    builder.append(it) // todo: case where string contains unescaped "
                    builder.append("\"\n")
                }
            }
            arg.dataTable?.also { dataTable ->
                dataTable.tableRows.forEach { row ->
                    builder.append("      * ")
                    fetchDataRow(subVariables(row, variableStore, idx)).forEach { column ->
                        builder.append("\"$column\", ") // todo: case where string contains "
                    }
                    builder.append("\n")
                }
            }
        }
        builder.append("\n")
    }

    private fun splitDocstring(docString: String): List<String> {
        val separatorIndex = docString.indexOfFirst { !it.isWhitespace() }
        val separator = docString.substring(separatorIndex, separatorIndex + 3)
        val stringToSplit = docString.replace(separator, "").let { str ->
            str.substring(0, str.lastIndexOf("\n")).substring(str.indexOf("\n") + 1)
        }
        return stringToSplit.split('\n').map {
            if (it.length > separatorIndex) it.substring(separatorIndex) else it
        }
    }
    override fun visit (step: GherkinStep) {
        step.tags?.also {
            visit(it)
            val outstring =  step.tags.taglines.flatMap { tagline -> tagline.tagline.map { t -> t.tag } }
            builder.append("      *${outstring.joinToString ( " " )} \n")
        }
        visit(step.stepLine)
        step.stepArg?.also { visit(it) }
    }
    override fun visit(stepLine: GherkinStepLine) {
        builder.append("      *")
        builder.append(stepLine.type.name)
        stepLine.other?.also {
            builder.append(" ")
            builder.append(it.name)
        }
        builder.append("\n")
    }

    override fun visit(stepArg: GherkinStepArg) {
        stepArg.docString?.also { str ->
            splitDocstring(str.name).forEach {
                builder.append("      * \"")
                builder.append(it) // todo: case where string contains unescaped "
                builder.append("\"\n")
            }
        }
        stepArg.dataTable?.also { dataTable ->
            dataTable.tableRows.forEach { row ->
                builder.append("      *")
                fetchDataRow(row.name).forEach { column ->
                    builder.append("\"$column\", ") // todo: case where string contains "
                }
                builder.append("\n")
            }
        }
    }


    fun output(): String {
        return builder.toString()
    }

}