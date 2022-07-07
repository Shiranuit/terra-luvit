APP_FILES=$(shell find . -type f -name '*.lua')
BIN_ROOT=lit/luvi-binaries/$(shell uname -s)_$(shell uname -m)
LIT_VERSION=3.8.5

terra-luvit_TAG=$(shell git describe)
terra-luvit_ARCH=$(shell uname -s)_$(shell uname -m)

PREFIX?=/usr/local
PHONY?=test lint size trim lit

test: lit terra-luvit
	./luvi . -- tests/run.lua

cover: lit terra-luvit
	./luvi . -- -l luacov tests/run.lua

clean:
	git clean -dx -f


lit:
	curl -L https://github.com/luvit/lit/raw/$(LIT_VERSION)/get-lit.sh | sh

terra-luvit: lit $(APP_FILES)
	./lit make

install: terra-luvit lit
	mkdir -p $(PREFIX)/bin
	install terra-luvit $(PREFIX)/bin/
	install lit $(PREFIX)/bin/
	install luvi $(PREFIX)/bin/

uninstall:
	rm -f $(PREFIX)/bin/terra-luvit
	rm -f $(PREFIX)/bin/lit


tools/certdata.txt:
	curl https://hg.mozilla.org/mozilla-central/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt -o tools/certdata.txt

tools/certs.pem: tools/certdata.txt tools/convert_mozilla_certdata.go
	cd tools && go run convert_mozilla_certdata.go > certs.pem

tools/certs.dat: tools/certs.pem tools/convert.lua
	terra-luvit tools/convert

update-certs:	tools/certs.dat
	cp tools/certs.dat deps/tls/root_ca.dat


lint:
	find deps -name "*.lua" | xargs luacheck

size:
	find deps -type f -name '*.lua' | xargs  -I{} sh -c "luajit -bs {} - | echo \`wc -c\` {}" | sort -n

trim:
	find . -type f -name '*.lua' -print0 | xargs -0 perl -pi -e 's/ +$$//'

terra-luvit.tar.gz: terra-luvit lit README.markdown ChangeLog LICENSE.txt
	echo 'Copy `lit` and `terra-luvit` to somewhere in your path like /usr/local/bin/' > INSTALL
	tar -czf terra-luvit.tar.gz INSTALL README.markdown ChangeLog LICENSE.txt terra-luvit lit
	rm INSTALL

publish: terra-luvit.tar.gz
	github-release upload --user terra-luvit --repo terra-luvit --tag ${terra-luvit_TAG} \
	  --file terra-luvit.tar.gz --name terra-luvit-${LUVI_ARCH}.tar.gz
