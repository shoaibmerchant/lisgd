PREFIX = /usr
SRC = lisgd.c
OBJ = ${SRC:.c=.o}
LDFLAGS = -g
LIBS = -linput -lm -lwayland-client

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

CPPFLAGS += -I${X11INC}
LIBS += -L${X11LIB} -lX11

all: options lisgd

options:
	@echo lisgd build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "CPPFLAGS = ${CPPFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "LIBS     = ${LIBS}"
	@echo "CC       = ${CC}"

.c.o:
	${CC} -c ${CFLAGS} ${CPPFLAGS} $<

${OBJ}: config.h

config.h:
	cp config.def.h $@

lisgd: ${OBJ}
	${CC} -o $@ ${OBJ} ${LDFLAGS} ${LIBS}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f lisgd ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/lisgd

	mkdir -p ${DESTDIR}${PREFIX}/share/man/man1
	cp lisgd.1 ${DESTDIR}${PREFIX}/share/man/man1
	chmod 755 ${DESTDIR}${PREFIX}/share/man/man1


clean:
	rm -f config.h lisgd.o lisgd
