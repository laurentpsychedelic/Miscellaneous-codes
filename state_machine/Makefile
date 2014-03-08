default: run

run: rebuild
	java -classpath src main.Main

rebuild: clean
	find . -type f -name \*.java -print0 | xargs -0 javac

clean:
	find . -type f -name \*.class -exec rm -v {} \;
