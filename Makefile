.PHONY : release install clean

OUT = delay
OBJ = main.o dtbuf.o time_ms.o
CFLAGS = -Wall -O3

release: delay

delay: $(OBJ)
	$(CC) $(CFLAGS) -o $(OUT) $(OBJ)

$(OBJ): dtbuf.h time_ms.h

fmt:
	indent --linux-style \
		--indent-level4 \
		--no-tabs \
		--format-all-comments \
		--braces-on-if-line \
		--space-after-cast \
		*.c *.h
	# fix indent breaking pointer alignment on some function signatures
	find -name '*.[ch]' -exec sed -i '/^[a-z].*(.*)$$/s/ \* / */' {} ';'

clean:
	rm -f $(OBJ) $(OUT)

install: release
	install $(OUT) $(DESTDIR)/usr/local/bin
