--
-- openGauss database dump
--

SET statement_timeout = 0;
SET xmloption = content;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET session_replication_role = replica;
SET client_min_messages = warning;

SET search_path = public;

--
-- Name: delete_expired_announcements(); Type: PROCEDURE; Schema: public; Owner: cloudb
--

CREATE PROCEDURE delete_expired_announcements()  NOT SHIPPABLE
 AS  DECLARE BEGIN
  DELETE FROM announcements
    WHERE expire_time IS NOT NULL
    AND expire_time < CURRENT_TIMESTAMP;
END;
/


ALTER PROCEDURE public.delete_expired_announcements() OWNER TO cloudb;

--
-- Name: schedule_trigger_func(); Type: FUNCTION; Schema: public; Owner: omm
--

CREATE FUNCTION schedule_trigger_func() RETURNS trigger
    LANGUAGE plpgsql NOT SHIPPABLE
 AS $$
BEGIN
  IF NEW.start_time >= NEW.end_time THEN
    RAISE EXCEPTION 'start_time must be less than end_time';
  END IF;

  IF NEW.capacity <= 0 THEN
    RAISE EXCEPTION 'capacity must be greater than 0';
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.schedule_trigger_func() OWNER TO omm;

--
-- Name: search_appointments(integer, character varying, date, date, character varying); Type: FUNCTION; Schema: public; Owner: omm
--

CREATE FUNCTION search_appointments(p_status integer DEFAULT NULL::integer, p_campus_name character varying DEFAULT NULL::character varying, p_start_date date DEFAULT NULL::date, p_end_date date DEFAULT NULL::date, p_user_school_id character varying DEFAULT NULL::character varying) RETURNS TABLE(id integer, description character varying, worker_caption character varying, reject_reason character varying, arrive_time timestamp without time zone, computer_model character varying, status integer, appointment_date date, campus character varying, user_name character varying, user_school_id character varying, user_phone_number character varying, worker_name character varying, user_id integer, worker_id integer, schedule_id integer)
    LANGUAGE plpgsql NOT SHIPPABLE
 AS $$
DECLARE
    v_sql TEXT;
    v_where_clause TEXT := ' WHERE 1=1';
    v_params_count INTEGER := 0;
BEGIN
    -- 构建基础查询
    v_sql := 'SELECT id, description, worker_caption, reject_reason, arrive_time, computer_model, 
              status, date AS appointment_date, campus, user_name, user_school_id, user_phone_number, 
              worker_name, user_id, worker_id, schedule_id 
              FROM appointment_view';
    
    IF p_status IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND status = ' || p_status;
        v_params_count := v_params_count + 1;
    END IF;
    
    IF p_campus_name IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND campus = ' || quote_literal(p_campus_name);
        v_params_count := v_params_count + 1;
    END IF;
      IF p_start_date IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND appointment_date >= ' || quote_literal(p_start_date);
        v_params_count := v_params_count + 1;
    END IF;
    
    IF p_end_date IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND appointment_date <= ' || quote_literal(p_end_date);
        v_params_count := v_params_count + 1;
    END IF;
    
    IF p_user_school_id IS NOT NULL THEN
        v_where_clause := v_where_clause || ' AND user_school_id = ' || quote_literal(p_user_school_id);
        v_params_count := v_params_count + 1;
    END IF;
    
    -- 如果有参数，添加WHERE子句
    IF v_params_count > 0 THEN
        v_sql := v_sql || v_where_clause;
    END IF;

    v_sql := v_sql || ' ORDER BY appointment_date DESC, status ASC';
    
    RETURN QUERY EXECUTE v_sql;
END;
$$;


ALTER FUNCTION public.search_appointments(p_status integer, p_campus_name character varying, p_start_date date, p_end_date date, p_user_school_id character varying) OWNER TO omm;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE TABLE admin (
    id integer NOT NULL
)
WITH (orientation=row, compression=no);


ALTER TABLE public.admin OWNER TO cloudb;

--
-- Name: admin_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudb
--

