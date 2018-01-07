#!/bin/bash
cp ../*.js .

for i in *.js
do
   echo $i
   java -jar /opt/closure-compiler/build/compiler.jar \
	--compilation_level ADVANCED # \
#	--formatting=pretty_print \
	"$i" > "/tmp/$i"
done

for i in *.js
do
    cp "/tmp/$i" .
done
