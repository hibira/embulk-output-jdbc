SETLOCAL
SET PGPASSWORD=XXXXXXXX
"C:\Program Files\PostgreSQL\9.4\bin\psql.exe" -d testdb -U test_user -w -f test.sql
ENDLOCAL

CALL embulk run test-temp-schema-replace.yml

SETLOCAL
SET PGPASSWORD=XXXXXXXX
"C:\Program Files\PostgreSQL\9.4\bin\psql.exe" -d testdb -U test_user -w -c "SELECT * FROM embulk_output" > data/temp.txt
ENDLOCAL

echo "diff data/test-replace_expected.txt data/temp.txt"
diff data/test-replace_expected.txt data/temp.txt

IF "%ERRORLEVEL%" == "0" (ECHO "OK!") ELSE (ECHO "embulk-output-postgresql test-temp-schema-replace FAILED!")