CREATE  SEQUENCE admin_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_id_seq OWNER TO cloudb;

--
-- Name: admin_id_seq; Type: LARGE SEQUENCE OWNED BY; Schema: public; Owner: cloudb
--

ALTER  SEQUENCE admin_id_seq OWNED BY admin.id;


--
-- Name: announcement; Type: TABLE; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE TABLE announcement (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    publish_time timestamp without time zone NOT NULL,
    expire_time timestamp without time zone,
    priority integer DEFAULT 0 NOT NULL,
    last_editor integer NOT NULL
)
WITH (orientation=row, compression=no);


ALTER TABLE public.announcement OWNER TO cloudb;

--
-- Name: announcement_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudb
--

CREATE  SEQUENCE announcement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.announcement_id_seq OWNER TO cloudb;

--
-- Name: announcement_id_seq; Type: LARGE SEQUENCE OWNED BY; Schema: public; Owner: cloudb
--

ALTER  SEQUENCE announcement_id_seq OWNED BY announcement.id;


--
-- Name: clinic_user; Type: TABLE; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE TABLE clinic_user (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    school_id character varying(32) NOT NULL,
    phone_number character varying(32),
    password_hash character(32) NOT NULL
)
WITH (orientation=row, compression=no);


ALTER TABLE public.clinic_user OWNER TO cloudb;

--
-- Name: announcement_view; Type: VIEW; Schema: public; Owner: cloudb
--

CREATE VIEW announcement_view(id,title,content,publish_time,expire_time,priority,editor_name) AS
    SELECT announcement.id, announcement.title, announcement.content, announcement.publish_time, announcement.expire_time, announcement.priority, clinic_user.name AS editor_name FROM (announcement LEFT JOIN clinic_user ON ((announcement.last_editor = clinic_user.id))) ORDER BY announcement.priority;


ALTER VIEW public.announcement_view OWNER TO cloudb;

--
-- Name: appointment; Type: TABLE; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE TABLE appointment (
    id integer NOT NULL,
    user_id integer NOT NULL,
    worker_id integer,
    description character varying(4096) NOT NULL,
    worker_caption character varying(1024),
    reject_reason character varying(1024),
    computer_model character varying(255),
    arrive_time timestamp without time zone,
    schedule_id integer NOT NULL,
    status integer DEFAULT 1 NOT NULL
)
WITH (orientation=row, compression=no);


ALTER TABLE public.appointment OWNER TO cloudb;

--
-- Name: appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudb
--

CREATE  SEQUENCE appointment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointment_id_seq OWNER TO cloudb;

--
-- Name: appointment_id_seq; Type: LARGE SEQUENCE OWNED BY; Schema: public; Owner: cloudb
--

ALTER  SEQUENCE appointment_id_seq OWNED BY appointment.id;


--
-- Name: campus; Type: TABLE; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE TABLE campus (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(255) NOT NULL
)
WITH (orientation=row, compression=no);


ALTER TABLE public.campus OWNER TO cloudb;

--
-- Name: schedule; Type: TABLE; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE TABLE schedule (
    id integer NOT NULL,
    campus_id integer NOT NULL,
    "date" date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    capacity integer NOT NULL
)
WITH (orientation=row, compression=no);


ALTER TABLE public.schedule OWNER TO cloudb;

--
-- Name: worker; Type: TABLE; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE TABLE worker (
    id integer NOT NULL,
    campus integer
)
WITH (orientation=row, compression=no);


ALTER TABLE public.worker OWNER TO cloudb;

--
-- Name: worker_view; Type: VIEW; Schema: public; Owner: cloudb
--

CREATE VIEW worker_view(id,name,school_id,phone_number,campus) AS
    SELECT clinic_user.id, clinic_user.name, clinic_user.school_id, clinic_user.phone_number, campus.name AS campus FROM ((clinic_user JOIN worker ON ((clinic_user.id = worker.id))) LEFT JOIN campus ON ((worker.campus = campus.id)));


ALTER VIEW public.worker_view OWNER TO cloudb;

