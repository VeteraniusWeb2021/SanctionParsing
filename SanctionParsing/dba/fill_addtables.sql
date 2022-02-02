
copy sanctions.country(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\country_utf-8.csv' (delimiter ';',format csv);
select * from sanctions.country;

copy sanctions.topics(code,label) from 
'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\data\data_for_tables\topics_utf-8.csv' (delimiter ';',format csv);
select * from sanctions.topics;
