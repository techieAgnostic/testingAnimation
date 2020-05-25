NAME=animation

ASSEMBLER=rgbasm
LINKER=rgblink
POSTPROC=rgbfix

SRC=./src
BUILD=./build
ENTRY=${SRC}/main.asm
ROM_OUTPUT=${BUILD}/${NAME}.gb
OBJECT_OUTPUT=${BUILD}/${NAME}.o
SYMFILE_OUTPUT=${BUILD}/${NAME}.sym

LICENSEE="tA"
OLDLIC="0x33"
MBC="0x00"
VERSION="0"
PAD="0xFF"
RAM="0x00"

PP_FLAGS=-c -f lhg -j -t ${NAME} -k ${LICENSEE} -l ${OLDLIC} -m ${MBC} -n ${VERSION} -p ${PAD} -r ${RAM}

all : ${ENTRY}
	${ASSEMBLER} -o ${OBJECT_OUTPUT} ${ENTRY} \
		&& ${LINKER} -o ${ROM_OUTPUT} -n ${SYMFILE_OUTPUT} ${OBJECT_OUTPUT} \
		&& ${POSTPROC} -v ${PP_FLAGS} ${ROM_OUTPUT}
