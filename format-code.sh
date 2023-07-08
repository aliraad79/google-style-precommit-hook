#!/usr/bin/env sh
mkdir -p .cache
cd .cache

JAVA_FORMAT_JAR_NAME=google-java-format-1.17.0-all-deps.jar

if [ ! -f $JAVA_FORMAT_JAR_NAME ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/v1.17.0/$JAVA_FORMAT_JAR_NAME"
    chmod 755 $JAVA_FORMAT_JAR_NAME
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo "Changed Files: "
echo $changed_java_files
echo "-------------"
java -jar .cache/$JAVA_FORMAT_JAR_NAME --replace $changed_java_files
