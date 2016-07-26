--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: user; Tablespace: 
--

CREATE TABLE grades (
    id integer NOT NULL,
    student_github character varying(30),
    project_title character varying(30),
    grade integer
);


ALTER TABLE public.grades OWNER TO "user";

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE grades_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.grades_id_seq OWNER TO "user";

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE grades_id_seq OWNED BY grades.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: user; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    title character varying(30),
    description text,
    max_grade integer
);


ALTER TABLE public.projects OWNER TO "user";

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: user
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.projects_id_seq OWNER TO "user";

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: user
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: students; Type: TABLE; Schema: public; Owner: user; Tablespace: 
--

CREATE TABLE students (
    first_name character varying(30),
    last_name character varying(30),
    github character varying(30)
);


ALTER TABLE public.students OWNER TO "user";

--
-- Name: reportcardview; Type: VIEW; Schema: public; Owner: user
--

CREATE VIEW reportcardview AS
 SELECT students.first_name,
    students.last_name,
    projects.title,
    projects.max_grade,
    grades.grade
   FROM ((students
     JOIN grades ON (((students.github)::text = (grades.student_github)::text)))
     JOIN projects ON (((projects.title)::text = (grades.project_title)::text)));


ALTER TABLE public.reportcardview OWNER TO "user";

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY grades ALTER COLUMN id SET DEFAULT nextval('grades_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: user
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: user
--

COPY grades (id, student_github, project_title, grade) FROM stdin;
1	jhacks	Markov	10
2	jhacks	Blockly	2
3	sdevelops	Markov	50
4	sdevelops	Blockly	100
5	jhacks	foo bar project	88
6	sdevelops	project by stef	25
\.


--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('grades_id_seq', 6, true);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: user
--

COPY projects (id, title, description, max_grade) FROM stdin;
1	Markov	Tweets generated from Markov chains	50
2	Blockly	Programmatic Logic Puzzle Game	10
3	DatabaseFunStuff	I want to be the longeset string possible	75
4	project by stef	stef made us cookies	50
5	foo bar project	f u	1
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: user
--

SELECT pg_catalog.setval('projects_id_seq', 5, true);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: user
--

COPY students (first_name, last_name, github) FROM stdin;
Jane	Hacker	jhacks
Sarah	Developer	sdevelops
\.


--
-- Name: grades_pkey; Type: CONSTRAINT; Schema: public; Owner: user; Tablespace: 
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: user; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

