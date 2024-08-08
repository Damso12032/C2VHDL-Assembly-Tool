all: comp

comp.tab.c comp.tab.h:	comp.y
	bison  -t -v -d comp.y

lex.yy.c: lex.l comp.tab.h
	flex lex.l

comp: lex.yy.c comp.tab.c comp.tab.h
	gcc -o comp comp.tab.c lex.yy.c ts.c

clean:
	rm comp comp.tab.c lex.yy.c comp.tab.h comp.output

test1: all
	./comp "test1.c"
assembleur_code: all
		./comp "test1.c" | python extract_assembleur_code.py > ./asm.txt
test:assembleur_code
	python cross_compil.py > executable.txt
