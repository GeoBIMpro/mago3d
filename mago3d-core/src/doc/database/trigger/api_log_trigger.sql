drop trigger if exists api_log_insert_trigger on api_log;

CREATE OR REPLACE FUNCTION api_log_insert()
RETURNS TRIGGER AS $$
BEGIN
	IF( NEW.insert_date >= to_timestamp('20170101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20171231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2017 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20180101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20181231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2018 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20190101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20191231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2019 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20200101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20201231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2020 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20210101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20211231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2021 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20220101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20221231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2022 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20230101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20231231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2023 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20240101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20241231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2024 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20250101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20251231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2025 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20260101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20261231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2026 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20270101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20271231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2027 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20280101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20281231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2028 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20290101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20291231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2029 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20300101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20301231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2030 values (NEW.*);
	ELSIF( NEW.insert_date >= to_timestamp('20310101000000000000', 'YYYYMMDDHH24MISSUS') and NEW.insert_date <= to_timestamp('20311231235959999999', 'YYYYMMDDHH24MISSUS') ) THEN
		insert into api_log_2031 values (NEW.*);
	ELSE
		RAISE EXCEPTION 'Error in api_log_insert() : data out of range';
	END IF;
	RETURN NULL;
END;
$$
LANGUAGE PLPGSQL;

create trigger api_log_insert_trigger
	before insert on api_log
	for each row execute procedure api_log_insert();

