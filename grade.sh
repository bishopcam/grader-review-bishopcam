CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'
if [ $? -ne 0 ]; then
    echo 'Error cloning repository Try renaming your repository to 
    student-submission'
    exit 1
fi
cp student-submission/ListExamples.java ./
javac -cp $CPATH *.java 2>javacError.txt
if [ $? -ne 0 ]; then
    echo 'Error compiling tests'
    cat javacError.txt
    exit 1
fi
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > UnitTest.txt
for var in UnitTest.txt 
do
    if grep -q "OK" $var
    then
        echo "All tests passed"
    else
        cat $var
        echo "Some tests failed"
    fi
done
echo 'Finished running tests'



