CREATE DATABASE testdb
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.utf8'
    LC_CTYPE = 'English_United States.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

CREATE TABLE public.employee
(
    emp_id bigint NOT NULL,
    name character varying(100) COLLATE pg_catalog."default",
    department character varying(100) COLLATE pg_catalog."default",
    age character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT employee_pkey PRIMARY KEY (emp_id)
)

ALTER TABLE public.employee
    OWNER to postgres;