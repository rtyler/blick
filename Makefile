

blick: prep contrib/zeromq-ada/lib/static/libzmqAda.a
	ADA_PROJECT_PATH=./contrib/aunit/lib/gnat gprbuild -P blick.gpr -XLIBRARY_TYPE=relocatable

contrib/zeromq-ada/lib/static/libzmqAda.a:
	$(MAKE) -C contrib/zeromq-ada compile

prep:
	@mkdir -p obj
	@mkdir -p bin

clean:
	@echo "> Cleaning"
	rm -rf obj bin
	$(MAKE) -C contrib/zeromq-ada clean

.PHONY: clean blick prep
