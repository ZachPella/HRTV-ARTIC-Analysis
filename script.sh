SCHEME_DIR=/home/fauverlab/artic/fieldbioinformatics_original/scheme
READS_DIR=/home/fauverlab/artic/fieldbioinformatics_original/analysis/HRTV_Run3_Sept2025/barcode03_nonhookworm
SAMPLE=barcode03_HRTV_and_sample11_minknow_basecalled_pass_all.unmapped

ANALYSIS_DIR_LSEG=/home/fauverlab/artic/fieldbioinformatics_original/analysis/HRTV_Run3_Sept2025/analysis_Lseg
mkdir -p ${ANALYSIS_DIR_LSEG}
ANALYSIS_DIR_MSEG=/home/fauverlab/artic/fieldbioinformatics_original/analysis/HRTV_Run3_Sept2025/analysis_Mseg
mkdir -p ${ANALYSIS_DIR_MSEG}
ANALYSIS_DIR_SSEG=/home/fauverlab/artic/fieldbioinformatics_original/analysis/HRTV_Run3_Sept2025/analysis_Sseg
mkdir -p ${ANALYSIS_DIR_SSEG}

cd ${ANALYSIS_DIR_LSEG}
artic minion \
	--scheme-directory ${SCHEME_DIR} \
	--read-file ${READS_DIR}/${SAMPLE}.fastq \
	--normalise 400 \
	--medaka \
	--medaka-model r1041_e82_400bps_sup_v4.2.0 \
	HRTV_L/V1 ${SAMPLE}_Lseg
	
cd ${ANALYSIS_DIR_MSEG}
artic minion \
	--scheme-directory ${SCHEME_DIR} \
	--read-file ${READS_DIR}/${SAMPLE}.fastq \
	--normalise 400 \
	--medaka \
	--medaka-model r1041_e82_400bps_sup_v4.2.0 \
	HRTV_M/V1 ${SAMPLE}_Mseg
	
cd ${ANALYSIS_DIR_SSEG}
artic minion \
	--scheme-directory ${SCHEME_DIR} \
	--read-file ${READS_DIR}/${SAMPLE}.fastq \
	--normalise 400 \
	--medaka \
	--medaka-model r1041_e82_400bps_sup_v4.2.0 \
	HRTV_S/V1 ${SAMPLE}_Sseg
	
	

