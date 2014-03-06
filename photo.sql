--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
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
-- Name: listing; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE listing (
    name text,
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.listing OWNER TO abhishek;

--
-- Name: listing_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE listing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.listing_id_seq OWNER TO abhishek;

--
-- Name: listing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE listing_id_seq OWNED BY listing.id;


--
-- Name: permission; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE permission (
    role text,
    "itemType" text,
    "itemId" text,
    read boolean,
    write boolean,
    destroy boolean,
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.permission OWNER TO abhishek;

--
-- Name: permission_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.permission_id_seq OWNER TO abhishek;

--
-- Name: permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE permission_id_seq OWNED BY permission.id;


--
-- Name: photo; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE photo (
    name text,
    size double precision,
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    likes integer,
    "listingId" integer,
    "isPrivate" boolean,
    "filePath" text,
    "thumbPath" text
);


ALTER TABLE public.photo OWNER TO abhishek;

--
-- Name: photo_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE photo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.photo_id_seq OWNER TO abhishek;

--
-- Name: photo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE photo_id_seq OWNED BY photo.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE role (
    name text,
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.role OWNER TO abhishek;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO abhishek;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE tag (
    label text,
    description text,
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.tag OWNER TO abhishek;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tag_id_seq OWNER TO abhishek;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE tag_id_seq OWNED BY tag.id;


--
-- Name: tagphot; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE tagphot (
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.tagphot OWNER TO abhishek;

--
-- Name: tagphot_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE tagphot_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tagphot_id_seq OWNER TO abhishek;

--
-- Name: tagphot_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE tagphot_id_seq OWNED BY tagphot.id;


--
-- Name: tagphoto; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE tagphoto (
    "tagId" integer,
    "photoId" integer,
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone
);


ALTER TABLE public.tagphoto OWNER TO abhishek;

--
-- Name: tagphoto_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE tagphoto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tagphoto_id_seq OWNER TO abhishek;

--
-- Name: tagphoto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE tagphoto_id_seq OWNED BY tagphoto.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: abhishek; Tablespace: 
--

CREATE TABLE "user" (
    username text,
    email text,
    fullname text,
    password text,
    id integer NOT NULL,
    "createdAt" timestamp with time zone,
    "updatedAt" timestamp with time zone,
    roles text,
    "sessionId" text
);


ALTER TABLE public."user" OWNER TO abhishek;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: abhishek
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO abhishek;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: abhishek
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY listing ALTER COLUMN id SET DEFAULT nextval('listing_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY permission ALTER COLUMN id SET DEFAULT nextval('permission_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY photo ALTER COLUMN id SET DEFAULT nextval('photo_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY tag ALTER COLUMN id SET DEFAULT nextval('tag_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY tagphot ALTER COLUMN id SET DEFAULT nextval('tagphot_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY tagphoto ALTER COLUMN id SET DEFAULT nextval('tagphoto_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- Data for Name: listing; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY listing (name, id, "createdAt", "updatedAt") FROM stdin;
random	1	2014-02-21 16:01:03+05:30	2014-02-21 16:01:03+05:30
art	2	2014-02-21 16:01:10+05:30	2014-02-21 16:01:10+05:30
science	3	2014-02-21 16:01:17+05:30	2014-02-21 16:01:17+05:30
technology	4	2014-03-05 18:06:21+05:30	2014-03-05 18:06:21+05:30
\.


--
-- Name: listing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('listing_id_seq', 4, true);


--
-- Data for Name: permission; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY permission (role, "itemType", "itemId", read, write, destroy, id, "createdAt", "updatedAt") FROM stdin;
ADMIN	listing	1	t	t	t	1	2014-02-21 17:23:20+05:30	2014-03-05 19:52:51+05:30
CONTENT_CONSUMER	listing	1	t	f	f	4	2014-02-21 17:24:31+05:30	2014-03-05 19:52:51+05:30
CONTENT_CREATOR	listing	1	t	t	f	7	2014-02-21 17:25:10+05:30	2014-03-05 19:52:51+05:30
CONTENT_COLLABORATOR	listing	1	t	t	t	10	2014-02-21 17:26:36+05:30	2014-03-05 19:52:51+05:30
ADMIN	listing	2	t	t	t	2	2014-02-21 17:23:29+05:30	2014-03-05 19:52:51+05:30
CONTENT_CONSUMER	listing	2	t	f	f	5	2014-02-21 17:24:40+05:30	2014-03-05 19:52:51+05:30
CONTENT_CREATOR	listing	2	t	t	f	8	2014-02-21 17:25:18+05:30	2014-03-05 19:52:51+05:30
CONTENT_COLLABORATOR	listing	2	f	f	f	11	2014-03-05 19:20:14+05:30	2014-03-05 19:52:51+05:30
ADMIN	listing	3	t	t	t	3	2014-02-21 17:23:35+05:30	2014-03-05 19:52:51+05:30
CONTENT_CONSUMER	listing	3	t	f	f	6	2014-02-21 17:24:47+05:30	2014-03-05 19:52:51+05:30
CONTENT_CREATOR	listing	3	t	t	f	9	2014-02-21 17:25:29+05:30	2014-03-05 19:52:51+05:30
CONTENT_COLLABORATOR	listing	3	f	f	f	12	2014-03-05 19:20:14+05:30	2014-03-05 19:52:51+05:30
ADMIN	listing	4	t	t	t	13	2014-03-05 19:20:14+05:30	2014-03-05 19:52:51+05:30
CONTENT_CONSUMER	listing	4	t	f	f	14	2014-03-05 19:20:14+05:30	2014-03-05 19:52:51+05:30
CONTENT_CREATOR	listing	4	f	f	f	15	2014-03-05 19:20:14+05:30	2014-03-05 19:52:51+05:30
CONTENT_COLLABORATOR	listing	4	t	t	f	16	2014-03-05 19:20:14+05:30	2014-03-05 19:52:51+05:30
\.


--
-- Name: permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('permission_id_seq', 16, true);


--
-- Data for Name: photo; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY photo (name, size, id, "createdAt", "updatedAt", likes, "listingId", "isPrivate", "filePath", "thumbPath") FROM stdin;
109505e0-a3a5-11e3-bc65-fdfc15838e11.png	25328	90	2014-03-04 19:28:29+05:30	2014-03-04 19:28:29+05:30	0	3	f	/rest/api/photo/p/fullSize/3/109505e0-a3a5-11e3-bc65-fdfc15838e11.png	/rest/api/photo/p/thumb/3/Thumb_109505e0-a3a5-11e3-bc65-fdfc15838e11.png
10952cf0-a3a5-11e3-bc65-fdfc15838e11.png	1152499	91	2014-03-04 19:28:29+05:30	2014-03-04 19:28:29+05:30	0	3	f	/rest/api/photo/p/fullSize/3/10952cf0-a3a5-11e3-bc65-fdfc15838e11.png	/rest/api/photo/p/thumb/3/Thumb_10952cf0-a3a5-11e3-bc65-fdfc15838e11.png
2206d010-a3a5-11e3-bc65-fdfc15838e11.png	78862	92	2014-03-04 19:28:58+05:30	2014-03-04 19:28:58+05:30	0	3	f	/rest/api/photo/p/fullSize/3/2206d010-a3a5-11e3-bc65-fdfc15838e11.png	/rest/api/photo/p/thumb/3/Thumb_2206d010-a3a5-11e3-bc65-fdfc15838e11.png
6ed28ab2-a3a5-11e3-bc65-fdfc15838e11.png	81644	93	2014-03-04 19:31:07+05:30	2014-03-04 19:31:07+05:30	0	3	f	/rest/api/photo/p/fullSize/3/6ed28ab2-a3a5-11e3-bc65-fdfc15838e11.png	/rest/api/photo/p/thumb/3/Thumb_6ed28ab2-a3a5-11e3-bc65-fdfc15838e11.png
6ed28ab1-a3a5-11e3-bc65-fdfc15838e11.png	74633	95	2014-03-04 19:31:07+05:30	2014-03-04 19:31:07+05:30	0	3	f	/rest/api/photo/p/fullSize/3/6ed28ab1-a3a5-11e3-bc65-fdfc15838e11.png	/rest/api/photo/p/thumb/3/Thumb_6ed28ab1-a3a5-11e3-bc65-fdfc15838e11.png
1cc24b70-a3aa-11e3-892a-2d370e21e307.png	25328	101	2014-03-04 20:04:37+05:30	2014-03-04 20:04:37+05:30	0	1	f	/rest/api/photo/p/fullSize/1/1cc24b70-a3aa-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/1/Thumb_1cc24b70-a3aa-11e3-892a-2d370e21e307.png
1cc27280-a3aa-11e3-892a-2d370e21e307.png	120276	102	2014-03-04 20:04:37+05:30	2014-03-04 20:04:37+05:30	0	1	f	/rest/api/photo/p/fullSize/1/1cc27280-a3aa-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/1/Thumb_1cc27280-a3aa-11e3-892a-2d370e21e307.png
1cc24b71-a3aa-11e3-892a-2d370e21e307.png	285888	103	2014-03-04 20:04:37+05:30	2014-03-04 20:04:37+05:30	0	1	f	/rest/api/photo/p/fullSize/1/1cc24b71-a3aa-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/1/Thumb_1cc24b71-a3aa-11e3-892a-2d370e21e307.png
2e175e81-a3ad-11e3-892a-2d370e21e307.png	76773	108	2014-03-04 20:26:36+05:30	2014-03-04 20:26:47+05:30	1	2	f	/rest/api/photo/p/fullSize/2/2e175e81-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e175e81-a3ad-11e3-892a-2d370e21e307.png
3725f890-a3aa-11e3-892a-2d370e21e307.png	86567	105	2014-03-04 20:05:21+05:30	2014-03-04 21:03:10+05:30	2	1	f	/rest/api/photo/p/fullSize/1/3725f890-a3aa-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/1/Thumb_3725f890-a3aa-11e3-892a-2d370e21e307.png
b7530a41-a3a9-11e3-892a-2d370e21e307.png	291934	100	2014-03-04 20:01:47+05:30	2014-03-05 21:09:12+05:30	2	3	f	/rest/api/photo/p/fullSize/3/b7530a41-a3a9-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/3/Thumb_b7530a41-a3a9-11e3-892a-2d370e21e307.png
31583900-a3aa-11e3-892a-2d370e21e307.png	25328	104	2014-03-04 20:05:12+05:30	2014-03-05 19:53:46+05:30	8	1	f	/rest/api/photo/p/fullSize/1/31583900-a3aa-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/1/Thumb_31583900-a3aa-11e3-892a-2d370e21e307.png
af521700-a3a9-11e3-892a-2d370e21e307.png	74633	97	2014-03-04 20:01:34+05:30	2014-03-05 21:09:08+05:30	1	3	f	/rest/api/photo/p/fullSize/3/af521700-a3a9-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/3/Thumb_af521700-a3a9-11e3-892a-2d370e21e307.png
b7530a40-a3a9-11e3-892a-2d370e21e307.png	25328	99	2014-03-04 20:01:47+05:30	2014-03-05 21:09:26+05:30	6	3	f	/rest/api/photo/p/fullSize/3/b7530a40-a3a9-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/3/Thumb_b7530a40-a3a9-11e3-892a-2d370e21e307.png
280bd2a0-a3ad-11e3-892a-2d370e21e307.png	222780	106	2014-03-04 20:26:24+05:30	2014-03-04 20:26:24+05:30	0	2	f	/rest/api/photo/p/fullSize/2/280bd2a0-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_280bd2a0-a3ad-11e3-892a-2d370e21e307.png
2e175e80-a3ad-11e3-892a-2d370e21e307.png	57342	107	2014-03-04 20:26:35+05:30	2014-03-04 20:26:35+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e175e80-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e175e80-a3ad-11e3-892a-2d370e21e307.png
2e178596-a3ad-11e3-892a-2d370e21e307.png	66265	109	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e178596-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178596-a3ad-11e3-892a-2d370e21e307.png
2e178591-a3ad-11e3-892a-2d370e21e307.png	59835	110	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e178591-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178591-a3ad-11e3-892a-2d370e21e307.png
af523e11-a3a9-11e3-892a-2d370e21e307.png	92013	98	2014-03-04 20:01:34+05:30	2014-03-05 21:09:17+05:30	1	3	f	/rest/api/photo/p/fullSize/3/af523e11-a3a9-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/3/Thumb_af523e11-a3a9-11e3-892a-2d370e21e307.png
6ed28ab0-a3a5-11e3-bc65-fdfc15838e11.png	92013	94	2014-03-04 19:31:07+05:30	2014-03-05 21:09:19+05:30	1	3	f	/rest/api/photo/p/fullSize/3/6ed28ab0-a3a5-11e3-bc65-fdfc15838e11.png	/rest/api/photo/p/thumb/3/Thumb_6ed28ab0-a3a5-11e3-bc65-fdfc15838e11.png
af523e10-a3a9-11e3-892a-2d370e21e307.png	81644	96	2014-03-04 20:01:34+05:30	2014-03-05 21:09:21+05:30	3	3	f	/rest/api/photo/p/fullSize/3/af523e10-a3a9-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/3/Thumb_af523e10-a3a9-11e3-892a-2d370e21e307.png
2e178590-a3ad-11e3-892a-2d370e21e307.png	78331	111	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e178590-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178590-a3ad-11e3-892a-2d370e21e307.png
2e178593-a3ad-11e3-892a-2d370e21e307.png	59686	113	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e178593-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178593-a3ad-11e3-892a-2d370e21e307.png
2e178598-a3ad-11e3-892a-2d370e21e307.png	59474	117	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e178598-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178598-a3ad-11e3-892a-2d370e21e307.png
2e17aca2-a3ad-11e3-892a-2d370e21e307.png	81644	119	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e17aca2-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e17aca2-a3ad-11e3-892a-2d370e21e307.png
2e17aca1-a3ad-11e3-892a-2d370e21e307.png	74633	121	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e17aca1-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e17aca1-a3ad-11e3-892a-2d370e21e307.png
2e178595-a3ad-11e3-892a-2d370e21e307.png	76476	115	2014-03-04 20:26:36+05:30	2014-03-04 20:26:53+05:30	1	2	f	/rest/api/photo/p/fullSize/2/2e178595-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178595-a3ad-11e3-892a-2d370e21e307.png
2e178592-a3ad-11e3-892a-2d370e21e307.png	62325	112	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e178592-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178592-a3ad-11e3-892a-2d370e21e307.png
2e178594-a3ad-11e3-892a-2d370e21e307.png	73525	114	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e178594-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178594-a3ad-11e3-892a-2d370e21e307.png
2e17aca0-a3ad-11e3-892a-2d370e21e307.png	57823	120	2014-03-04 20:26:36+05:30	2014-03-04 20:26:36+05:30	0	2	f	/rest/api/photo/p/fullSize/2/2e17aca0-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e17aca0-a3ad-11e3-892a-2d370e21e307.png
cb270750-a46d-11e3-967d-6f8e6bd09add.png	1152499	130	2014-03-05 19:25:22+05:30	2014-03-05 19:29:51+05:30	1	4	f	/rest/api/photo/p/fullSize/4/cb270750-a46d-11e3-967d-6f8e6bd09add.png	/rest/api/photo/p/thumb/4/Thumb_cb270750-a46d-11e3-967d-6f8e6bd09add.png
71f11673-a46e-11e3-967d-6f8e6bd09add.png	86567	131	2014-03-05 19:30:02+05:30	2014-03-05 19:30:02+05:30	0	4	f	/rest/api/photo/p/fullSize/4/71f11673-a46e-11e3-967d-6f8e6bd09add.png	/rest/api/photo/p/thumb/4/Thumb_71f11673-a46e-11e3-967d-6f8e6bd09add.png
2e178597-a3ad-11e3-892a-2d370e21e307.png	64819	116	2014-03-04 20:26:36+05:30	2014-03-04 20:27:00+05:30	3	2	f	/rest/api/photo/p/fullSize/2/2e178597-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e178597-a3ad-11e3-892a-2d370e21e307.png
71f11671-a46e-11e3-967d-6f8e6bd09add.png	108350	132	2014-03-05 19:30:02+05:30	2014-03-05 19:30:02+05:30	0	4	f	/rest/api/photo/p/fullSize/4/71f11671-a46e-11e3-967d-6f8e6bd09add.png	/rest/api/photo/p/thumb/4/Thumb_71f11671-a46e-11e3-967d-6f8e6bd09add.png
71f11670-a46e-11e3-967d-6f8e6bd09add.png	85233	133	2014-03-05 19:30:02+05:30	2014-03-05 19:30:02+05:30	0	4	f	/rest/api/photo/p/fullSize/4/71f11670-a46e-11e3-967d-6f8e6bd09add.png	/rest/api/photo/p/thumb/4/Thumb_71f11670-a46e-11e3-967d-6f8e6bd09add.png
71f11674-a46e-11e3-967d-6f8e6bd09add.png	1152499	134	2014-03-05 19:30:02+05:30	2014-03-05 19:30:02+05:30	0	4	f	/rest/api/photo/p/fullSize/4/71f11674-a46e-11e3-967d-6f8e6bd09add.png	/rest/api/photo/p/thumb/4/Thumb_71f11674-a46e-11e3-967d-6f8e6bd09add.png
9b5b2460-a3b0-11e3-892a-2d370e21e307.png	76773	122	2014-03-04 20:51:06+05:30	2014-03-04 20:51:09+05:30	1	1	f	/rest/api/photo/p/fullSize/1/9b5b2460-a3b0-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/1/Thumb_9b5b2460-a3b0-11e3-892a-2d370e21e307.png
2e17aca3-a3ad-11e3-892a-2d370e21e307.png	92013	118	2014-03-04 20:26:36+05:30	2014-03-04 21:02:20+05:30	4	2	f	/rest/api/photo/p/fullSize/2/2e17aca3-a3ad-11e3-892a-2d370e21e307.png	/rest/api/photo/p/thumb/2/Thumb_2e17aca3-a3ad-11e3-892a-2d370e21e307.png
54408eb0-a3b2-11e3-8760-55e535c99e8a.png	66188	123	2014-03-04 21:03:26+05:30	2014-03-04 21:03:26+05:30	0	1	f	/rest/api/photo/p/fullSize/1/54408eb0-a3b2-11e3-8760-55e535c99e8a.png	/rest/api/photo/p/thumb/1/Thumb_54408eb0-a3b2-11e3-8760-55e535c99e8a.png
71f11672-a46e-11e3-967d-6f8e6bd09add.png	117957	135	2014-03-05 19:30:02+05:30	2014-03-05 19:30:02+05:30	0	4	f	/rest/api/photo/p/fullSize/4/71f11672-a46e-11e3-967d-6f8e6bd09add.png	/rest/api/photo/p/thumb/4/Thumb_71f11672-a46e-11e3-967d-6f8e6bd09add.png
d9c043d0-a472-11e3-967d-6f8e6bd09add.jpg	129881	136	2014-03-05 20:01:33+05:30	2014-03-05 21:09:14+05:30	1	3	f	/rest/api/photo/p/fullSize/3/d9c043d0-a472-11e3-967d-6f8e6bd09add.jpg	/rest/api/photo/p/thumb/3/Thumb_d9c043d0-a472-11e3-967d-6f8e6bd09add.jpg
5a809810-a3b2-11e3-8760-55e535c99e8a.png	2364808	124	2014-03-04 21:03:37+05:30	2014-03-04 21:32:45+05:30	4	1	f	/rest/api/photo/p/fullSize/1/5a809810-a3b2-11e3-8760-55e535c99e8a.png	/rest/api/photo/p/thumb/1/Thumb_5a809810-a3b2-11e3-8760-55e535c99e8a.png
834e29c1-a3b6-11e3-8760-55e535c99e8a.png	66188	125	2014-03-04 21:33:23+05:30	2014-03-04 21:33:23+05:30	0	1	f	/rest/api/photo/p/fullSize/1/834e29c1-a3b6-11e3-8760-55e535c99e8a.png	/rest/api/photo/p/thumb/1/Thumb_834e29c1-a3b6-11e3-8760-55e535c99e8a.png
834e29c0-a3b6-11e3-8760-55e535c99e8a.png	75079	126	2014-03-04 21:33:23+05:30	2014-03-04 21:33:23+05:30	0	1	f	/rest/api/photo/p/fullSize/1/834e29c0-a3b6-11e3-8760-55e535c99e8a.png	/rest/api/photo/p/thumb/1/Thumb_834e29c0-a3b6-11e3-8760-55e535c99e8a.png
834e29c3-a3b6-11e3-8760-55e535c99e8a.png	89691	127	2014-03-04 21:33:23+05:30	2014-03-04 21:33:23+05:30	0	1	f	/rest/api/photo/p/fullSize/1/834e29c3-a3b6-11e3-8760-55e535c99e8a.png	/rest/api/photo/p/thumb/1/Thumb_834e29c3-a3b6-11e3-8760-55e535c99e8a.png
834e29c2-a3b6-11e3-8760-55e535c99e8a.png	1152499	128	2014-03-04 21:33:23+05:30	2014-03-04 21:33:23+05:30	0	1	f	/rest/api/photo/p/fullSize/1/834e29c2-a3b6-11e3-8760-55e535c99e8a.png	/rest/api/photo/p/thumb/1/Thumb_834e29c2-a3b6-11e3-8760-55e535c99e8a.png
cb26e040-a46d-11e3-967d-6f8e6bd09add.png	25328	129	2014-03-05 19:25:22+05:30	2014-03-05 19:25:22+05:30	0	4	f	/rest/api/photo/p/fullSize/4/cb26e040-a46d-11e3-967d-6f8e6bd09add.png	/rest/api/photo/p/thumb/4/Thumb_cb26e040-a46d-11e3-967d-6f8e6bd09add.png
61f45050-a47f-11e3-8d69-05b3b39ae88e.png	25328	137	2014-03-05 21:31:16+05:30	2014-03-05 21:31:16+05:30	0	4	f	/rest/api/photo/p/fullSize/4/61f45050-a47f-11e3-8d69-05b3b39ae88e.png	/rest/api/photo/p/thumb/4/Thumb_61f45050-a47f-11e3-8d69-05b3b39ae88e.png
61f45052-a47f-11e3-8d69-05b3b39ae88e.png	291934	138	2014-03-05 21:31:16+05:30	2014-03-05 21:31:16+05:30	0	4	f	/rest/api/photo/p/fullSize/4/61f45052-a47f-11e3-8d69-05b3b39ae88e.png	/rest/api/photo/p/thumb/4/Thumb_61f45052-a47f-11e3-8d69-05b3b39ae88e.png
61f45051-a47f-11e3-8d69-05b3b39ae88e.png	1152499	139	2014-03-05 21:31:16+05:30	2014-03-05 21:31:16+05:30	0	4	f	/rest/api/photo/p/fullSize/4/61f45051-a47f-11e3-8d69-05b3b39ae88e.png	/rest/api/photo/p/thumb/4/Thumb_61f45051-a47f-11e3-8d69-05b3b39ae88e.png
\.


--
-- Name: photo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('photo_id_seq', 139, true);


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY role (name, id, "createdAt", "updatedAt") FROM stdin;
ADMIN	1	2014-02-21 16:12:47+05:30	2014-02-21 16:12:47+05:30
CONTENT_CONSUMER	2	2014-02-21 16:13:27+05:30	2014-02-21 16:13:27+05:30
CONTENT_CREATOR	3	2014-02-21 16:13:41+05:30	2014-02-21 16:13:41+05:30
CONTENT_COLLABORATOR	4	2014-02-21 16:13:56+05:30	2014-02-21 16:13:56+05:30
\.


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('role_id_seq', 4, true);


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY tag (label, description, id, "createdAt", "updatedAt") FROM stdin;
Doggy		70	2014-03-05 21:06:40+05:30	2014-03-05 21:06:40+05:30
Cute		71	2014-03-05 21:06:40+05:30	2014-03-05 21:06:40+05:30
windows		72	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
scree		73	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
blue		74	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
black		75	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
 Hi		76	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
Hello		77	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
 Khaana		78	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
 Kha		79	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
Jaana		80	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
 Ke		81	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
Ke		82	2014-03-05 21:31:36+05:30	2014-03-05 21:31:36+05:30
\.


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('tag_id_seq', 82, true);


--
-- Data for Name: tagphot; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY tagphot (id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- Name: tagphot_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('tagphot_id_seq', 1, false);


--
-- Data for Name: tagphoto; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY tagphoto ("tagId", "photoId", id, "createdAt", "updatedAt") FROM stdin;
70	136	96	2014-03-05 21:06:41+05:30	2014-03-05 21:06:41+05:30
71	136	97	2014-03-05 21:06:41+05:30	2014-03-05 21:06:41+05:30
72	99	98	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
74	99	99	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
75	99	100	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
73	99	101	2014-03-05 21:07:19+05:30	2014-03-05 21:07:19+05:30
72	100	102	2014-03-05 21:08:15+05:30	2014-03-05 21:08:15+05:30
72	96	103	2014-03-05 21:08:22+05:30	2014-03-05 21:08:22+05:30
76	97	104	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
77	97	105	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
80	97	106	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
78	97	107	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
81	97	108	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
79	97	109	2014-03-05 21:08:37+05:30	2014-03-05 21:08:37+05:30
71	139	110	2014-03-05 21:31:36+05:30	2014-03-05 21:31:36+05:30
82	139	111	2014-03-05 21:31:36+05:30	2014-03-05 21:31:36+05:30
\.


--
-- Name: tagphoto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('tagphoto_id_seq', 111, true);


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: abhishek
--

COPY "user" (username, email, fullname, password, id, "createdAt", "updatedAt", roles, "sessionId") FROM stdin;
abhi	abhishek@webintensive.com	AbhishekGupta	abhi123	4	2014-02-21 17:17:45+05:30	2014-02-21 17:17:45+05:30	["ADMIN"]	\N
ravi	ravi@webintensive.com	Ravi Gupta	abhi123	5	2014-02-21 17:18:24+05:30	2014-02-21 17:18:24+05:30	["CONTENT_CONSUMER"]	\N
kunal	kunal@webintensive.com	Kunal Gupta	111	6	2014-02-21 17:18:58+05:30	2014-02-21 17:18:58+05:30	["CONTENT_CREATOR"]	\N
praveen	prav@webintensive.com	Praveen Gupta	111	7	2014-02-21 17:20:18+05:30	2014-02-21 17:20:18+05:30	["CONTENT_COLLABORATOR","CONTENT_CONSUMER"]	\N
praveen2	prav2@webintensive.com	Praveen Gupta	111	8	2014-02-21 18:13:56+05:30	2014-02-21 18:13:56+05:30	["CONTENT_COLLABORATOR"]	\N
\.


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: abhishek
--

SELECT pg_catalog.setval('user_id_seq', 10, true);


--
-- Name: UNIQ_KEY_LABEL; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT "UNIQ_KEY_LABEL" UNIQUE (label);


--
-- Name: UNIQ_KEY_TAG_PHOTO; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY tagphoto
    ADD CONSTRAINT "UNIQ_KEY_TAG_PHOTO" UNIQUE ("tagId", "photoId");


--
-- Name: listing_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY listing
    ADD CONSTRAINT listing_pkey PRIMARY KEY (id);


--
-- Name: permission_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY permission
    ADD CONSTRAINT permission_pkey PRIMARY KEY (id);


--
-- Name: photo_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY photo
    ADD CONSTRAINT photo_pkey PRIMARY KEY (id);


--
-- Name: role_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: tag_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: tagphot_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY tagphot
    ADD CONSTRAINT tagphot_pkey PRIMARY KEY (id);


--
-- Name: tagphoto_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY tagphoto
    ADD CONSTRAINT tagphoto_pkey PRIMARY KEY (id);


--
-- Name: user_pkey; Type: CONSTRAINT; Schema: public; Owner: abhishek; Tablespace: 
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: tagphoto_photoId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY tagphoto
    ADD CONSTRAINT "tagphoto_photoId_fkey" FOREIGN KEY ("photoId") REFERENCES photo(id) ON DELETE CASCADE;


--
-- Name: tagphoto_tagId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: abhishek
--

ALTER TABLE ONLY tagphoto
    ADD CONSTRAINT "tagphoto_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES tag(id) ON DELETE CASCADE;


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

