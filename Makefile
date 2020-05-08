NAME=animation

ASSEMBLER=rgbasm
LINKER=rgblink
POSTPROC=rgbfix

SRC=./src
BUILD=./build
ENTRY=${SRC}/main.asm
ROM_OUTPUT=${BUILD}/${NAME}.gb
OBJECT_OUTPUT=${BUILD}/${NAME}.o

all : ${ENTRY}
	${ASSEMBLER} -o ${OBJECT_OUTPUT} ${ENTRY} \
		&& ${LINKER} -o ${ROM_OUTPUT} -n ${NAME}.sym ${OBJECT_OUTPUT} \
		&& ${POSTPROC} -v -p 0 ${ROM_OUTPUT}