--
-- Name: appointment_view; Type: VIEW; Schema: public; Owner: cloudb
--

CREATE VIEW appointment_view(id,description,worker_caption,reject_reason,arrive_time,computer_model,status,"date",campus,user_name,user_school_id,user_phone_number,worker_name,user_id,worker_id,schedule_id) AS
    SELECT appointment.id, appointment.description, appointment.worker_caption, appointment.reject_reason, appointment.arrive_time, appointment.computer_model, appointment.status, schedule."date", campus.name AS campus, clinic_user.name AS user_name, clinic_user.school_id AS user_school_id, clinic_user.phone_number AS user_phone_number, worker_view.name AS worker_name, appointment.user_id, appointment.worker_id, appointment.schedule_id FROM ((((appointment LEFT JOIN clinic_user ON ((appointment.user_id = clinic_user.id))) LEFT JOIN worker_view ON ((appointment.worker_id = worker_view.id))) LEFT JOIN schedule ON ((appointment.schedule_id = schedule.id))) LEFT JOIN campus ON ((schedule.campus_id = campus.id)));


ALTER VIEW public.appointment_view OWNER TO cloudb;

--
-- Name: campus_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudb
--

CREATE  SEQUENCE campus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.campus_id_seq OWNER TO cloudb;

--
-- Name: campus_id_seq; Type: LARGE SEQUENCE OWNED BY; Schema: public; Owner: cloudb
--

ALTER  SEQUENCE campus_id_seq OWNED BY campus.id;


--
-- Name: clinic_user_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudb
--

CREATE  SEQUENCE clinic_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clinic_user_id_seq OWNER TO cloudb;

--
-- Name: clinic_user_id_seq; Type: LARGE SEQUENCE OWNED BY; Schema: public; Owner: cloudb
--

ALTER  SEQUENCE clinic_user_id_seq OWNED BY clinic_user.id;


--
-- Name: schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudb
--

CREATE  SEQUENCE schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.schedule_id_seq OWNER TO cloudb;

--
-- Name: schedule_id_seq; Type: LARGE SEQUENCE OWNED BY; Schema: public; Owner: cloudb
--

ALTER  SEQUENCE schedule_id_seq OWNED BY schedule.id;


--
-- Name: schedule_view; Type: VIEW; Schema: public; Owner: cloudb
--

CREATE VIEW schedule_view(id,"date",start_time,end_time,campus,address,campus_id,capacity,appointed) AS
    SELECT schedule.id, schedule."date", schedule.start_time, schedule.end_time, campus.name AS campus, campus.address, campus.id AS campus_id, schedule.capacity, (SELECT count(*) AS count FROM appointment WHERE (appointment.schedule_id = schedule.id)) AS appointed FROM (schedule LEFT JOIN campus ON ((schedule.campus_id = campus.id)));


ALTER VIEW public.schedule_view OWNER TO cloudb;

--
-- Name: worker_id_seq; Type: SEQUENCE; Schema: public; Owner: cloudb
--

CREATE  SEQUENCE worker_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.worker_id_seq OWNER TO cloudb;

--
-- Name: worker_id_seq; Type: LARGE SEQUENCE OWNED BY; Schema: public; Owner: cloudb
--

ALTER  SEQUENCE worker_id_seq OWNED BY worker.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cloudb
--

