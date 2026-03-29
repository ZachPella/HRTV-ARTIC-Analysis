# HRTV Bioinformatics Pipeline

## Overview

This repository contains a bioinformatics pipeline for analyzing Heartland virus (HRTV) genomic data using Oxford Nanopore sequencing. The pipeline utilizes the ARTIC workflow for consensus genome assembly of the three HRTV segments: L (large), M (medium), and S (small).

## Background

Heartland virus is a segmented negative-sense RNA virus in the family Phenuiviridae. The genome consists of three segments:
- L segment (NC_024495)
- M segment (NC_024494)
- S segment (NC_024496)

## Repository Structure

```
├── README.md                           # This file
├── script.sh                          # Main analysis script
├── schemes/                           # ARTIC primer schemes
│   ├── HRTV_L/                       # L segment scheme
│   │   ├── HRTV_L.reference.fasta    # Reference genome (NC_024495)
│   │   ├── HRTV_L.reference.fasta.fai # Reference index
│   │   └── HRTV_L.scheme.bed         # Primer coordinates
│   ├── HRTV_M/                       # M segment scheme
│   │   ├── HRTV_M.reference.fasta    # Reference genome (NC_024494)
│   │   ├── HRTV_M.reference.fasta.fai # Reference index
│   │   └── HRTV_M.scheme.bed         # Primer coordinates
│   └── HRTV_S/                       # S segment scheme (primer design needed)
└── consensus_sequences/               # Example output consensus sequences
    ├── barcode03_HRTV_*_Lseg.consensus.fasta
    ├── barcode03_HRTV_*_Mseg.consensus.fasta
    └── barcode03_HRTV_*_Sseg.consensus.fasta
```

## Prerequisites

### Software Requirements

- **ARTIC pipeline**: For consensus genome assembly
  ```bash
  conda install -c bioconda artic
  ```
- **Medaka**: For consensus polishing with Oxford Nanopore data
  ```bash
  conda install -c bioconda medaka
  ```
- **Minimap2**: For read mapping
- **Samtools**: For BAM file manipulation

### Hardware Requirements

- Sufficient RAM for large FASTQ files (recommend 16GB+)
- Multi-core CPU for faster processing

## Usage

### Basic Workflow

1. **Prepare input data**:
   - Place demultiplexed FASTQ files in the reads directory
   - Ensure FASTQ files are basecalled and filtered

2. **Run the analysis**:
   ```bash
   bash script.sh
   ```

3. **Output files** will be generated in separate directories:
   - `analysis_Lseg/` - L segment analysis
   - `analysis_Mseg/` - M segment analysis  
   - `analysis_Sseg/` - S segment analysis

### Script Configuration

Edit the following variables in `script.sh`:

```bash
SCHEME_DIR=/path/to/artic/scheme                    # Primer scheme directory
READS_DIR=/path/to/reads                            # Input FASTQ directory
SAMPLE=your_sample_name                             # Sample identifier
ANALYSIS_DIR_*=/path/to/output                      # Output directories
```

### ARTIC Parameters

The pipeline uses the following ARTIC parameters:
- `--normalise 400`: Depth normalization to 400x coverage
- `--medaka`: Use Medaka for consensus polishing
- `--medaka-model r1041_e82_400bps_sup_v4.2.0`: Model for R10.4.1 flowcells

## Output Files

For each segment, the pipeline generates:

- `*.consensus.fasta`: Final consensus sequence
- `*.primertrimmed.rg.sorted.bam`: Primer-trimmed alignments
- `*.vcf`: Variant calls
- `*.variants.tab`: Tabular variant summary
- `*.coverage_mask.txt`: Coverage depth information

## Quality Control

### Coverage Assessment
- Minimum coverage depth: 20x recommended
- Review coverage plots and identify low-coverage regions
- Check for primer dropout or amplification failure

### Consensus Quality
- Review N content in consensus sequences
- Validate against reference sequences (NC_024495, NC_024494, NC_024496)
- Check for expected ORF structure

## Troubleshooting

### Common Issues

1. **Low coverage regions**:
   - Check primer efficiency
   - Review amplicon balance
   - Consider adjusting normalization parameters

2. **High N content**:
   - Insufficient read depth
   - Poor quality reads in specific regions
   - Primer binding issues

3. **Amplicon dropout**:
   - Primer degradation or design issues
   - Template quality problems
   - PCR bias

### Debug Commands

```bash
# Check read mapping statistics
samtools flagstat *.sorted.bam

# Examine coverage depth
samtools depth *.primertrimmed.rg.sorted.bam | awk '{print $3}' | sort -n

# Validate primer binding
samtools view *.sorted.bam | head -20
```

## Development Notes

### Current Status
- L and M segment schemes validated
- S segment scheme under development
- Pipeline tested with R10.4.1 flowcells

### Future Improvements
- Complete S segment primer design
- Add automated QC reporting
- Implement phylogenetic analysis module
- Add support for R9.4.1 flowcells

## References

1. McMullan, L.K., et al. (2012). "A new phlebovirus associated with severe febrile illness in Missouri." New England Journal of Medicine, 367(9), 834-841.
2. ARTIC Network. "Real-time molecular epidemiology for outbreak response." https://artic.network/
3. Oxford Nanopore Technologies. "Medaka: Sequence correction provided by ONT Research." https://github.com/nanoporetech/medaka

## Contact

For questions or issues regarding this pipeline, please contact the Fauver Lab.

## License

This pipeline is provided for research use. Please cite appropriate references when using this workflow in publications.
