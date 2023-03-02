CPATH=".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar"

rm -rf student-submission
rm -rf UnitTest.txt
rm -rf javacError.txt
git clone $1 student-submission
if [[ $? -eq 0 ]]
then
    echo 'Cloned repository successfully'
else
    echo 'Error cloning repository'
    exit 1
fi
cp student-submission/ListExamples.java ./
javac -cp $CPATH *.java 2>javacError.txt
if [[ $? -eq 0 ]]
then
    echo 'Compiled successfully'
else
    echo 'Error compiling'
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



