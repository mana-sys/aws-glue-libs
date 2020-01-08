PREFIX = /usr/local
.PHONY: install
install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp bin/glue* $(PREFIX)/bin/

.PHONY: uninstall
uninstall:
	rm -rf $(DESTDIR)$(PREFIX)/bin/gluepyspark $(DESTDIR)$(PREFIX)/bin/gluepytest $(DESTDIR)$(PREFIX)/bin/gluesparksubmit
