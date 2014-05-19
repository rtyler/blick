

agent: prep contrib/zeromq-ada/lib/static/libzmqAda.a
	pwd
	@echo "> Building the blick agent"
	gprbuild -P blick.gpr -XLIBRARY_TYPE=relocatable

contrib/zeromq-ada/lib/static/libzmqAda.a:
	$(MAKE) -C contrib/zeromq-ada compile


prep:
	@mkdir -p obj

clean:
	@echo "> Cleaning"
	rm -rf obj/*
	$(MAKE) -C contrib/zeromq-ada clean

.PHONY: clean agent prep