ALTER TABLE admin ALTER COLUMN id SET DEFAULT nextval('admin_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cloudb
--

ALTER TABLE announcement ALTER COLUMN id SET DEFAULT nextval('announcement_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cloudb
--

ALTER TABLE appointment ALTER COLUMN id SET DEFAULT nextval('appointment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cloudb
--

ALTER TABLE campus ALTER COLUMN id SET DEFAULT nextval('campus_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cloudb
--

ALTER TABLE clinic_user ALTER COLUMN id SET DEFAULT nextval('clinic_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cloudb
--

ALTER TABLE schedule ALTER COLUMN id SET DEFAULT nextval('schedule_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cloudb
--

ALTER TABLE worker ALTER COLUMN id SET DEFAULT nextval('worker_id_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: cloudb
--

COPY admin (id) FROM stdin;
56
\.
;

--
-- Name: admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudb
--

SELECT pg_catalog.setval('admin_id_seq', 1, false);


--
-- Data for Name: announcement; Type: TABLE DATA; Schema: public; Owner: cloudb
--

COPY announcement (id, title, content, publish_time, expire_time, priority, last_editor) FROM stdin;
1	良乡软件服务	请各位预约的同学注意，网协技术部提供的软件服务目前已经与电脑诊所提供的维修服务合并，可随意预约良乡求是社区或良乡图书馆的任意时间。\\n更多相关资讯可以加入QQ群812129003了解。	2025-02-27 10:00:00	\N	0	56
\.
;

--
-- Name: announcement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudb
--

SELECT pg_catalog.setval('announcement_id_seq', 1, true);


--
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: cloudb
--

COPY appointment (id, user_id, worker_id, description, worker_caption, reject_reason, computer_model, arrive_time, schedule_id, status) FROM stdin;
1	37	50	"键盘部分键不灵敏，比如s经常按不下去，一阵一阵的\\n（去年12月份，曾经电脑不小心洒过水，当时开机困难，后来按网上方法晾干后，自己又好了）\\n不知道按键不灵敏是否相关"	\N	\N	华硕天选2022	2025-04-23 13:37:54.041	1	6
2	32	50	笔记本打开的时候，一侧屏幕边缘翘边	\N	\N	\N	2025-04-23 11:01:03.11	1	6
3	10	50	清灰	\N	\N	Legion R7000 AHP9	2025-04-23 11:23:13.218	1	6
4	26	50	清灰	\N	\N	华硕天选	2025-04-23 12:21:25.495	2	6
5	15	50	笔记本清灰换硅脂（自带）	\N	\N	lssz2380317583	2025-04-24 11:03:43.415	3	6
6	31	51	清灰	\N	\N	dell g15	2025-04-24 10:30:20.993	3	6
7	47	51	安装inventor2023报错	\N	\N	华硕天选	2025-04-24 11:52:22.842	3	6
8	39	50	买来刚用了小半年的游戏本，之前开机后未运行任何游戏cpu温度稳定在三四十，现在开机后同样情况下cpu一路飙到了六七十，期间清过一次灰，盲猜可能是清灰不彻底造成的，希望能帮助诊断一下病灶，要是方便的话，顺带全面清一下灰，谢谢！	\N	\N	华硕ASUS 天选5Pro i9-14900HX RTX 4060	2025-04-24 10:29:51.093	3	6
9	6	50	安装linux	\N	\N	\N	2025-04-24 10:51:15.413	3	6
10	14	51	需要清灰，自己清不干净也不放心，谢谢	\N	\N	联想拯救者r9000p	2025-04-24 10:29:57.124	3	6
11	3	50	电脑发热，可能需要清灰换硅脂	\N	\N	拯救者y9000p	2025-04-24 12:14:33.597	3	6
12	23	50	电脑能正常开机，但输入密码后黑屏，只有鼠标光标，不能打开任务管理器	输入用户密码后，使用win键呼唤出菜单，然后可以正常打开	\N	\N	2025-04-24 10:42:38.678	3	6
13	13	50	"触控板卡住无法按动, 屏幕开机后闪烁"	\N	问题过于严重	联想YOGApro14s	2025-04-24 09:37:39.85	4	7
14	34	50	d盘的权限什么的好像是纯在系统文件导致软件装不了什么的	\N	\N	惠普 victus 16	2025-04-25 10:24:51.189	5	6
15	45	50	电脑昨天晚上突然蓝屏，重启之后并无异常。今天打开电脑玩游戏如cs和其他3a类发现帧数一直特别低，但是玩其他的低要求游戏如英雄联盟则无异常，其他各方面功能也无异常。	\N	\N	dell g15 5520	2025-04-25 10:49:00.863	5	7
16	6	51	安装SolidWorks2018	\N	\N	\N	2025-04-25 12:48:12.286	5	6
17	17	51	电脑风扇清灰	\N	\N	拯救者Y9000P	\N	5	9
18	42	51	电脑空间不足，删除了很多但是没啥变化	\N	\N	戴尔灵越16plus	2025-04-25 12:48:21.561	5	6
19	4	50	电脑清灰	\N	\N	拯救者y9000p2023	2025-04-25 10:57:40.74	5	6
20	36	50	电脑清灰	\N	\N	联想y7000p	2025-04-25 10:40:07.194	6	6
21	5	51	电脑因为磕碰，部分显示屏坏了	\N	\N	联想拯救者Y7000PIRX9	\N	7	9
22	27	51	清灰，分配存储空间	\N	\N	拯救者r9000k2021版	2025-04-28 10:38:10.421	7	6
23	8	51	清灰	\N	\N	拯救者	\N	7	9
24	2	51	电脑清灰加换硅脂	\N	\N	y9000p 2022	\N	7	9
25	1	51	加装硬盘	\N	\N	\N	\N	7	9
26	41	51	游戏本拯救者y7000p清灰换硅脂，已使用4年。	\N	\N	联想拯救者y7000p	\N	7	9
27	20	51	电脑运行速度太慢，电脑能连上wifi但显示尚未连接	\N	\N	thinkpad	2025-04-28 10:35:52.688	7	6
28	44	51	电脑清灰	\N	\N	联想拯救者Y7000P	\N	7	2
29	17	56	电脑清灰	\N	\N	拯救者Y9000P	\N	7	9
30	33	56	电脑经常性无响应。	\N	\N	惠普光影精灵	\N	7	9
31	21	50	加硬盘	\N	\N	华硕天选	\N	8	2
32	40	50	把电脑用户名改成英文的	\N	\N	联想小新16	\N	8	9
33	9	56	清灰	\N	\N	拯救者r9000p	2025-04-28 10:37:07.693	8	6
34	24	50	电脑无法使用电源键开机,虽然电源键在充电时亮起	\N	\N	MECHREVO蛟龙16K R7-7735H	\N	8	9
35	11	50	撤换内存条	\N	\N	Y9000X2022	\N	8	2
36	25	53	C盘快满了，系统存储空间不够	\N	\N	华为	\N	8	9
37	29	53	过热卡顿	\N	\N	七彩虹隐星p15	\N	8	9
38	28	52	电脑关机后键盘灯依旧亮，风扇还在转。强制关机也不好使，也无法开机	\N	\N	戴尔外星人	\N	8	9
39	43	51	电脑清灰	\N	\N	宏碁暗影骑士擎	2025-04-28 10:37:16.779	8	6
40	48	54	清灰	\N	\N	拯救者Y7000P	\N	9	9
41	35	54	电脑清灰	\N	\N	华硕天选4	\N	9	9
42	16	51	换硅脂	\N	\N	\N	2025-04-28 10:47:00.323	9	6
43	38	54	散热差，玩大表哥掉帧，换硅脂清灰	\N	\N	机械师t58v	\N	9	2
44	19	49	CPU的风扇不转了，不知道是硬件还是软件问题，也有可能是出现液金偏移了，平时随身携带比较多	\N	\N	ROG幻16air	\N	10	2
45	46	50	电脑清灰，添加硅脂	\N	\N	惠普暗影精灵9	\N	10	2
46	22	50	电脑需要清灰	\N	\N	拯救者 y9000p	\N	10	2
47	30	55	外置硬盘插入电脑后过一段时间一直弹出弹进。	\N	\N	拯救者y7000p	\N	10	2
48	12	49	清灰	\N	\N	华硕天选5Pro	\N	10	2
\.
;

--
-- Name: appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudb
--

SELECT pg_catalog.setval('appointment_id_seq', 48, true);


--
-- Data for Name: campus; Type: TABLE DATA; Schema: public; Owner: cloudb
--

COPY campus (id, name, address) FROM stdin;
1	良乡图书馆	徐特立图书馆3楼第二阅览室311G
2	中关村校区	图书馆D08
3	良乡求是社区	疏桐D地下室求是社区D116
\.
;

--
-- Name: campus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudb
--

SELECT pg_catalog.setval('campus_id_seq', 4, true);


--
-- Data for Name: clinic_user; Type: TABLE DATA; Schema: public; Owner: cloudb
--

COPY clinic_user (id, name, school_id, phone_number, password_hash) FROM stdin;
1	陈焕然	1120230001	19101223282	5f4dcc3b5aa765d61d8327deb882cf99
2	陈政宏	1120230002	13187666758	5f4dcc3b5aa765d61d8327deb882cf99
3	段煜晗	1120230003	18560822802	5f4dcc3b5aa765d61d8327deb882cf99
4	宫可鑫	1120230004	15567606859	5f4dcc3b5aa765d61d8327deb882cf99
5	郝一丞	1120230005	13191712595	5f4dcc3b5aa765d61d8327deb882cf99
6	侯雨萌	1120230006	13131210887	5f4dcc3b5aa765d61d8327deb882cf99
7	侯雨萌	1120230007	13131210887	5f4dcc3b5aa765d61d8327deb882cf99
8	胡昊阳	1120230008	18365353592	5f4dcc3b5aa765d61d8327deb882cf99
9	黄宝冬	1120230009	1577211752	5f4dcc3b5aa765d61d8327deb882cf99
10	黄初奇	1120230010	15306984069	5f4dcc3b5aa765d61d8327deb882cf99
11	姜郎	1120230011	18580800410	5f4dcc3b5aa765d61d8327deb882cf99
12	鞠东轩	1120230012	15318766132	5f4dcc3b5aa765d61d8327deb882cf99
13	康菲雅	1120230013	19579956169	5f4dcc3b5aa765d61d8327deb882cf99
14	匡经纬	1120230014	13521351162	5f4dcc3b5aa765d61d8327deb882cf99
15	李单仕正	1120230015	18770279281	5f4dcc3b5aa765d61d8327deb882cf99
16	李俊贤	1120230016	15117449267	5f4dcc3b5aa765d61d8327deb882cf99
17	李佩锦	1120230017	15238171206	5f4dcc3b5aa765d61d8327deb882cf99
18	李佩锦	1120230018	15238171206	5f4dcc3b5aa765d61d8327deb882cf99
19	李韦俊	1120230019	13578300870	5f4dcc3b5aa765d61d8327deb882cf99
20	李玥欣	1120230020	18086490395	5f4dcc3b5aa765d61d8327deb882cf99
21	梁宇轩	1120230021	13120040655	5f4dcc3b5aa765d61d8327deb882cf99
22	刘畅	1120230022	15210881590	5f4dcc3b5aa765d61d8327deb882cf99
23	刘俞孝	1120230023	13020008156	5f4dcc3b5aa765d61d8327deb882cf99
24	陆开然	1120230024	18756055171	5f4dcc3b5aa765d61d8327deb882cf99
25	齐慧敏	1120230025	18203403529	5f4dcc3b5aa765d61d8327deb882cf99
26	邵德恺	1120230026	18302672070	5f4dcc3b5aa765d61d8327deb882cf99
27	申晟	1120230027	15234078023	5f4dcc3b5aa765d61d8327deb882cf99
28	石笑屹	1120230028	18941370005	5f4dcc3b5aa765d61d8327deb882cf99
29	宋怡	1120230029	18342053867	5f4dcc3b5aa765d61d8327deb882cf99
30	王凯林	1120230030	15949501893	5f4dcc3b5aa765d61d8327deb882cf99
31	王治桐	1120230031	15941732884	5f4dcc3b5aa765d61d8327deb882cf99
32	王子儒	1120230032	15703182014	5f4dcc3b5aa765d61d8327deb882cf99
33	吴雅妮	1120230033	18182159841	5f4dcc3b5aa765d61d8327deb882cf99
34	吴则勋	1120230034	18210179999	5f4dcc3b5aa765d61d8327deb882cf99
35	肖方杰	1120230035	17738868802	5f4dcc3b5aa765d61d8327deb882cf99
36	杨硕	1120230036	13161321909	5f4dcc3b5aa765d61d8327deb882cf99
37	姚亚霏	1120230037	15369938663	5f4dcc3b5aa765d61d8327deb882cf99
38	禹璟致	1120230038	19936758140	5f4dcc3b5aa765d61d8327deb882cf99
39	张帆	1120230039	18993936895	5f4dcc3b5aa765d61d8327deb882cf99
40	张倩	1120230040	18793160125	5f4dcc3b5aa765d61d8327deb882cf99
41	张旺	1120230041	18263498575	5f4dcc3b5aa765d61d8327deb882cf99
42	张语慧	1120230042	13522155977	5f4dcc3b5aa765d61d8327deb882cf99
43	张云奕	1120230043	15027828616	5f4dcc3b5aa765d61d8327deb882cf99
44	钟家旭	1120230044	18729787041	5f4dcc3b5aa765d61d8327deb882cf99
45	钟俊杰	1120230045	13398498884	5f4dcc3b5aa765d61d8327deb882cf99
46	钟志东	1120230046	18856004681	5f4dcc3b5aa765d61d8327deb882cf99
47	周姜	1120230047	15214465682	5f4dcc3b5aa765d61d8327deb882cf99
48	朱帅威	1120230048	17671157985	5f4dcc3b5aa765d61d8327deb882cf99
49	高松灯	1120200001	\N	5f4dcc3b5aa765d61d8327deb882cf99
50	千早爱音	1120200002	\N	5f4dcc3b5aa765d61d8327deb882cf99
51	长崎素世	1120200003	\N	5f4dcc3b5aa765d61d8327deb882cf99
52	椎名立希	1120200004	\N	5f4dcc3b5aa765d61d8327deb882cf99
53	要乐奈	1120200005	\N	5f4dcc3b5aa765d61d8327deb882cf99
54	丰川祥子	1120200006	\N	5f4dcc3b5aa765d61d8327deb882cf99
55	若叶睦	1120200007	\N	5f4dcc3b5aa765d61d8327deb882cf99
56	浅见槻野	1120200008	\N	5f4dcc3b5aa765d61d8327deb882cf99
\.
;

--
-- Name: clinic_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudb
--

SELECT pg_catalog.setval('clinic_user_id_seq', 56, true);


--
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: cloudb
--

COPY schedule (id, campus_id, "date", start_time, end_time, capacity) FROM stdin;
1	1	2025-04-23	18:30:00	21:00:00	5
2	3	2025-04-23	18:30:00	21:00:00	5
3	1	2025-04-24	18:30:00	21:00:00	8
4	3	2025-04-24	18:30:00	21:00:00	5
5	1	2025-04-25	18:30:00	21:00:00	5
6	3	2025-04-25	18:30:00	21:00:00	5
7	1	2025-04-28	18:30:00	21:00:00	10
8	3	2025-04-28	18:30:00	21:00:00	10
9	1	2025-04-29	18:30:00	21:00:00	5
10	3	2025-04-29	18:30:00	21:00:00	5
\.
;

--
-- Name: schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudb
--

SELECT pg_catalog.setval('schedule_id_seq', 10, true);


--
-- Data for Name: worker; Type: TABLE DATA; Schema: public; Owner: cloudb
--

COPY worker (id, campus) FROM stdin;
49	1
50	2
51	3
52	1
53	2
54	3
55	1
56	2
\.
;

--
-- Name: worker_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloudb
--

SELECT pg_catalog.setval('worker_id_seq', 1, false);


--
-- Name: admin_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY  (id);


--
-- Name: announcement_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE announcement
    ADD CONSTRAINT announcement_pkey PRIMARY KEY  (id);


--
-- Name: appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY  (id);


--
-- Name: campus_name_key; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE campus
    ADD CONSTRAINT campus_name_key UNIQUE (name);


--
-- Name: campus_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE campus
    ADD CONSTRAINT campus_pkey PRIMARY KEY  (id);


--
-- Name: clinic_user_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE clinic_user
    ADD CONSTRAINT clinic_user_pkey PRIMARY KEY  (id);


--
-- Name: clinic_user_school_id_key; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE clinic_user
    ADD CONSTRAINT clinic_user_school_id_key UNIQUE (school_id);


--
-- Name: schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY  (id);


--
-- Name: worker_pkey; Type: CONSTRAINT; Schema: public; Owner: cloudb; Tablespace: 
--

ALTER TABLE worker
    ADD CONSTRAINT worker_pkey PRIMARY KEY  (id);


--
-- Name: appointment_index_0; Type: INDEX; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE INDEX appointment_index_0 ON appointment USING btree (schedule_id) TABLESPACE pg_default;


--
-- Name: appointment_index_1; Type: INDEX; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE INDEX appointment_index_1 ON appointment USING btree (status) TABLESPACE pg_default;


--
-- Name: clinic_user_index_0; Type: INDEX; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE INDEX clinic_user_index_0 ON clinic_user USING btree (school_id) TABLESPACE pg_default;


--
-- Name: worker_index_0; Type: INDEX; Schema: public; Owner: cloudb; Tablespace: 
--

CREATE INDEX worker_index_0 ON worker USING btree (campus) TABLESPACE pg_default;


--
-- Name: appointment_view_update; Type: RULE; Schema: public; Owner: cloudb
--

SET enable_cluster_resize = on;
CREATE RULE appointment_view_update AS ON UPDATE TO appointment_view DO INSTEAD UPDATE appointment SET description = new.description, computer_model = new.computer_model, schedule_id = new.schedule_id, worker_caption = new.worker_caption, reject_reason = new.reject_reason, status = new.status, worker_id = new.worker_id, arrive_time = CASE WHEN ((new.status >= 5) AND (old.arrive_time IS NULL)) THEN ('now'::text)::timestamp without time zone ELSE old.arrive_time END WHERE (appointment.id = new.id);


--
-- Name: schedule_before_insert; Type: TRIGGER; Schema: public; Owner: cloudb
--

CREATE TRIGGER schedule_before_insert BEFORE INSERT ON public.schedule FOR EACH ROW EXECUTE PROCEDURE public.schedule_trigger_func();


--
-- Name: schedule_before_update; Type: TRIGGER; Schema: public; Owner: cloudb
--

CREATE TRIGGER schedule_before_update BEFORE INSERT ON public.schedule FOR EACH ROW EXECUTE PROCEDURE public.schedule_trigger_func();


--
-- Name: admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE admin
    ADD CONSTRAINT admin_id_fkey FOREIGN KEY (id) REFERENCES worker(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: announcement_last_editor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE announcement
    ADD CONSTRAINT announcement_last_editor_fkey FOREIGN KEY (last_editor) REFERENCES worker(id);


--
-- Name: appointment_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE appointment
    ADD CONSTRAINT appointment_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES schedule(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: appointment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE appointment
    ADD CONSTRAINT appointment_user_id_fkey FOREIGN KEY (user_id) REFERENCES clinic_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: appointment_worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE appointment
    ADD CONSTRAINT appointment_worker_id_fkey FOREIGN KEY (worker_id) REFERENCES worker(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: schedule_campus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE schedule
    ADD CONSTRAINT schedule_campus_id_fkey FOREIGN KEY (campus_id) REFERENCES campus(id);


--
-- Name: worker_campus_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE worker
    ADD CONSTRAINT worker_campus_fkey FOREIGN KEY (campus) REFERENCES campus(id);


--
-- Name: worker_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cloudb
--

ALTER TABLE worker
    ADD CONSTRAINT worker_id_fkey FOREIGN KEY (id) REFERENCES clinic_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: omm
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM omm;
GRANT CREATE,USAGE ON SCHEMA public TO omm;
GRANT USAGE ON SCHEMA public TO PUBLIC;


--
-- openGauss database dump complete
--

