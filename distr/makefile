parsetest: parsetest.o y.tab.o lex.yy.o errormsg.o util.o
	cc -g -o parsetest parsetest.o y.tab.o lex.yy.o errormsg.o util.o

parsetest.o: parsetest.c errormsg.h util.h
	cc -g -c parsetest.c

y.tab.o: y.tab.c
	cc -g -c y.tab.c

y.tab.c: parser.y
	 yacc -o y.tab.c -dv parser.y

y.tab.h: y.tab.c
	echo "y.tab.h was created at the same time as y.tab.c"

errormsg.o: errormsg.c errormsg.h util.h
	cc -g -c errormsg.c

lex.yy.o: lex.yy.c y.tab.h errormsg.h util.h
	cc -g -c lex.yy.c

#lex.yy.c: lexer.lex
#	lex lexer.lex

util.o: util.c util.h
	cc -g -c util.c

output: parsetest parser.y
	for test in `ls testcases`; do \
	    echo "running test case $${test}"; \
		./$< testcases/$${test} 2> log; \
        test $${test} = "test3.prg" && diff log fail3 || (test $${test} = "test4.prg" && diff log fail4 || diff log success); \
	done

clean: 
	rm -f parsetest util.o parsetest.o lex.yy.o errormsg.o y.tab.c y.tab.h y.tab.o y.output
