--
-- PostgreSQL database dump
--

-- Dumped from database version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.15 (Ubuntu 10.15-0ubuntu0.18.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: zam_arch(character varying); Type: FUNCTION; Schema: public; Owner: kplewka
--

CREATE FUNCTION public.zam_arch(character varying) RETURNS void
    LANGUAGE sql
    AS $_$INSERT INTO zamówieniaarch SELECT  kodzamówienia,terminstart,nrrejestracyjny,kodklienta,kodpracownika,kodwypożyczalni,terminstop,wartość FROM zamówienia where kodzamówienia=$1;
DELETE from zamówienia where kodzamówienia=$1;
$_$;


ALTER FUNCTION public.zam_arch(character varying) OWNER TO kplewka;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auta; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public.auta (
    nrrejestracyjny character varying(50) NOT NULL,
    lokalizacja character varying(50),
    "koddostępności" character varying(50),
    nrklasy integer
);


ALTER TABLE public.auta OWNER TO kplewka;

--
-- Name: autadane; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public.autadane (
    rodzajpaliwa character varying(50),
    typ character varying(50),
    moc numeric(18,0),
    kolor character varying(50),
    "skrzyniabiegów" character varying(50),
    przebieg integer,
    "napęd" character varying(50),
    generacja character varying(50),
    emisjaco2 integer,
    marka character varying(50),
    model character varying(50),
    wersja character varying(50),
    "pojemnośćskokowa" integer,
    pierwszarejestracja date,
    liczbamiejsc integer,
    nrrejestracyjny character varying(50),
    silnik character varying(50)
);


ALTER TABLE public.autadane OWNER TO kplewka;

--
-- Name: wypożyczalnie; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public."wypożyczalnie" (
    "kodwypożyczalni" character varying(50) NOT NULL,
    adres character varying(50),
    ulica character varying(50),
    nrdomu integer,
    kodpocztowy character varying,
    poczta character varying,
    nrtelefonu integer,
    adreemail character varying,
    dyrektor character varying,
    rokpowstania integer,
    miasto character varying
);


ALTER TABLE public."wypożyczalnie" OWNER TO kplewka;

--
-- Name: auta_dostep; Type: VIEW; Schema: public; Owner: kplewka
--

CREATE VIEW public.auta_dostep AS
 SELECT a.nrrejestracyjny,
    ad.marka,
    ad.model,
    w.miasto
   FROM ((public.auta a
     JOIN public.autadane ad ON (((a.nrrejestracyjny)::text = (ad.nrrejestracyjny)::text)))
     JOIN public."wypożyczalnie" w ON (((a.lokalizacja)::text = (w.miasto)::text)))
  WHERE ((a."koddostępności")::text = '1'::text)
  ORDER BY w.miasto;


ALTER TABLE public.auta_dostep OWNER TO kplewka;

--
-- Name: dostepnosc; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public.dostepnosc (
    id integer,
    stan character varying
);


ALTER TABLE public.dostepnosc OWNER TO kplewka;

--
-- Name: klasa; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public.klasa (
    nrklasy integer NOT NULL,
    cena integer
);


ALTER TABLE public.klasa OWNER TO kplewka;

--
-- Name: klienci; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public.klienci (
    kodklienta character varying(50) NOT NULL,
    nazwisko character varying(50),
    email character varying(50),
    nrtelefonu integer,
    ulica character varying(50),
    nrdomu character varying(50),
    kodpocztowy character varying(50),
    poczta character varying(50),
    nrdowodu character varying(50),
    nrpesel integer,
    "imię" character varying(50)
);


ALTER TABLE public.klienci OWNER TO kplewka;

--
-- Name: pracownicy; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public.pracownicy (
    kodpracownika character varying NOT NULL,
    nazwisko character varying,
    stanowisko character varying,
    rokzatrudnienia integer,
    imie character varying,
    "kodwypożyczalni" character varying
);


ALTER TABLE public.pracownicy OWNER TO kplewka;

--
-- Name: zamówienia; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public."zamówienia" (
    "kodzamówienia" character varying(50) NOT NULL,
    terminstart date,
    nrrejestracyjny character varying(50),
    kodklienta character varying(50),
    kodpracownika character varying(50),
    "kodwypożyczalni" character varying(50),
    terminstop date,
    status character varying(50),
    "wartość" integer
);


ALTER TABLE public."zamówienia" OWNER TO kplewka;

--
-- Name: zamówieniaarch; Type: TABLE; Schema: public; Owner: kplewka
--

CREATE TABLE public."zamówieniaarch" (
    "kodzamówienia" character varying(50) NOT NULL,
    terminstart date,
    nrrejestracyjny character varying(50),
    kodklienta character varying(50),
    kodpracownika character varying(50),
    "kodwypożyczalni" character varying(50),
    terminstop date,
    "wartość" integer
);


ALTER TABLE public."zamówieniaarch" OWNER TO kplewka;

--
-- Data for Name: auta; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public.auta (nrrejestracyjny, lokalizacja, "koddostępności", nrklasy) FROM stdin;
NOGCELE	Gdynia	2	2
WE081U4	Gdańsk	3	2
NO2X2O1	Warszawa	3	3
GDIPOE0	Słupsk	7	1
NO4UAY0	Wrocław	6	1
GAT8WG2	Gdańsk	1	1
KRJYFZ0	Gdynia	1	2
KRWS8G4	Sopot	5	1
NO33DMS	Sopot	5	1
WE4XBOX	Gdynia	1	2
NO7BUMX	Wejherowo	1	1
NOI0X4O	Wejherowo	2	3
WEI5P25	Wejherowo	4	2
NO5Y3NX	Gdańsk	5	2
NOL4DVP	Wrocław	2	1
GDMBX4W	Wrocław	3	2
KRL0Y4L	Słupsk	4	1
KR7F686	Słupsk	2	1
WE8ZTZQ	Słupsk	3	3
PORUAL6	Gdynia	1	2
NOX74RV	Gdynia	1	3
WEC4PW6	Gdynia	3	1
NOJI66L	Słupsk	2	3
GAC3KST	Słupsk	1	3
NOSAW50	Warszawa	4	1
NOJBGTR	Warszawa	2	1
POSLCRB	Warszawa	1	2
\.


--
-- Data for Name: autadane; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public.autadane (rodzajpaliwa, typ, moc, kolor, "skrzyniabiegów", przebieg, "napęd", generacja, emisjaco2, marka, model, wersja, "pojemnośćskokowa", pierwszarejestracja, liczbamiejsc, nrrejestracyjny, silnik) FROM stdin;
\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	NO7BUMX	\N
Diesel	Sedan	170	Biały	Manualna	80000	Na przednie koła	B (2017-)	\N	Opel	Insignia	\N	1956	2017-05-10	5	NO7BUMX	\N
Benzyna	SUV	115	Inny kolor	Manualna	90000	Na przednie koła	\N	\N	Dacia	Duster	1.6 SCe Access	1598	2016-04-05	5	NOGCELE	\N
Diesel	Combi	140	czerwony	Automatyczna	120000	na tylnie koła	\N	\N	Audi	A4 Allroad	\N	1984	2019-06-05	5	NO2X2O1	1.8 TFSI
Diesel	Suv	140	czarny	Automatyczna	10000	4x4	\N	\N	Audi	Q5	40 TDI Sportback quattro S tronic	1968	2020-03-05	5	GDIPOE0	3.0
Diesel	Combi	155	srebny	Manualna	130000	Na przednie koła	Avant 2.5 TDI	189	Audi	A4	Avant 2.5 TDI\n	2496	2017-05-16	5	NO5Y3NX	2.0
Benzyna	Suv	608	Pomarańczowy	Automatyczna	1300	4x4	\N	296	Bentley	Bentayga	W12	5950	2020-02-20	5	NO4UAY0	3.0
Benzyna	Coupe	690	Czerwony	Automatyczna	2040	4x4	\N	\N	Ferrari	GTC4Lusso	\N	6262	2019-01-05	4	KRL0Y4L	3.4
Benzyna	Sedan	250	Szary	Automatyczna	1750	Na tylne koła	\N	206	Jaguar	XE	P250 R-Dynamic S	7000	2017-02-15	5	NOJBGTR	2.0
Benzyna	Coupe	610	Biały	Automatyczna	50700	4x4	\N	\N	Lamborghini	Huracan	LP610-4	5204	2014-06-24	2	POSLCRB	3.2
Benzyna	Kompakt	120	Czerwony	Manualna	32008	Na przednie koła	II (2012-)	\N	Kia	Ceed	T-GDI GT Line	998	2016-04-01	5	NOX74RV	1.2
Benzyna	Suv	114	Biały	Manualna	184023	Na przednie koła	I (2007-2013)	144	Nissan	Qashqai	1.6 Acenta	1598	2012-04-01	5	NOL4DVP	1.6 Acenta
Benzyna	Suv	114	Szary	Manualna	120000	Na przednie koła	I (2010-2019)	117	Nissan	Juke	1.6 N-Tec S&S	1598	2015-02-07	5	KR7F686	1.6
Diesel	Combi	180	Perłowy	Automatyczna	184000	Na przednie koła	\N	120	Peugot	508	SW BlueHDi FAP 180 Automatik 	1997	2014-05-02	5	WEI5P25	2.0
Diesel	Sedan	120	Czarny	Automatyczna	138420	Na przednie koła	\N	108	Peugot	3008	BlueHFI Allure S&S 	1560	2016-05-25	5	KRWS8G4	1.6
Diesel	Sedan	180	Srebny	Manualna	104720	Na przednie koła	Mk5 (2014-)	115	Ford	Mondeo	\N	1997	2015-02-22	5	PORUAL6	2.0
Diesel	Suv	258	Szary	Automatyczna	72000	4x4	II(2013-)	194	Land Rover	Range Rover Sport	S 3.0 TD V6 HSE Dynamic	2993	2016-04-22	5	NOJI66L	3.0
Benzyna	Kompakt	130	Biały	Manualna	9900	Na przednie koła	1.5 TSI FR	\N	Seat	Leon	1.5 TSI FR	1498	2018-02-22	5	GAC3KST	1.5
Benzyna	Suv	140	Złoty	Manualna	4320	Na przednie koła	III(2019)	\N	Suzuki	Vitara	\N	1373	2019-02-22	5	WEC4PW6	1.8
Hybryda	Kompakt	160	Czarny	Manualna	143420	Na przednie koła	II(2013)	\N	Suzuki	SX4	\N	1373	2013-05-22	5	GDMBX4W	2.0
Benzyna	Combi	150	Srebny	Manualna	16500	Na przednie koła	B8 (2014-)	\N	Volkswagen	Passat	1.5 TSI EVO Elegance	1498	2019-02-12	5	WE8ZTZQ	2.4
Benzyna	Kompakt	105	Szary	Manualna	147000	Na przednie koła	V (2009-2014)	114	Volkswagen	Polo	\N	1197	2014-02-12	5	NOSAW50	1.6
Diesel	Sedan	190	Niebieski	Automatyczna	84294	Na tylnie koła	G30/G31 (2017-)	175	Seria 5	Bmw	\N	1918	2017-04-02	4	NO33DMS	3.2
Diesel	Kompakt	164	Szary	Manualna	144294	Na tylnie koła	1161	145	Seria 1	Bmw	\N	1248	2014-06-02	5	WE4XBOX	2.6
\.


--
-- Data for Name: dostepnosc; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public.dostepnosc (id, stan) FROM stdin;
1	dostępny
2	zarezerwowany
3	wypożyczony
4	serwis_po
5	naprawa
6	niedostepny
7	inne
\.


--
-- Data for Name: klasa; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public.klasa (nrklasy, cena) FROM stdin;
1	1000
2	3000
3	5000
\.


--
-- Data for Name: klienci; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public.klienci (kodklienta, nazwisko, email, nrtelefonu, ulica, nrdomu, kodpocztowy, poczta, nrdowodu, nrpesel, "imię") FROM stdin;
kl1	Plewka	kamilplewka12a@wp.pl	606342592	Piota Skargi	28	84-200	Wejherowo	AM	312402442	Kamil
\.


--
-- Data for Name: pracownicy; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public.pracownicy (kodpracownika, nazwisko, stanowisko, rokzatrudnienia, imie, "kodwypożyczalni") FROM stdin;
llk1	Sylwestrzak	Kierownik HR	2015	Karol	001
llp1	Wolnik	Serwisant	2019	Patrycja	001
llb1	Morszczyn	Serwisant	2018	Błażej	001
lle1	Podlaski	Mechanik	2019	Edmund	001
llj1	Nowak	Serwisant	2019	Jan	002
lla1	Denna	Serwisant	2019	Anna	002
llkd	Wróblewska	Mechanik	2018	Magda	003
llap	Płotka	Kierownik	2016	Artur	003
llpk	Kwidziński	Konsultant	2016	Patrul	003
llpp	Potrykus	Konsultant	2017	Piotr	005
\.


--
-- Data for Name: wypożyczalnie; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public."wypożyczalnie" ("kodwypożyczalni", adres, ulica, nrdomu, kodpocztowy, poczta, nrtelefonu, adreemail, dyrektor, rokpowstania, miasto) FROM stdin;
001	Wejherowo	Kotłowskiego	82	84-200	Wejherowo	606342595	kamilplewka12@wp.pl	Krzysztof Plewka	2000	Wejherowo
002	Hemara432	Hemara	432	80-280	Warszawa	543564765	wypozyczalniawaw2@auto.com	Jan Kowalski	2010	Warszawa
003	Gdynia	Abrahama	42	81-372	Gdynia	424246464	gdyniaWypożyczalnia@wp.pl	Jan Sobieski	2011	Gdynia
004	Świąteczna242	Świąteczna	24	84-372	Słupsk	123123464	słupskWypożyczalnia@wp.pl	Jan Wróblewski	2001	Słupsk
005	Wrocławska23	Wrocławska	23	24-372	Wrocław	222123464	WrocławWypożyczalnia@wp.pl	Klaudia Sobolewska	2013	Wrocław
006	Pomorska14	Pomorska	14	80-288	Gdańsk	555221323	GdańskWypożyczalnia@wp.pl	Marta Wróblewska	2016	Gdańsk
llrh	Hall	Mechanik	2016	Robert	005	\N	\N	\N	\N	\N
llkh	Hall	Kierownik	2016	Klaudia	005	\N	\N	\N	\N	\N
llkw	Wróblewska	Kierownik	2016	Klaudia	004	\N	\N	\N	\N	\N
llzk	Kaczkowska	Mechanik	2016	Zosia	004	\N	\N	\N	\N	\N
llgh	Chrobka	Konsultant	2016	Gosia	004	\N	\N	\N	\N	\N
llam	Mickiewicz	Konsultant	2019	Adam	006	\N	\N	\N	\N	\N
llss	Słowacki	Mechanik	2020	Sławomir	006	\N	\N	\N	\N	\N
llkk	Kowalski	Kierownik	2010	Kamil	006	\N	\N	\N	\N	\N
\.


--
-- Data for Name: zamówienia; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public."zamówienia" ("kodzamówienia", terminstart, nrrejestracyjny, kodklienta, kodpracownika, "kodwypożyczalni", terminstop, status, "wartość") FROM stdin;
\.


--
-- Data for Name: zamówieniaarch; Type: TABLE DATA; Schema: public; Owner: kplewka
--

COPY public."zamówieniaarch" ("kodzamówienia", terminstart, nrrejestracyjny, kodklienta, kodpracownika, "kodwypożyczalni", terminstop, "wartość") FROM stdin;
A001	2021-05-29	NO7BUMX	kl1	llk1	001	2021-06-04	3400
\.


--
-- Name: auta auta_pkey; Type: CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public.auta
    ADD CONSTRAINT auta_pkey PRIMARY KEY (nrrejestracyjny);


--
-- Name: klasa klasa_pkey; Type: CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public.klasa
    ADD CONSTRAINT klasa_pkey PRIMARY KEY (nrklasy);


--
-- Name: klienci klienci_pkey; Type: CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public.klienci
    ADD CONSTRAINT klienci_pkey PRIMARY KEY (kodklienta);


--
-- Name: pracownicy pracownicy_pkey; Type: CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT pracownicy_pkey PRIMARY KEY (kodpracownika);


--
-- Name: wypożyczalnie wypożyczalnie_pkey; Type: CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public."wypożyczalnie"
    ADD CONSTRAINT "wypożyczalnie_pkey" PRIMARY KEY ("kodwypożyczalni");


--
-- Name: zamówienia zamówienia_pkey; Type: CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public."zamówienia"
    ADD CONSTRAINT "zamówienia_pkey" PRIMARY KEY ("kodzamówienia");


--
-- Name: zamówieniaarch zamówieniaarch_pkey; Type: CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public."zamówieniaarch"
    ADD CONSTRAINT "zamówieniaarch_pkey" PRIMARY KEY ("kodzamówienia");


--
-- Name: auta auta_nrklasy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public.auta
    ADD CONSTRAINT auta_nrklasy_fkey FOREIGN KEY (nrklasy) REFERENCES public.klasa(nrklasy);


--
-- Name: autadane autadane_nrrejestracyjny_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public.autadane
    ADD CONSTRAINT autadane_nrrejestracyjny_fkey FOREIGN KEY (nrrejestracyjny) REFERENCES public.auta(nrrejestracyjny);


--
-- Name: pracownicy pracownicy_kodwypożyczalni_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public.pracownicy
    ADD CONSTRAINT "pracownicy_kodwypożyczalni_fkey" FOREIGN KEY ("kodwypożyczalni") REFERENCES public."wypożyczalnie"("kodwypożyczalni");


--
-- Name: zamówienia zamówienia_kodklienta_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public."zamówienia"
    ADD CONSTRAINT "zamówienia_kodklienta_fkey" FOREIGN KEY (kodklienta) REFERENCES public.klienci(kodklienta);


--
-- Name: zamówienia zamówienia_kodpracownika_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public."zamówienia"
    ADD CONSTRAINT "zamówienia_kodpracownika_fkey" FOREIGN KEY (kodpracownika) REFERENCES public.pracownicy(kodpracownika);


--
-- Name: zamówienia zamówienia_kodwypożyczalni_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public."zamówienia"
    ADD CONSTRAINT "zamówienia_kodwypożyczalni_fkey" FOREIGN KEY ("kodwypożyczalni") REFERENCES public."wypożyczalnie"("kodwypożyczalni");


--
-- Name: zamówienia zamówienia_nrrejestracyjny_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kplewka
--

ALTER TABLE ONLY public."zamówienia"
    ADD CONSTRAINT "zamówienia_nrrejestracyjny_fkey" FOREIGN KEY (nrrejestracyjny) REFERENCES public.auta(nrrejestracyjny);


--
-- PostgreSQL database dump complete
--

