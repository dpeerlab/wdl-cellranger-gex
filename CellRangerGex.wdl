version 1.0

import "modules/Count.wdl" as Count

workflow CellRangerGex {

    input {
        String sampleName
        String fastqName
        Array[File] inputFastq
        String referenceUrl

        Boolean includeIntrons
        Int? expectCells
        String? chemistry        

        Int numCores = 16
        Int memory = 128


        # docker-related
        String dockerRegistry
    }

    call Count.Count {
        input:
            sampleName = sampleName,
            fastqName = fastqName,
            inputFastq = inputFastq,
            referenceUrl = referenceUrl,
            includeIntrons = includeIntrons,
            expectCells = expectCells,
            numCores = numCores,
            memory = memory,
            dockerRegistry = dockerRegistry,
            chemistry = chemistry,
    }

    output {
        File webSummary = Count.webSummary
        File metricsSummary = Count.metricsSummary

        File bam = Count.bam
        File bai = Count.bai

        Array[File] rawFeatureBarcodeMatrix = Count.rawFeatureBarcodeMatrix
        Array[File] filteredFeatureBarcodeMatrix = Count.filteredFeatureBarcodeMatrix

        File rawFeatureBarcodeMatrixH5 = Count.rawFeatureBarcodeMatrixH5
        File filteredFeatureBarcodeMatrixH5 = Count.filteredFeatureBarcodeMatrixH5

        File perMoleculeInfo = Count.perMoleculeInfo

        File? outAnalysis = Count.outAnalysis

        File cloupe = Count.cloupe

        File pipestanceMeta = Count.pipestanceMeta
    }
}
