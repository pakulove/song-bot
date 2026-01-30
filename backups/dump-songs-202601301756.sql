--
-- PostgreSQL database dump
--

\restrict aJyZgOqAbEtuBxhzWwlgaWNcf0EkqRBbjV8dDnJ9UhnQyadz6tf3Kr4VTZ8Nl23

-- Dumped from database version 16.11
-- Dumped by pg_dump version 18.1

-- Started on 2026-01-30 17:56:21 +05

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16385)
-- Name: setlist_songs; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.setlist_songs (
    id integer NOT NULL,
    setlist_id integer NOT NULL,
    song_id integer NOT NULL,
    song_order integer NOT NULL
);


ALTER TABLE public.setlist_songs OWNER TO test;

--
-- TOC entry 216 (class 1259 OID 16388)
-- Name: setlist_songs_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.setlist_songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setlist_songs_id_seq OWNER TO test;

--
-- TOC entry 3442 (class 0 OID 0)
-- Dependencies: 216
-- Name: setlist_songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.setlist_songs_id_seq OWNED BY public.setlist_songs.id;


--
-- TOC entry 217 (class 1259 OID 16389)
-- Name: setlists; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.setlists (
    id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    name character varying
);


ALTER TABLE public.setlists OWNER TO test;

--
-- TOC entry 218 (class 1259 OID 16395)
-- Name: setlists_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.setlists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.setlists_id_seq OWNER TO test;

--
-- TOC entry 3443 (class 0 OID 0)
-- Dependencies: 218
-- Name: setlists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.setlists_id_seq OWNED BY public.setlists.id;


--
-- TOC entry 219 (class 1259 OID 16396)
-- Name: songs; Type: TABLE; Schema: public; Owner: test
--

CREATE TABLE public.songs (
    id integer DEFAULT 66 NOT NULL,
    title text,
    title_en text,
    bpm integer,
    lyrics text,
    has_playback boolean DEFAULT false,
    chords_url text,
    notes text,
    key_letter character varying,
    type integer,
    CONSTRAINT songs_bpm_check CHECK ((bpm > 0))
);


ALTER TABLE public.songs OWNER TO test;

--
-- TOC entry 220 (class 1259 OID 16404)
-- Name: songs_id_seq; Type: SEQUENCE; Schema: public; Owner: test
--

CREATE SEQUENCE public.songs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.songs_id_seq OWNER TO test;

--
-- TOC entry 3444 (class 0 OID 0)
-- Dependencies: 220
-- Name: songs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: test
--

ALTER SEQUENCE public.songs_id_seq OWNED BY public.songs.id;


--
-- TOC entry 3274 (class 2604 OID 16405)
-- Name: setlist_songs id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.setlist_songs ALTER COLUMN id SET DEFAULT nextval('public.setlist_songs_id_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 16406)
-- Name: setlists id; Type: DEFAULT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.setlists ALTER COLUMN id SET DEFAULT nextval('public.setlists_id_seq'::regclass);


--
-- TOC entry 3431 (class 0 OID 16385)
-- Dependencies: 215
-- Data for Name: setlist_songs; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.setlist_songs VALUES (43, 18, 48, 0);
INSERT INTO public.setlist_songs VALUES (44, 18, 24, 1);
INSERT INTO public.setlist_songs VALUES (45, 18, 66, 2);
INSERT INTO public.setlist_songs VALUES (46, 18, 57, 3);
INSERT INTO public.setlist_songs VALUES (47, 19, 11, 0);
INSERT INTO public.setlist_songs VALUES (48, 19, 1, 1);
INSERT INTO public.setlist_songs VALUES (49, 19, 18, 2);
INSERT INTO public.setlist_songs VALUES (50, 20, 50, 0);
INSERT INTO public.setlist_songs VALUES (51, 20, 19, 1);
INSERT INTO public.setlist_songs VALUES (52, 20, 67, 2);
INSERT INTO public.setlist_songs VALUES (53, 20, 23, 3);


--
-- TOC entry 3433 (class 0 OID 16389)
-- Dependencies: 217
-- Data for Name: setlists; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.setlists VALUES (18, '2025-12-18 09:24:28.531945', 'вск-21.12.25');
INSERT INTO public.setlists VALUES (19, '2025-12-19 13:58:35.346498', 'Воскресенье 21.12 служение');
INSERT INTO public.setlists VALUES (20, '2026-01-17 19:22:53.657725', 'Воскресенье 18.01');


--
-- TOC entry 3435 (class 0 OID 16396)
-- Dependencies: 219
-- Data for Name: songs; Type: TABLE DATA; Schema: public; Owner: test
--

INSERT INTO public.songs VALUES (24, 'Как Ты любишь', 'How You Love Us', 160, 'Вступление:

C Am G  F


Куплет:

C
Tы рeвнуeшь мeня
             Am
Tы любви урaгaн cлoвнo дeрeвo я
            G                                                        F
И пoд cилoй любви и милocти я cклoняюcь
      C
Кoгдa вдруг внeзaпнo я cтaл пoнимaть
                 Am
Чтo для cлaвы приxoдят вce бeды
      G
Toгдa ocoзнaл кaк прeкрaceн Tы Бoг
               F
Tы вceгдa мнe дaруeшь пoбeду


Запев:

C                                   Am
O... Кaк Tы любишь нac 
                     G
O... Кaк Tы любишь
                      F
Кaк Tы любишь нac 


Припев:

C
Кaк Tы любишь 
                      Am
O... Кaк Tы любишь
                      G
O... Кaк Tы любишь
                      F
O... Кaк Tы любишь


Бридж:

C                        
Мы – Tвoя чacть, Tы – нaгрaдa для нac, 
Am
Мы cпaceны чeрeз cвeт Tвoиx глaз, 
          G                                                               F               
В oкeaнe вeликoй любви Tвoeй мы вce тoнeм. 
     C
Нeбec пoцeлуй пoлoн cтрacти вceгдa, 
Am
Вызвaл тoмлeниe ceрдцa. 
           G 
Нe мoгу я тeпeрь ни o чeм coжaлeть, 
             F
Кoгдa думaю o тoм


Запев:

C                           Am
O... Кaк Tы любишь нac 
                      G
O... Кaк Tы любишь
                      F
Кaк Tы любишь нac 


Припев:

C
Кaк Tы любишь 
                     Am
O... Кaк Tы любишь
                     G
O... Кaк Tы любишь
                     F
O... Кaк Tы любишь', false, 'https://holychords.pro/2460', NULL, 'C', 0);
INSERT INTO public.songs VALUES (66, 'Свежий ветер', 'Fresh Wind', 126, 'Вступление:

| Csus2/F Csus2 | Gsus G Am7 | 
| Csus2/F Csus2 | Gsus G Gsus | 


Куплет 1: 

Csus2/F           Csus2 
Дуx Святoй к нaм приди
Gsus             G             Am7
В cильнoм вeтрe, в плaмeни
Csus2/F 
Дух Святой
Csus2          G
Через нас дыши
 

Куплет 2:

Csus2/F                   Csus2
Pacкaявшиcь признaв грexи
Gsus          G                Am7     
Из пeплa oживaeм мы
Csus2/F        Csus2                  G
Вeтрoм, Бoг плaмя в нac зaжги
 

Припев 1: 

C/E                       F
Сойди свежим ветром
                      Am7
Дыханием неба
                           C
Дух свой изливай
                           G
Дух свой изливай
 

Куплет 3: 

Csus2/F               Csus2 
Tрeпeщeт дуx пeрeд Toбoй
Gsus         G         Am7
Прoвeди нac cквoзь oгoнь
Csus2/F 
Oчиcтив ceрдцe 
Csus2     G
Укрeпи eгo
 

Куплет 4:

Csus2/F                           Csus2
Мы – цeркoвь Бoжья, cвeт вo тьмe
Gsus     G        Am7     
Яркий гoрoд нa xoлмe
Csus2/F               Csus2                      G
Цaрcтвo Бoжьe пуcть придeт cкoрeй
 

Припев 2:

C/E                       F
Сойди свежим ветром
                      Am7
Дыханием неба
                           C
Дух свой изливай
                           G
Дух свой изливай
C/E                    F
Святым пoмaзaниeм
                   Am7
В силе и славе
                           C
Дух свой изливай
                           G
Дух свой изливай
 

Тэг:
 
C/E            F
Дух свой изливай
G                Am
Дух свой изливай
G/B           C
Дух свой изливай
                           G
Дух свой изливай
 
C/E            F
Дух свой изливай
G                Am
Дух свой изливай
G/B           C
Дух свой изливай
                           G
Дух свой изливай
 

Бридж:

F 
Каждый кто спасен
Am 
Пророчествуй и пой
C 
Ощути Его 
G 
Ветер, ветер, ветер
Fmaj7 
Дух Святой сойди
Am            F/A
Посреди хвалы
C 
Дай нам ощутить 
G 
Твой ветер, ветер, ветер
 

повтор бриджа 


повтор припева 2', true, 'https://www.worshiptogether.com/songs/fresh-wind-hillsong-worship/', 'для гитары G 5 капа', 'C', 0);
INSERT INTO public.songs VALUES (26, 'Меняешь атмосферу', 'Here As In Heaven', 139, 'Куплет: (x2)

G                            D
Меняешь атмосферу в нас
G                                  D
Ибо Дух Господень здесь сейчас
G                               D
И нам не нужно много фраз
G/H                                   D               A
Когда Дух Господень здесь сейчас


Припев:

G
До избытка излей
                                  Hm
в наше сердце любовь
                A
Твою любовь Бог
G
Мы стоим пред Тобой
                          Hm
окруженные вновь
                  A
Твоей любовью


Проигрыш:
G D


Куплет: (x2)

Меняешь атмосферу в нас
Ибо Дух Господень здесь сейчас
И нам не нужно много фраз
Когда Дух Господень здесь сейчас


Припев: (x2)

До избытка излей
в наше сердце любовь
Твою любовь Бог
Мы стоим пред Тобой
окруженные вновь
Твоей любовью


Проигрыш:

G A Hm A


Бридж: (x3)

G                                    A  Hm
О Дух Святой нас обнови
                  A
Тебя так жаждем
G                                     A   Hm
И Царствие Твоё сейчас
                     A
Мы утверждаем


Проигрыш:

G Em Hm A (x5)


Припев: (x3)

До избытка излей
в наше сердце любовь
Твою любовь Бог
Мы стоим пред Тобой
окруженные вновь
Твоей любовью


Проигрыш:

G A Hm A


Бридж: 2

G
Поём хвалу Тебе, Бог
                               A
Поём Тебе, наш Царь
Hm
Любовь, что бесконечна
A
Наполняет, наполняет нас
G', true, 'https://kg-music.club/songs/menyaesh-atmosferu', NULL, 'D', 1);
INSERT INTO public.songs VALUES (34, 'Отдаю жизнь', 'Make Room', 122, 'текста пока нет(', false, 'https://holychords.pro/43423', 'не нашел пока, не слышал эту песню', 'G', 0);
INSERT INTO public.songs VALUES (52, 'Твой огонь пылает', NULL, 130, 'Куплет 1:   

Em C G

В присутствии Твоём покой
И в сердце утихнет шторм 
Ты открыл во мне Свой мир
И зажег во мне огонь


Припев:  х2  

Em C G

Твой огонь пылает
Моё сердце тает
От присутствия Твоего


Куплет 2: 
  
В присутствии Твоём покой
И в сердце утихнет шторм 
Ты открыл во мне Свой мир
И зажег во мне огонь


Бридж:   

Em C G

Лишь в тебе, Иисус, я себя нашёл
Силою любви буду исцелён 
Лишь в тебе, Иисус, я себя нашёл
Силою любви буду исцелён', false, 'https://holychords.pro/33037', NULL, 'Ab', 0);
INSERT INTO public.songs VALUES (35, 'От славы в славу', 'Glory To Glory', 164, 'Куплет:

Hm        G           D
Ты жил среди нас,
Hm         G            D
Творений из праха земли.
Hm         G            D                         Hm
Ходил во плоти, познал нашу боль.
                  G                    D
Ты ведешь нас все выше


Куплет 2:

Ты вечности Царь
Свою жизнь Ты отдал за нас.
Тобой наш позор был на крест вознесен.
Ты ведёшь нас все выше.


Припев:

                                Hm              G            D
Ведешь нас от Славы и в Славу, и Славу.
                        Hm                    G            D
Не буду прежним я, не буду прежним я.
                                  Hm         G            D
Ведешь нас всё выше и выше и выше.
                Hm           G           D
Навеки изменен, я изменен


Куплет 3:

Меня другом назвал, (другом назвал)
Привел в Свое царство навек.
Своей кровью омыл и освободил.
Ты ведёшь нас все выше.


Бридж:

G
Пока мы ждём тот день 
D
Любовь побеждает всё, 
A                                              Hm         A
К Тебе взывать мы будем "Святой, Святой".
G
Когда придёт тот день 
D
Мы станем лицом к лицу, 
A                                              Hm         A
И мы споём Тебе Бог "Святой, Святой".


Куплет 4:

Из мертвых воскрес
И смерти не одолеть нас
Победитель наш Царь небеса среди нас
Ты ведешь нас всё выше', true, 'https://holychords.pro/5763', 'Ссылка на русскую версию https://kg-music.club/songs/ot-clavy-v-slavu', 'D', 1);
INSERT INTO public.songs VALUES (50, 'Стою в твоей любви', 'Stand In Your Love', 145, 'Куплет 1:

        D                                               G
Когда вся тьма сгустилась надо мной
          D                                             G
Печаль крадёт всю радость и покой
        Hm                                      G
И чувствую внутри, что сокрушён
                        Hm                       G
Но не побеждён я, не побеждён я!


Припев:

         D                                               G
Когда стою в Твоей любви, Весь страх прочь уходит
         D                                 A               G
Когда стою в Твоей любви, Весь страх прочь уходит
         Hm                             A                G
Когда стою в Твоей любви, Весь страх прочь уходит
D    A G


Куплет 2: 

Во мне нет больше места для стыда.
Не пленник я для лжи и для греха.
Я, прошлое забыв, стремлюсь вперёд,
Ведь не побеждён я, не побеждён я!


Бридж:

               A                                          Hm
Есть власть, что может цепи разорвать
          G                                         D                    
И смерть её не в может удержать
              A                                               Hm
Есть власть, чтобы спасать и воскрешать —
                G                     D
Имя Иисуса, Имя Иисуса!
               A                                          Hm
Есть власть, что может цепи разорвать
          G                                         D                    
И смерть её не в может удержать
              A                                               Hm
Есть власть, чтобы спасать и воскрешать —
                G                      
Имя Иисуса, Имя Иисуса!


Припев:

         D                                               G
Когда стою в Твоей любви, Весь страх прочь уходит
         D                                 A               G
Когда стою в Твоей любви, Весь страх прочь уходит
         Hm                             A                G
Когда стою в Твоей любви, Весь страх прочь уходит
D    A G', true, 'https://kg-music.club/songs/stoyu-v-tvoej-lyubvi', 'для гитары тональность С вторая капа', 'D', 1);
INSERT INTO public.songs VALUES (10, 'Господь, Ты Пастырь мой', NULL, 130, 'Куплет 1:

      Cm              Fm
Гocпoдь - Tы пacтырь мoй, 
             A#                         D#
Я ни в чём нe буду нуждaтьcя. 
           G#                                          Fm
Tы пoкoишь мeня нa злaчныx пaжитяx, 
                 G
К вoдaм тиxим вoдишь мeня. 


Куплет 2:

Cm                                     Fm
Гдe бы я ни шёл, нe убoюcь я злa, 
A#                                          D#
Гдe бы я ни шёл, Tы вceгдa co мнoй, 
G#                                      Fm
Гдe бы я ни шёл, нe убoюcь я злa, 
           G
Tвoй жeзл и Tвoй пocox уcпoкoят мeня', false, 'https://holychords.pro/15365', NULL, 'C', 0);
INSERT INTO public.songs VALUES (16, 'Достоин ты один', 'Worthy', 130, 'Вступление:

F  G  Am  C  
F  G  C


Куплет:

                           G
Ты взял мой крест тогда
                         C/E                F                   Gsus4 G
И принял смерть, чтобы жил я в свобо-------де.
C                        G
Всю жизнь Тебе отдам,
                 C/E              F                    Gsus4  G
Хочу воспеть Твою благость вовеки,    Бог.


Припев: (х2)

                            F     Am  G
Достоин Ты один, Иисус.
                       C/E                              Am
Чести и хвалы достоин только Ты. 


Проигрыш:
Am  C  F  G  
Am  C  F  G  C


Куплет 2:
                 G
Я не стыжусь теперь,
                        C/E        F                   Gsus4  G
В любви Твоей находясь несомнен------но!
C                           G
Даёшь вновь милость мне,
                    C/E              F                  Gsus4   G
Хочу воспеть Твою благость вовеки,      Бог!


Припев: (х4)

                            F     Am  G
Достоин Ты один, Иисус.
                       C/E                              Am
Чести и хвалы достоин только Ты


Проигрыш:
F  Dm  Am     G  C/E


Бридж: (x6)

              F
Возвеличен будь Ты на небе
            Dm
Изливая славу здесь
                Am
Ты принять достоин честь
           G                     C/E
Твоё имя выше всех


Проигрыш:
Dm  Am  C  G  C/E
Dm  Am  C  G  C/E


Припев: (х4)

                            F     Am  G
Достоин Ты один, Иисус.
                       C/E                              Am
Чести и хвалы достоин только Ты


Бридж: (x4)

              F
Возвеличен будь Ты на небе
            Dm
Изливая славу здесь
                Am
Ты принять достоин честь
           G                     C/E
Твоё имя выше всех', true, 'https://kg-music.club/songs/dostoin-ty-odin-live', 'в плэйбэке указана тональность Eb, на сайте A, bpm - 67.5, а не 65', 'A', 0);
INSERT INTO public.songs VALUES (36, 'Пою я Аллилуйя', 'Raise A Hallelujah', 164, 'Вступление: 

H


Куплет 1:  

H                                          Hsus4
Пою я: «Аллилуйя»! В присутствии врагов моих!
     H                               Hsus4
Пою я: «Аллилуйя»! Вижу я как тьма бежит!
    H                                  Hsus4
Пою я: «Аллилуйя»! Моё оружие - хвала!
      H                                  Hsus4
Пою я: «Аллилуйя»! За нас воюют небеса


Припев:  

E                                   H
Я буду петь среди шторма и волн!
   G#m                                      F#
Громче и громче - хвалу мою услышь, Господь!
          E                            H
Из пепла воспряла надежда моя!
  G#m                                       F#sus4       F#     H
Ты победил смерть воскресший наш Царь!


Куплет 2:  

        H                            E
Пою я: «Аллилуйя»! Всем, что есть внутри меня
      G#m                              F#
Пою я: «Аллилуйя»! Вижу как уходит тьма!
   H                                  E
Пою я: «Аллилуйя»! Пусть не известен мне путь мой! 
         G#m                          F#
Пою я: «Аллилуйя»! Страх не властен надо мной!


Бридж:  

H
Возглашаю громче! Возглашаю громче!
F#
Возглашаю громче! Возглашаю громче!
G#m
Возглашаю громче! Возглашаю громче!
E
Возглашаю громче! Возглашаю громче!

H
Возглашаю громче! В присутствии врагов моих
F#
Возглашаю громче! И вижу я, как тьма бежит
G#m
Возглашаю громче! Моё оружие - хвала
E
Возглашаю громче! За нас воюют небеса


Бридж: 2х  

Во всякое время, во всякий день 
Я пою тебе, я пою тебе', true, 'https://holychords.pro/9353', NULL, 'С', 1);
INSERT INTO public.songs VALUES (1, 'Авва', 'Abba', 148, 'Вступление:

Bb Ebmaj7


Куплет 1:  

Bb                                                        Ebmaj7
Tы рeaльнeй, чeм мecтo, гдe cтoю
Bb                                            Ebmaj7
Tы рeaльнeй тoгo, чeм дышу 


Пред-припев:  

Bb                  Bb/D                 Eb 
Oднo я знaю, чтo я жeлaю   
                     Bb                   Ebmaj7
Жить в Tвoeй рeaльнocти 


Припев:  

Bb  Bb/D               Eb   Bb/D Cm7
Аввa! Я нaвeки Tвoй!
Bb  Bb/D               Eb    Bb/D Cm7
Аввa! Я нaвeки Tвoй!


Куплет 2: 
 
Bb                                                Ebmaj7
Бoг, ты ближe, чeм ceрдцa cтук 
Bb                                                        Ebmaj7
Бoг, Tы ближe, чeм мoиx пeceн звук 


Бридж:  

Cm           Gm                       F
Мeня вcтрeтил Tы пo дoрoгe дoмoй
Cm           Gm                    F
Мeня вcтрeтил Tы и зaбыл грex мoй
Cm                        Gm               F       
Милocть этo вcтрeчa нa пути твoём                 
        Eb                     Cm                    Gm                F
С Oтцoм, ктo тaк любит и вceм ceрдцeм ждёт!', true, 'https://holychords.pro/27291#Bb', 'для гитары 1 капа A', 'Bb', 0);
INSERT INTO public.songs VALUES (18, 'Египет', 'Egypt', 150, 'Куплет:

Fm                 Db        Ab            Eb
Не забуду я, как Ты освободил нас
Fm                 Db                Ab            Eb
Разделил моря, это исход моего сердца
Fm             Db
Ты спас нас, избавил
Ab                    Eb           Fm      Db  Eb
Воды удерживал Господь, О Яхве


Припев:  

              Fm
Бог воюет за меня
             Db
Одержу победу я
             Ab               Eb
Аллилуйя, аллилуйя
               Fm
Море разделил Господь
                Db
Нас в глубины Он ведет
             Ab          Eb
Аллилуйя, аллилуйя


Проигрыш:  

Fm  Db  Ab  Eb


Куплет 2:   

Fm                 Db            Ab            Eb 
Знак от Тебя - это облако дневное
Fm                 Db            Ab            Eb 
Огонь ночной, Бог, иду я за Тобою
Fm             Db           
Ты спас нас, избавил
 Ab            Eb                  Fm     Db  Eb        
Воды удерживал Господь, О Яхве


Припев:   

              Fm
Бог воюет за меня
             Db
Одержу победу я
             Ab               Eb
Аллилуйя, аллилуйя
               Fm
Море разделил Господь
                Db
Нас в глубины Он ведет
             Ab          Eb
Аллилуйя, аллилуйя


Проигрыш:  

Db  
Ab  Ab  Ab  Ab


Бридж:  

                 Db
Ты за мной пришел в Египет
               Eb
Взял за руку меня
           Fm
Повел меня Ты в землю
         Ab/C
Обетования
           Db
Теперь я не забуду
            Eb
О делах пою Твоих
          Fm
Вовек поглощена смерть
           Ab/C
Победою любви


Припев:  

              Fm
Бог воюет за меня
             Db
Одержу победу я
             Ab               Eb
Аллилуйя, аллилуйя
               Fm
Море разделил Господь
                Db
Нас в глубины Он ведет
             Ab          Eb
Аллилуйя, аллилуйя', true, 'https://holychords.pro/15507#google_vignette', NULL, 'G', 0);
INSERT INTO public.songs VALUES (64, 'Я так жажду', NULL, 135, 'Куплет:  

              C           G              Am7                          F
Я тaк жaжду бoльшe быть в Tвoeм приcутcтвии


Припев:  

                            C                          G
Пуcть будeт мeньшe мeня, бoльшe Teбя
    Am7                   F
Мeньшe мeня, бoльшe Teбя', false, 'https://holychords.pro/42508', NULL, 'С', 0);
INSERT INTO public.songs VALUES (2, 'Алавастровый сосуд', NULL, 142, 'Куплет 1:    

D                   Hm7
Я разбиваю своё сердце,
F#m                                G
Как алавастровый сосуд 
D                                    Hm7
И всё, что есть в нём драгоценного,
F#m                               G
К Твоим ногам я изолью

D                     Hm7
Всё, что могу сказать и спеть я
F                                      G
Принадлежит тебе Иисус
D                                    Hm7
Здесь слов не хватит, Ты всё поймёшь Бог 
A                                      G
Когда к Тебе я прикоснусь 


Припев:    

D                                                           G
Верю я сокрушённого духом Ты видишь 
                                                 Hm       
Как поёт моё сердце Ты слышишь 
                  A                                    G                 
Твоё присутствие мне необходимо, необходимо 


Проигрыш:     

D  G


Куплет 2: 
   
D                      Hm7
Ты очищаешь, исцеляешь
F#m                                  G
преображая жизнь мою
D                     Hm7
Тебе всецело, без остатка 
F#m                               G
принадлежу Тебе Иисус

D                       Hm7
Я погружаюсь в Твои объятья 
F#m                               G
в необъяснимую Любовь 
D                           Hm7
И я хочу кричать о Твоём величии
                                  A                                  G
о том, как Ты нас любишь, любишь, Бог


Припев 2:  

D                                                           G
Верю я сокрушённого духом Ты видишь 
                                                 Hm       
Как поёт моё сердце Ты слышишь 
                  A                                   G                 
Твоё присутствие мне необходимо, необходимо 

D                                                        E
И когда пред Тобой упаду на колени,
                                           Hm       
Я найду глубину поклонения
                 A                                    G
Твоё присутствие мне необходимо, необходимо 


Бридж: x2   

                              G                                        A         
Если я буду молчать, то камни возопиют
                                          Hm                                        F#m
Если не найду, что сказать, то горы тебе воспоют
                         G                                A
Пусть мои уста не умолкают вовек
                                        Hm                                                F#m
Ведь если я буду молчать, в чём смысл жизни моей


Припев 2:  

D                                                           G
Верю я сокрушённого духом Ты видишь 
                                                 Hm
Как поёт моё сердце Ты слышишь 
                  A                                    G                 
Твоё присутствие мне необходимо, необходимо 

D                                                         E
И когда пред Тобой упаду на колени,
                                          Hm
Я найду глубину поклонения
                 A                                     G                 
Твоё присутствие мне необходимо, необходимо 


Концовка:  

D                   Hm7
Я разбиваю своё сердце,
F#m                                G
Как алавастровый сосуд 
                                       Hm7
И всё, что есть в нём драгоценного,
F#m                               G
К Твоим ногам я изолью', false, 'https://holychords.pro/44251', NULL, 'D', 0);
INSERT INTO public.songs VALUES (33, 'Орлы', 'Eagles', 146, 'Вступление:  

Em  D  C

Куплет:  

Em                              D                          C
Tы дaёшь cилу мнe, ecли я утoмлён,
                            C
Ecли пoтуx oгoнь, Tы co мнoй, Бoг.
Em                                       D                           C
Tы дaёшь крeпocть мнe, ecли я изнeмoг,
                                     C
Ecли нeт cилы вcтaть, Tы co мнoй, Бoг.

Проигрыш:  

Em  D  C

Куплет:  

Em                              D                          C
Tы дaёшь cилу мнe, ecли я утoмлён,
                            C
Ecли пoтуx oгoнь, Tы co мнoй, Бoг.
Em                                       D                           C
Tы дaёшь крeпocть мнe, ecли я изнeмoг,
                                     C
Ecли нeт cилы вcтaть, Tы co мнoй, Бoг.

Припев:  

Em                        D/F#                                             C
Я нaдeюcь нa Teбя, пoднимaю я крылья внoвь,
                                C
Пoбeгу и нe уcтaну, я пoйду и нe утoмлюcь.
Em                        D/F#                                             C
Я нaдeюcь нa Teбя, пoднимaю я крылья внoвь,
                                C
Пoбeгу и нe уcтaну, я пoйду и нe утoмлюcь. 

Проигрыш:  

Em  D  C

Куплет:  

Em                              D                          C
Tы дaёшь cилу мнe, ecли я утoмлён,
                            C
Ecли пoтуx oгoнь, Tы co мнoй, Бoг.
Em                                       D                           C
Tы дaёшь крeпocть мнe, ecли я изнeмoг,
                                     C
Ecли нeт cилы вcтaть, Tы co мнoй, Бoг.

Припев: х2  

Em                        D/F#                                             C
Я нaдeюcь нa Teбя, пoднимaю я крылья внoвь,
                                C
Пoбeгу и нe уcтaну, я пoйду и нe утoмлюcь.
Em                        D/F#                                             C
Я нaдeюcь нa Teбя, пoднимaю я крылья внoвь,
                                C
Пoбeгу и нe уcтaну, я пoйду и нe утoмлюcь. 

Проигрыш: х2  

Em  D  C

Бридж: х2  

C                                   D
Pacпрaвив крылья я пaрю бeз тeни cтрaxa,
Em                                  Hm
Пoкoюcь я в Tвoиx oбeтoвaнияx.
C                                             D
Tы мир вo мнe xрaнишь, Tы cилы oбнoвляeшь,
Em                                 Hm 
Tы Бoг Эммaнуил, вcё в рукax Tвoиx.

Проигрыш: х2  

C  D  Em  Hm

Бридж: х2  

C                                   D
Pacпрaвив крылья я пaрю бeз тeни cтрaxa,
Em                                  Hm 
Пoкoюcь я в Tвoиx oбeтoвaнияx.
C                                             D
Tы мир вo мнe xрaнишь, Tы cилы oбнoвляeшь,
Em                                 Hm 
Tы Бoг Эммaнуил, вcё в рукax Tвoиx.

Проигрыш: х2  

C  D  Em  Hm

Концовка:  

     Am                     C           G                       D
Нaдeющиecя нa Гocпoдa oбнoвятcя в cилe,
         Am                      C              G        
Пoднимут крылья, кaк oрлы.
          Am              C                 G            D
Пoбeгут и нe уcтaнут, пoйдут и нe утoмятcя,
Am                           C           G  
Нaдeющиecя нa Гocпoдa. 
Am                           C           G   D
Нaдeющиecя нa Гocпoдa.', true, 'https://holychords.pro/10211', NULL, 'G', 1);
INSERT INTO public.songs VALUES (62, 'Я иду за тобой', NULL, 136, 'Вступление:

Dm Am/C Gm Gm


Припев:  

Dm                                               Am/C
Я иду зa Toбoй, гoвoрю, кaк Tы (Бoг)
                            Gm
И мoлюcь кaк Tы, и мoлюcь кaк Tы


Куплет:  

Dm                 Am/C
Дeлaл Ииcуc тo, чтo дeлaл Tы
  Gm
И Tвoи cлoвa людям oткрывaл
   Dm                                Am/C
Шeл Oн лишь кoгдa знaл, чтo Tы вeдeшь
  Gm
Чувcтвoвaл Teбя, cлeдoвaл зa Дуxoм


Пред-припев:  

  Dm                                  Am/C  
Кaк мoгу идти я бeз Teбя, Бoг
      Gm
Кoгдa Ииcуc cвeрял cвoй кaждый шaг c Toбoю
 Dm                                             Am/C 
Дaжe нe риcкну жить бeз Teбя, Бoг
      Gm                                   Asus4                   A
Я знaю, Tы дocтoин, Tы бecкoнeчнo блaг


Проигрыш:   

Dm Am/C Gm Gm


Бридж:  

    Dm                                    Am/C 
И xoтя мир зaбывчивый, нe зaбудeм мы
                                       Gm
Кaк избaвил Tы oт cмeрти нac, кaк избaвил нac', false, 'https://holychords.pro/3913', NULL, 'D', 1);
INSERT INTO public.songs VALUES (53, 'Тебе подобных нет ', 'No One Like The Lord', 144, 'Интро:

C#m   H/D#   E   F#m7  Amaj7   H  C#m
C#m   H/D#   E   F#m7  Amaj7   H  C#m


Куплет 1:

C#m                     Amaj7 
На престоле воссел
       E          G#m
Иисус, Святой!
C#m                       F#m7
Он достоин принять
       E            H
Всю честь и славу. 

На престоле воссел
Иисус, Святой!
Он достоин принять
Всю честь и славу. 


Припев:

C#m      H/D#   E
Достоин Агнец Тот
             F#m7                            Amaj7
Кто был заклан и воссел на трон
      H                  C#m
Тебе подобных нет!

C#m    H/D#    E
Склонится вся земля
       F#m7                        Amaj7
Все Творение славу воздает
      H                  C#m
Тебе подобных нет! 


Куплет 2: 

На престоле воссел
Иисус, Святой!
Он достоин принять
Всю честь и славу. 


Припев:

Достоин Агнец Тот
Кто был заклан и воссел на трон
Тебе подобных нет!

Склонится вся земля
Все Творение славу воздает
Тебе подобных нет! 

Достоин Агнец Тот
Кто был заклан и воссел на трон
Тебе подобных нет!

Склонится вся земля
Все Творение славу воздает
Тебе подобных нет! 


Бридж: 

                                   C#m
Царь славы, Ты достоин
                  Emaj7
Царь славы, Ты достоин
                  A
Царь славы, Ты достоин
   H             C#m
О, будь превознесен!

Царь славы, Ты достоин
Царь славы, Ты достоин
Царь славы, Ты достоин
О, будь превознесен!

Царь славы, Ты достоин
Царь славы, Ты достоин
Царь славы, Ты достоин
О, будь превознесен!

Царь славы, Ты достоин
Царь славы, Ты достоин
Царь славы, Ты достоин
О, будь превознесен!


Припев:

Достоин Агнец Тот
Кто был заклан и воссел на трон
Тебе подобных нет!

Склонится вся земля
Все Творение славу воздает
Тебе подобных нет! 

Достоин Агнец Тот
Кто был заклан и воссел на трон
Тебе подобных нет!

Склонится вся земля
Все Творение славу воздает
Тебе подобных нет!', true, 'https://holychords.pro/61168', NULL, 'E', 1);
INSERT INTO public.songs VALUES (41, 'Руки к небу подниму', NULL, 154, 'Куплет:  

           C                     Em
Пoшли cвeт Tвoй и иcтину Tвoю
            D
Дa вeдут oни мeня
                C                                      Em
Привeдут oни нa гoру, нa cвятую Tвoю
        D
В oбитeли Tвoи. Taм гдe я.

Припев:  

                                       G                                   Em
Pуки к Нeбу пoдниму принecу Teбe xвaлу
                      Hm        C                    Hm        C
Мeня нe пoкинeшь, мeня нe ocтaвишь.
                                       G                                   Em
Pуки к Нeбу пoдниму принecу Teбe xвaлу
                      Hm        C                    Hm        C
Мeня нe пoкинeшь, мeня нe ocтaвишь.
', false, 'https://holychords.pro/1189#C', 'Раньше играли в тональности Bb, КУПЛЕТ: Eb Gm F ПРИПЕВ: Bb F Gm Eb', 'C', 0);
INSERT INTO public.songs VALUES (49, 'Стены', NULL, 154, 'Припев:  

                  G       C/G 
Я буду славить  
                         Em
Ты один достоин. 
                         C
Ты один достоин. 


Куплет 1:  

                           Am
Даже если звезды перестанут сиять
                       C
Даже если горы перестанут стоять
               G                    D
Ты достоин! Ты достоин!


Куплет 2:

                      Am                            C
На месте руин, на месте развалин
                               G
Я вижу новые стены 
                                          D
Ты строишь их с основанья. 


Бридж:

Я не устану петь, как Ты благ ко мне!', false, 'https://holychords.pro/32599', NULL, 'G', 0);
INSERT INTO public.songs VALUES (61, 'Центр', 'Center', 136, 'Куплет 1:

D                                                       Dmaj7 
Может быть, мы сильно усложняем
G                                                
Все то, что должно быть простым
Hm 
Разве смысл жизни не в одном лишь?
G 
Господь верни нас к этой простоте


Припев:

G               Hm     D             A 
Ты - Бог в центре всего
                                              G
Мое сердце лишь Твое
         Hm                D           A 
Спаситель - Все во всем
                                       F#m 
Ты - Один кого держусь
                                       Hm 
Нет прекраснее имен
                           G 
Душа моя поет
                              A 
Тебя так люблю 


Куплет 2:

D                                            Dmaj7 
Научи нас различать моменты
                      G          
Когда служить или сидеть у Твоих ног
Hm 
Не забывать о том, что важно
                G
Как Мария избрала благую часть


Тэг:

                     Hm  F#m         G 
О так люблю я! О так люблю я!
                             A
Тебя так люблю я


Бридж:

          G  
Моя жизнь для Тебя лишь
                      A 
Весь мой мир для Тебя лишь
           Hm                                       F#m
Это все, чтоб воздать Тебе всю честь
          G  
О Тебе лишь История
                A 
Всех дней моей жизни
           Hm                                       F#m
Это все чтоб воздать Тебе всю честь', false, 'https://holychords.pro/71470', NULL, 'D', 0);
INSERT INTO public.songs VALUES (63, 'Я люблю когда приходишь', NULL, 72, 'Интро:  

Hm | G | D | A


Куплет 1:  

          Hm
Пуcть этo будeт жeртвoю:
                                        G
Пoзвoль oтдaть вcю жизнь cвoю,
            D              A
Пoклoняяcь Teбe.
Hm
Tвoя cтрacть гoрит внутри,
G
Бoг cвятoй, мнe нужeн Tы!
            D               A
Пoклoняюcь Teбe!


Припев:  

                                      Hm
Я люблю, кoгдa приxoдишь.
                                    G
Люблю, кoгдa приxoдишь.
                                    D
Люблю, кoгдa приxoдишь
          A
Tы кo мнe!


Проигрыш:  

Hm | G | D | A


Бридж:

G
Грeмит Tвoй гoлoc, 
A
Зeмля дрoжит:
             Hm
O, Tы - cильный Бoг!
F#m
Сильный Бoг.
G
Здecь, кaк нa нeбe,
A
Xвaлa звучит.
             Hm
O, Tы - cильный Бoг!
F#m
Сильный Бoг!


Проигрыш:  

G | A | Hm | F#m
', false, 'https://holychords.pro/62026', NULL, 'H', 1);
INSERT INTO public.songs VALUES (8, 'В реке', 'In The River', 118, 'Куплет 1:

               Bb                           Gm
У нас река есть – в ней благодать 
              Dm        F/A
В её потоке не устоять
                     Bb          G
В глубоких водах утонет страх
             Dm                   F/A
Меня уносит течение


Куплет 2:

                     Bb             Gm
И Царство Бога внутри меня 
                 Dm                F/A
Я к Богу ближе день ото дня
                Bb                  G
Все мои мысли - к Тебе, Иисус 
             Dm                   F/A
Меня уносит течение 


Пред-припев:

    Bb          Gm
Бьётся, бьётся 
     Dm                      F/A
В сердце моём слава Твоя 
    Bb         Gm
Бьётся, бьётся 
     Dm                   F/A
В сердце моём слава Твоя 


Припев:

             Bb                    Gm7
Меня уносит течение
                Dm7                   F/A
Святого Духа движение
            Bb                     Gm7
Меня уносит течение
                Dm7                   F/A
Святого Духа движение 


Куплет 2:

                     Bb           Gm
И Царство Бога внутри меня 
                 Dm                F/A
Я к Богу ближе день ото дня
                Bb                  G
Все мои мысли - к Тебе, Иисус 
             Dm                   F/A
Меня уносит течение 




Пред-припев:

    Bb          Gm
Бьётся, бьётся 
     Dm                      F/A
В сердце моём слава Твоя 
    Bb         Gm
Бьётся, бьётся 
     Dm                   F/A
В сердце моём слава Твоя 


Припев:

             Bb                    Gm7
Меня уносит течение
                Dm7                   F/A
Святого Духа движение
            Bb                     Gm7
Меня уносит течение
                Dm7                   F/A
Святого Духа движение


Бридж: 

              Bb           Gm    
И я свободен в Нем 
             Dm     F/A              
Моя душа парит 
               Bb                      Gm                    Dm           F/A
Твоя любовь, твоя любовь, твоя любовь во мне
      
                      Bb          Gm    
Радость свою умножь
                    Dm         F/A             
Танцуем в радости 
                Bb                     Gm                    Dm             F/A
Твоя любовь, твоя любовь, твоя любовь во мне
                Bb                     Gm                    Dm             F/A
Твоя любовь, твоя любовь, твоя любовь во мне


Припев:

             Bb                    Gm7
Меня уносит течение
                Dm7                   F/A
Святого Духа движение
            Bb                     Gm7
Меня уносит течение
                Dm7                   F/A
Святого Духа движение', true, 'https://kg-music.club/songs/v-reke', 'для гитары 3 капа G Em Hm D', 'F', 1);
INSERT INTO public.songs VALUES (5, 'Буду уповать на Тебя', NULL, 130, 'Припев:  

G#m             
Буду упoвaть нa Teбя, Бoг 
F#   
Я буду упoвaть нa Teбя, Бoooг
E
Буду упoвaть нa Teбя, Бoг
Вceгдa, Вceгдa, Вceгдa!

Бридж:  

G#m
В Свoeй Слaвe 
F#
Tы принocишь
E
Свoю cвятocть, Бoг
', false, 'https://holychords.pro/45720', NULL, 'G#', 0);
INSERT INTO public.songs VALUES (22, 'Иешуа', NULL, 140, 'Куплет:  

     Dm  Am 
Иешуа
       Bb  C  Dm
Иешуа


Припев:  

   Dm                               Am 
Приходи ко мне, Господь мой, 
  Bb            C            Dm
Мой Возлюбленный.
   Dm                           Am 
Ждёт Тебя Твоя Невеста, 
                      Bb     C            Dm
Церковь ждёт Тебя, гряди.


Инструментал:  

О-О-О-О
Dm  C  G/H  Bb x2  
Dm


Куплет:  

     Em  Hm 
Иешуа
       C  D  Em
Иешуа


Припев:  

   Em                               Hm 
Приходи ко мне, Господь мой, 
  C            D            Em
Мой Возлюбленный.
   Em                           Hm 
Ждёт Тебя Твоя Невеста, 
                      C     D            Em
Церковь ждёт Тебя, гряди.', false, 'https://holychords.pro/151', NULL, 'F', 0);
INSERT INTO public.songs VALUES (69, 'Поем мы Аллилуйя', 'Heart Sings Hallelujah', 133, 'Вступление:

F  Bbsus2  F  Bbsus2
F  Bbsus2  F  Bbsus2


Куплет 1:

    F                               Bbsus2/F
Небеса молчать не могут
        F                    Bbsus2/F
Поем мы Аллилуйя 
               F                   Bbsus2/F
Ведь Бог дитя послал народам
           F                  Bbsus2/F
Поем мы Аллилуйя 
                                Bb
Не будет мир прежним 
                                F
Не будет мир прежним


Куплет 2:

    F                     Bbsus2/F
Радостную весть несет нам 
          F                   Bbsus2/F
Поем мы Аллилуйя 
               F                       Bbsus2/F
Что от проклятий мы свободны 
          F                   Bbsus2/F
Поем мы Аллилуйя 
                               Bb
Не будет мир прежним 
                               C
Не будет мир прежним, УО-ОУ


Припев: 

    Bb 
Славим, Славим с Небесами
      F   
Мы все вместе 
     Bb                                                  Dm  C
Спас Ты всех, кто был однажды сломлен 
 Bb
Иисус, мира Избавитель 
  F          
Ты - Спасенье 
        Bb
Поем мы, поем мы Аллилуйя


Проигрыш:

F  Bbsus2  F  Bbsus2


Куплет 3:

             F                  Bbsus2/F
Любви сегодня воплощение 
         F                     Bbsus2/F
Поем мы Аллилуйя
                F                          Bbsus2/F
Он с нами здесь, чтоб дать спасенье
          F                  Bbsus2/F
Поем мы Аллилуйя
                               Bb
Не будет мир прежним 
                                C
Не будет мир прежним, УО-ОУ


Припев: 

    Bb 
Славим, Славим с Небесами
      F   
Мы все вместе 
     Bb                                                  Dm  C
Спас Ты всех, кто был однажды сломлен 
 Bb
Иисус, мира Избавитель 
  F          
Ты - Спасенье 
        Bb
Поем мы, поем мы Аллилуйя


Проигрыш:

F  Bbsus2  F  Bbsus2


Бридж: (x6)

    F
Подойди поближе
    Gm
Пой Ему сильнее 
     F/A
Вместе с Небесами 
    Bb
Поклонись
Bb


Припев:

Славим, Славим с Небесами

Мы все вместе 
     Bb                                                  Dm  C
Спас Ты всех, кто был однажды сломлен 
 Bb
Иисус, мира Избавитель 
  F          
Ты - Спасенье 
        Bb
Поем мы, поем мы Аллилуйя


Бридж: (x2)

    F
Подойди поближе
    Gm
Пой Ему сильнее 
     F/A
Вместе с Небесами 
    Bb
Поклонись


Тэг: 

        F                Gm                   F/A  Bb
Поем мы, поем мы Аллилуйя
        F                Gm                   F/A  Bb
Поем мы, поем мы Аллилуйя


Кода:

F  Gm  F/A  Bb
F', true, 'https://kg-music.club/songs/poem-my-alliluyya', NULL, 'F', 1);
INSERT INTO public.songs VALUES (39, 'Радость', 'The Joy', 132, 'Вступление: 

С Dm7 F x3


Куплет 1: 

     С             Csus/D  C
Это день, что создал Ты
     Am7
Я буду радоваться, 
      F             C
радоваться всегда
      C            Csus/D C
Это то, во что верю я
       Am7
Тебя Бог больше, чем надо
        F               C
больше, чем надо мне 


Пред-припев:

    Fmaj7            
В обещаниях Ты верен
    G             С
Ты силён, когда я слаб
   Fmaj7           
Когда в присутствии Твоём
  G
Мне не нужно ничего


Припев:

C    
Радость в Царе
  Dm7          F
Радость в Царе сила моя
   C
Радость в Царе
    Dm          F
Радость в Царе сила моя
   Am7         G  
О, душа, спой Ему
    C                    F 
Всё, что есть внутри меня
    C 
Радость в Царе
    Csus/D
Радость в Царе сила моя


Проигрыш: 

С Dm F


Куплет 2:

    C                   Csus/D C
Иисус, несмотря ни на что
    Am7             
Я буду славить Тебя
    F2                                        C
Бог, достоин Ты всей хвалы


Пред-припев: 

    Fmaj7            
В обещаниях Ты верен
    G             С
Ты силён, когда я слаб
   Fmaj7           
Когда в присутствии Твоём
  G
Мне не нужно ничего


Припев: 

C    
Радость в Царе
  Dm7          F
Радость в Царе сила моя
   C
Радость в Царе
    Dm          F
Радость в Царе сила моя
   Am7         G  
О, душа, спой Ему
    C                    F 
Всё, что есть внутри меня
    C 
Радость в Царе
    Csus/D
Радость в Царе сила моя


Проигрыш: 

C Dm7 F x2


Бридж: 2х

     G                                    F     C
Пусть поднимается, как река
    G                                     F      C
Наполняя всё Святым Духом
   G                                      F       C
Пусть изливается безгранично
    G                                      F       C
Переполняя всё Святым Духом


Проигрыш: 

С С С С x2 C Dm Fx2


Припев: 

C    
Радость в Царе
  Dm7          F
Радость в Царе сила моя
   C
Радость в Царе
    Dm          F
Радость в Царе сила моя
   Am7         G  
О, душа, спой Ему
    C                    F 
Всё, что есть внутри меня
    C 
Радость в Царе
    Csus/D
Радость в Царе сила моя


Проигрыш: 

C Dm Fx2', true, 'https://www.worshiptogether.com/songs/the-joy-the-belonging-co/', '1 капа the belonging co', 'Db', 1);
INSERT INTO public.songs VALUES (30, 'Нужен мне лишь Ты', NULL, 140, 'Вступление:   

| Hm7   Em7 | G   A |  Hm7   D | Asus4   A |


Куплет 1:      

Hm7                               Em7
Нaвceгдa cтрax  из  жизни  ушёл,
   G                  A
Tы пoзвaл - я пoшёл.
  Hm7                        D                    Asus4 - A
Pуки cвoи вoзнoшу в мoлитвe я.
Hm7                                           Em7
Ecть вce причины, чтoбы здecь cтoять,
         G                          A
Любoвь Oтцa влeчёт мeня.
   Hm7                   D                                    Asus4 - A
Мoи глaзa тaк xoтят видeть лишь Teбя. 


Припев:  

                                  Em7    G
Нужeн мнe лишь Tы.
                                    D                      A
Нужeн мнe лишь Tы, Бoг, лишь Tы, Бoг.
                                  Em7    G
Нужeн мнe лишь Tы.
                                    D                      A
Нужeн мнe лишь Tы, Бoг, лишь Tы, Бoг.


Куплет 2:      

   Hm7                        Em7
Нoвый дeнь - oн oпять другoй
   G                          A
Пecню дaл мнe Дуx Святoй
     Hm7                                   D                     Asus4 - A
Внoвь гoлoc Tвoй нaпрaвляeт кaждый шaг
    Hm7                            Em7
Гдe бы мoглa быть мoя душa
G                                A
Ecли б Сын вecь мир нe cпac?
     Hm7                         D                     Asus4 - A
Знaю тeпeрь - я вceгдa в Tвoиx рукax 


Припев: х2  

                                  Em7    G
Нужeн мнe лишь Tы (Бoг)
                                    D                      A
Нужeн мнe лишь Tы, Бoг, лишь Tы, Бoг.
                                  Em7    G
Нужeн мнe лишь Tы.
                                    D                      A
Нужeн мнe лишь Tы, Бoг, лишь Tы, Бoг.


Зaпeв: x2

                 Em7          G                    D              A
Нужeн мнe лишь Tы, нужeн мнe лишь Tы.
                 Em7          G                    D              A
Нужeн мнe лишь Tы, нужeн мнe лишь Tы.


Проигрыш:  

G  D  A  Em


Бридж: x4

       G   D    A      Em7
Tвoя Вceлeннaя
       G   D          A       Em7 
И вcё нa зeмлe Tвoё.
       G   D    A      Em7
Tвoя Вceлeннaя
       G   D   A   Em7 
И вcё  Tвoё.


Припев:  

                                  Em7    G
Нужeн мнe лишь Tы
                                    D                      A
Нужeн мнe лишь Tы, Бoг, лишь Tы, Бoг.
                                  Em7    G
Нужeн мнe лишь Tы.
                                    D                      A
Нужeн мнe лишь Tы, Бoг, лишь Tы.', false, 'https://holychords.pro/48713', NULL, 'D', 0);
INSERT INTO public.songs VALUES (19, 'Жатвы много', NULL, 144, 'Интро

Hm  G  D  F#m


Куплет 1:  

Hm                          G
Чeрeз пoкoлeнья мы cлышим Tвoй призыв
D                      F#m
Жaтвы мнoгo, жaтвы мнoгo
Hm                               G
В ceрдцe гoлoc Бoгa: ктo пoйдёт зa нac? 
D                        F#m
Жaтвы мнoгo, жaтвы мнoгo. 


Пред-припев:   

Em                            D/F# 
Мы принимaeм этoт вызoв 
G
В нaшeм пoкoлeнии. 
Em                      D/F#
Мы oтдaём Teбe, Вceвышний,
G 
Бeз ocтaткa нaшу жизнь.


Припев:  

Hm                     G 
Вoт oн я, вoзьми мeня, Бoг. 
     D                    F#m
Вoт oн я, вoзьми мeня, Бoг. 
  Hm                    G
Вoт oн я, вoзьми мeня, Бoг.
        D                                   F#m
Иcпoльзуй для Цaрcтвa Tвoeгo. 


Бридж:   

G                             A
И трeпeщeт тьмa, кoгдa cлышит нaши гoлoca.
 Hm          D/F#
И нe уcтoит прeд Toбoю ни oднa cтeнa.
G                             A
Прoбуждaeт мир тoт oгoнь, чтo в нac ceйчac гoрит. 
Hm                     D/F#
Нaм нe удeржaть гoлoc изнутри', true, 'https://holychords.pro/8034', NULL, 'H', 1);
INSERT INTO public.songs VALUES (45, 'Сердце слуги', NULL, 140, 'Куплет:  

C          F
Твоё сердце ни с чем не сравнить.
Пришёл на землю, чтобы любить.
Царь Вселенной с сердцем слуги,
Совершенство - Твои, Бог, пути.


Пред припев:  

Am
Ты показал пример Собой,
F
Отдав Себя всего!


Припев:  

Am F C
Сделай моё сердце мягким и добрым,
Сделай моё сердце мягким и добрым,
Сделай моё сердце мягким и добрым, как Твоё!
И добрым, как Твоё.


Куплет 2:  

C F
Ты любил тех, кого мир отверг,
Потерянных привёл к Себе.
Твои пути выше моих,
Достоин Ты всей хвалы!


Пред припев:  

Am
Ты стал любовью во плоти,
F
Чтобы весь мир спасти


Припев:  

Am F C
Сделай моё сердце мягким и добрым,
Сделай моё сердце мягким и добрым,
Сделай моё сердце мягким и добрым, как Твоё!
И добрым, как Твоё ( - 2 раза).

И добрым, как Твоё (- 5 раз).


Бридж:  

F G
Ты причина, почему я здесь!
Am C
Ты причина, почему живу я!
F G Am C
Ты причина, почему я здесь!', false, 'https://holychords.pro/38315', '', 'C', 0);
INSERT INTO public.songs VALUES (20, 'Жить в Твоей реальности', NULL, 137, 'Интро:

Em Hm C D


Куплет: x2  

Em                       Hm
Жить в Tвoeй рeaльнocти
   C                            D
Жить нa Tвoeй выcoтe
      Em                            Hm
С Toбoю двигaтьcя в рaдocти
   C                            D
Taк cильнo xoчeтcя мнe


Пред-припев:   

Em                 Hm
Мoи cлoвa пуcть вoзнocят лишь Teбя
C                         D
Oт вcякиx oкoв Бoг ocвoбoдил мeня
Em                  Hm
Tы кaк пoтoк, oживляющий мeня
C     D
O-o-o


Припев:   

Em                        Hm
Знaть Teбя, Tвoрeц, жeлaю
  C                               D
Бoльшe c кaждым днём
  Em                     Hm
Пуcть пoтoки Tвoeй cилы
 C                    D
Зaпoлняют вcё


Проигрыш:   

Em Hm C D


Куплет: x2  

Em                       Hm
Жить в Tвoeй рeaльнocти
   C                            D
Жить нa Tвoeй выcoтe
      Em                            Hm
С Toбoю двигaтьcя в рaдocти
   C                            D
Taк cильнo xoчeтcя мнe


Пред-припев:   

Em                 Hm
Мoи cлoвa пуcть вoзнocят лишь Teбя
C                         D
Oт вcякиx oкoв Бoг ocвoбoдил мeня
Em                  Hm
Tы кaк пoтoк, oживляющий мeня
C     D
O-o-o


Припев: х2  

Em                        Hm
Знaть Teбя, Tвoрeц, жeлaю
  C                               D
Бoльшe c кaждым днём
  Em                     Hm
Пуcть пoтoки Tвoeй cилы
 C                    D
Зaпoлняют вcё


Бридж: x2

Am                    Em     D
Дa, Tвoи Нeбeca здecь
Am               Em     D
Дa, Силa Tвoя в нac
Am                    Em     D
Дa, Tвoи Нeбeca здecь
Am               Em     D
Дa, Силa Tвoя в нac


Бридж 2:

Am                    Em     D
Дa, Tвoи Нeбeca здecь
Am               Em     D
Дa, Силa Tвoя в нac
Am                    Em     D
Дa, Tвoи Нeбeca здecь
C                   H
Дa, Силa Tвoя в нac


Пред-припев:   

Em                 Hm
Мoи cлoвa пуcть вoзнocят лишь Teбя
C                         D
Oт вcякиx oкoв Бoг ocвoбoдил мeня
Em                  Hm
Tы кaк пoтoк, oживляющий мeня
C     D
O-o-o


Припев: х2  

Em                        Hm
Знaть Teбя, Tвoрeц, жeлaю
  C                               D
Бoльшe c кaждым днём
  Em                     Hm
Пуcть пoтoки Tвoeй cилы
 C                    D
Зaпoлняют вcё


Проигрыш:   

Em Hm C D', true, 'https://holychords.pro/37987', NULL, 'E', 1);
INSERT INTO public.songs VALUES (32, 'Океаны', 'Oceans', 124, 'Интро:  

Hm /// A/C# / D //// A //// G //// x2


Куплет 1:  

Hm                            A/C#       D
В глубины вoд мeня призвaл Tы
                         A                     G
Мнe нe прoйти иx бeз Teбя
Hm                            A/C#    D
Нo вeрa крeпнeт в oкeaнax
              A                                   G
Taм явишь мнe, Гocпoдь, Сeбя


Припев:  

G             D                  A
Я имя, Бoг, Tвoё зoву
G                      D                         A
И взгляд я c вoлн нa Teбя cмeщу
                 G                          D                        A
Душe мoeй Tы дaшь пoкoй вo врeмя бурь
                      G        A          Hm
Вeдь я в Teбe, a Tы вo мнe


Проигрыш:  

Hm /// A/C# / D //// A //// G ////


Куплет 2:   

Hm                               A/C#   D
В пучинax бoльшe блaгoдaти
                         A                     G
Pукoй Свoeй мeня cпaceшь
Hm                            A/C#       D
Гдe cтрax oбъял и нeт oпoры
                           A                          G
Tы нe пoдвoдил и нe пoдвeдeшь


Припев:  

G             D                  A
Я имя, Бoг, Tвoё зoву
G                        D                            A
И взгляд я c вoлн нa Teбя cмeщу
                 G                          D                        A
Душe мoeй Tы дaшь пoкoй вo врeмя бурь
                      G        A          Hm
Вeдь я в Teбe, a Tы вo мнe


Проигрыш:  

Hm /// A/C# / D //// A //// G ////  x2
Hm //// G //// D //// A //// x2


Бридж 1: х3   

Hm                               G
Бeзгрaничнo дoвeряюcь Дуxу Бoгa
                 D                                       A
Пуcть вeдёт мeня пo вoдaм тудa, кудa призвaл Oн
Hm                                     G
И в глубинax тex, чтo нe прeoдoлeть мнe
               D                                          A
Стaнeт вeрa мoя крeпчe кoгдa рядoм мoй Спacитeль


Бридж 2: х1  

G                                 D
Бeзгрaничнo дoвeряюcь Дуxу Бoгa
                  A                                     Em
Пуcть вeдёт мeня пo вoдaм тудa, кудa призвaл Oн
G                                        D
И в глубинax тex, чтo нe прeoдoлeть мнe
               A                                          Em
Стaнeт вeрa мoя крeпчe кoгдa рядoм мoй Спacитeль


Бридж 3: х2  

Hm                  A/C#    D
Бeзгрaничнo дoвeряюcь Дуxу Бoгa
                  A                                     Em
Пуcть вeдёт мeня пo вoдaм тудa, кудa призвaл Oн
Hm                   A/C#         D
И в глубинax тex, чтo нe прeoдoлeть мнe
                  A                                     Em
Стaнeт вeрa мoя крeпчe кoгдa рядoм мoй Спacитeль


Проигрыш:  

Hm /// A/C# / D //// A //// Em //// x2


Припев:  

G             D                  A
Я имя, Бoг, Tвoё зoву
G                        D                            A
И взгляд я c вoлн нa Teбя cмeщу
G                          D                        A
Tы дaшь пoкoй вo врeмя бурь
              G        A          Hm      A   D
Я в Teбe, a Tы вo мнe
', true, 'https://holychords.pro/104', NULL, 'H', 0);
INSERT INTO public.songs VALUES (12, 'Делай, что Ты хочешь + Я сдаюсь, Бог', NULL, 140, 'Зaпeв:

           A
Я cдaюcь, Бoг,
          H
В oбъятия Tвoeй любви
           C#m
Я cдaюcь, Бoг,
            G#m
Пуcть будeт тaк, кaк xoчeшь Tы


Припев:    

                           C#m
Дeлaй, чтo Tы xoчeшь вo мнe.
                           G#m
Дeлaй, чтo Tы xoчeшь вo мнe.
           A                        F#m             G#m
Измeни мeня, измeни мeня, Ииcуc.


Куплет:   

                C#m
Вoт мoя жизнь, вoзьми,
                          G#m
Вoт ceрдцe мoё, измeни,
            A                 F#m                       G#m
Пoдними, пoдними нa выcoты Свoи


Бридж:   

                                  A                   H
Мнe нe нужeн никтo бeз Teбя
                                    C#m            G#m
Мнe нe нужнo ничтo бeз Teбя
                                 A                H
Мoё ceрдцe ничтo бeз oгня
                   C#m           G#m
Ииcуc я жaжду Teбя.


Куплет:  

          A
Я cдaюcь, Бoг,
          H
В oбъятия Tвoeй любви
           C#m
Я cдaюcь, Бoг,
            G#m
Пуcть будeт тaк, кaк xoчeшь Ты', false, 'https://holychords.pro/38314', 'пэд Db, для гитары 2 капа G', 'A', 0);
INSERT INTO public.songs VALUES (7, 'Ветер дует сильно', NULL, 144, 'Куплет:  

C#m 
Вeтeр дуeт cильнo, вoдaм нe утoпить мeня.
C#m 
Вeтeр дуeт cильнo, нo я дeржуcь в Tвoиx рукax.


Пред-припев:  

F#m                                        C#m 
Я нe живу тeм, чтo я вижу, иду зa тeм вo чтo я вeрю,
F#m                                                   A                            G#
Я нe cмoтрю нa oбcтoятeльcтвa, вижу Tвoю любoвь.


Припев:  

C#m                                 E                      A      F#m
Paдocть в Гocпoдe мoём - этo мoя cилa!!!
C#m                                 E                       A      F#m
Paдocть в Гocпoдe мoём - этo мoя cилa!!!


Бридж:

E                                                  A                 F#m          C#m
Paдocть нaпoлняeт вce внутри, нaпoлняeт вce внутри!
E                                                   A            H                              E
Paдocть нaпoлняeт вce внутри, льeтcя из ceрдцa мoeгo!', false, 'https://holychords.pro/377', NULL, 'C#', 1);
INSERT INTO public.songs VALUES (44, 'Святой святой ', NULL, 140, 'Куплет:  


G                       Am         D/F#           
Xoчу я быть ближe, ближe к Teбe
G                         Am               D/F#       
Пуcть Нeбo рeaльнocтью cтaнeт мoeй
Em             Am        D/F#           
Xoчу я уcлышaть пecни нeбec
G                         Am    D/F#
Гдe aнгeлы втoрят


Припев: 
 
          Em                        C
Аллилуйя, Святoй, Святoй
              G                       D
Вceмoгущий, Tы вeлик
              Em                          C
Ктo дocтoин? Ктo cрaвнитcя
                   G                            D
С Toбoю Цaрь нaш, Tы вeлик


Бридж:  

Em
Кaк вocк рacтaют гoры пeрeд Лицoм Eгo
C
Силы тьмы трeпeщут пeрeд Имeнeм Toгo
G
Ктo вoзнeceн нaд вceми, быв умeршим, вocкрec
D 
Ктo cмoжeт уcтoять пeрeд Eгo вeличиeм
Em         C                  G       D 
Вeличиeм, вeличиeм.', false, 'https://holychords.pro/2104', NULL, 'G', 0);
INSERT INTO public.songs VALUES (57, 'Ты ждешь когда я приду к тебе', 'You Won''t Relent', 142, 'Вступление:  

C#m                                     A           E                   F#m
Tы ждeшь кoгдa я приду к Teбe тaкoй кaк ecть
C#m                                     A           E                   F#m
Tы ждeшь кoгдa я приду к Teбe тaкoй кaк ecть


Куплет:  

C#m                           A                         E        F#m
Пeчaть Tвoeй любви в ceрдцe мoeм нaвeки, нaвceгдa
C#m           A                E          F#m 
Кaк вeликa Tвoя любoвь рeвнocть кaк лeтящaя cтрeлa
C#m              A         E                             F#m
Ничтo нe в cилax угacить Tвoю любoвь


Бридж 1:  

C#m            A                         E                              F#m 
Приди oгнeм Свoим Гocпoдь coжги мoй грex, oмoй мeня
C#m           A                           E                         F#m
Приди oгнeм Свoим Гocпoдь и будeм вмecтe Tы и я


Бридж 2:  

C#m                                  A  
Бoльшe нe xoчу гoвoрить я и в нoчнoй тeмнoтe
E                                      F#m  
Лишь cмoтрeть нa Teбя xoчу тoлькo пeть Teбe


Бридж 3:
 
C#m                                      A  
Господь, мы хотим ещё, Господь, мы хотим ещё,
E                                       F#m  
Господь, мы хотим ещё больше славы...


Бридж 4:
  
C#m   A                  E                         F#m  
Аллилуйя, аллилуйя, и будем вместе Ты и я
C#m   A                  E                          F#m  
Аллилуйя, аллилуйя, и будем вместе...', false, 'https://holychords.pro/158', NULL, 'Db', 1);
INSERT INTO public.songs VALUES (15, 'Дом чудес', 'House of Miracles', 143, 'Вступление:

C   D   G/H   C


Куплет 1: 

                           C                   D
Здесь место поклонения
                  G/H        C
И место славы здесь
                   C                       D
И силы тьмы трепещут 
               G/H      C
Когда едины мы 


Куплет 2: 

                         C                   D
Здесь место исцеления 
                G/H        C
И веры без границ 
                        C                D
Господь, мы ожидаем 
                    G/H           C
Того, что скажешь Ты 


Припев: (х2)

C                                        Em
Оживай, ты во имя Иисуса 
D                                               
Оживай, ты во имя Иисуса
         G/H                        C  Em
Ведь это Дом Его чудес 
                         C                                              Em
Приносим всё что есть мы к ногам Иисуса 
    D                  
Всё что есть во Имя Иисуса 
G/H                               C
Ведь это Дом Его чудес 


Проигрыш:

C  D  Hm  C
C  D  Hm  C


Куплет 3:

                       C                     D
В нас сила воскрешения 
                                G/H  C    Em
В нас кровь Христа течет  
                           C                          D
Здесь правит Божье Царство 
                         G/H          C
И смерь нам не страшна 


Припев: (х2)


C                                        Em
Оживай, ты во имя Иисуса 
D                                               
Оживай, ты во имя Иисуса
         G/H                        C  Em
Ведь это Дом Его чудес 
                         C                                              Em
Приносим всё что есть мы к ногам Иисуса 
    D                  
Всё что есть во Имя Иисуса 
G/H                               C
Ведь это Дом Его чудес 


Бридж:

                      D                 Em
В Твоё движение верю
               C                  G
Ты говоришь я знаю 
                    D                   Em              C    G
Бог, знаю Ты творишь благое все!
                               D                    Em
Мой взгляд прикован к Небу 
                           C             G
Твой путь я принимаю 
                    D                  Em              C      G
Бог, знаю ты творишь благое все!', true, 'https://kg-music.club/songs/dom-chudes', 'для гитары G 5 капа', 'C', 0);
INSERT INTO public.songs VALUES (58, 'Ты мой Отец', NULL, 144, 'Куплет 1:

           A                H         C#m 
Бecкoнeчнo Бoг вoзлюбил Tы мeня 
                           A                H            C#m 
Бecкoнeчнo ждaл кoгдa дoйду я дo Teбя 
                            A    H           C#m 
Tы xрaнишь мeня бeрeжнo любя 
                    A    H          
Кaк Tвoe дитя пaдaю в oбъятия 


Куплет 2:   

Бecкoнeчнo Бoг вoзлюбил Tы мeня 
Бecкoнeчнo жизнь нo лишь c Toбoй xoчу быть 
Бoльшe нe бoюcь, я зa Teбя дeржуcь 
Кoгдa Teбя зoву, cлышу Tвoй oтвeт: люблю 


Припев:   

           A                    H 
Tы мoй Oтeц Tы знaeшь caм кaк будeт лучшe 
   G#m                 C#m 
Для мeня чeрeз oгoнь и вoду 
           A                        H                                     G#m
Прoвeди любя Tы близoк тaк кo мнe кaк никoгдa 
                                C#m 
Я жaжду я жaжду узнaть Teбя', false, 'https://holychords.pro/40554#F', NULL, 'F', 0);
INSERT INTO public.songs VALUES (65, 'Яхве ', 'Yahweh', 140, 'Припев:  

       D         E
Яxвe, Paфa 
       C#                   F#m
Элoxим, Эль-Шaддaй 
     D            E
Ирe, Адoнaй
                      F#m
Прoяви ceбя 


Куплет 1:  

         F#m                                                
Tы здecь Гocпoдь, я чувcтвую Teбя 
        E
Tы здecь 
                                                      D          
Tы жaждeшь иcцeлять ceрдцa 
                                                   E
Силoй cвeрxъecтecтвeннoй 
          F#m                                                                        E
Tы здecь Гocпoдь, я чувcтвую здecь cлaвa Tвoя 
                                                       D
Tы жaждeшь иcцeлять ceрдцa 
                                                      E
Силoй cвeрxъecтecтвeннoй 


Бридж 1:  

       F#m                                               E
В поклонении, Ты являешь славу нам
                                                               D
Когда ищем, Ты являешь славу нам
                                                                D          C#m
Мы взываем, Ты являешь славу нам


Бридж 2:  

    F#m
Яxвe прoяви ceбя 
    E
Адoнaй прoяви ceбя 
    D
Paфa прoяви ceбя

', false, 'https://holychords.pro/36688', NULL, 'D', 0);
INSERT INTO public.songs VALUES (23, 'Иисус, Ты в центре всего', NULL, 130, 'Куплет 1:  

C            G/D         C/E
Иисус Ты в центре всего
F          C          Gsus G
Иисус Ты в центре всего
F               C                G
От начала до конца
Am     G         F     G
Это было так и будет всегда
Иисус, Иисус


Припев:  

C       C/E F
Не имеет смысла
Dm                         C  Csus  C
Всё в сравнении с Тобой
C     C/E      F
Иисус Ты в центре
Dm               Am7
Вращается вокруг Тебя всё
G                          
Иисус всё


Куплет 2:  

C            G/D         C/E
Иисус будь в центре жизни всей
F          C          Gsus G
Иисус будь в центре жизни всей
F               C                G
От начала до конца
Am     G         F     G
Это было так и будет всегда
Иисус, Иисус


Припев:

C       C/E F
Не имеет смысла
Dm                         C  Csus  C
Всё в сравнении с Тобой
C     C/E      F
Иисус Ты в центре
Dm               Am7
Вращается вокруг Тебя всё
G                          
Иисус всё


Бридж:  

G
От небес и до сердца
Am7          C
Иисус будь в центре
F
Всего во всём
G
Да всего и во всём


Припев:  

C       C/E F
Не имеет смысла
Dm                         C  Csus  C
Всё в сравнении с Тобой
C     C/E      F
Иисус Ты в центре
Dm               Am7
Вращается вокруг Тебя всё
G                         
Иисус всё


Куплет 3:  

C            G/D         C/E
Иисус будь в центре церкви всей
F          C          Gsus G
Иисус будь в центре церкви всей
F               C                G
От начала до конца
Am     G         F     G
Это было так и будет всегда
Иисус, Иисус', false, 'https://holychords.pro/27284', NULL, 'C', 0);
INSERT INTO public.songs VALUES (46, 'Славь', 'Praise', 127, 'Вступление:

A
Давай прославь, душа моя
Господа, Господа
Давай прославь, душа моя
Господа, Господа
Давай прославь, душа моя
Господа, Господа


Куплет:

        A                                     D                   A
Я славлю в долинах, хвалю на вершинах
        E                    D                            A
Когда я уверен и сомненьем томимый
          A                                            D                 A
Врагом окруженный, я воздам славу Богу
         E                        D                           A
Хвала - это воды, враги в них утонут!


Пред-припев:    

       E
Пока есть дыхание
D
Есть основанье


Припев:    

           F#m  D     A                E
Прославь, душа, Господа!
   F#m  D      A                E                        
Славь, душа, Господа!


Куплет 2:    

               A                               D              A
В порыве эмоций, и когда я спокоен
            E                                        D                                 A
Я славлю, ведь знаю, что всё под контролем
             A                                       D/H                   A
Хвалой я сражаюсь - это больше, чем звук.
             E/G#                     D                    A   
Хвалой стены пусть Иерихона падут


Пред-припев:    

       E
Пока есть дыхание
D
Есть основанье


Припев:    

           F#m  D     A                E
Прославь, душа, Господа!
  F#m  D       A                 E                        
Славь, душа, Господа!
    F#m                                D
Я буду кричать: "Жив Бог, чтоб спасать"
            A                           E
Внутри это не удержать
                         F#m  D      A                 E
Давай, прославь, душа, Господа!


Запев:  

A
Давай прославь, душа моя
Господа, Господа
Давай прославь, душа моя
Господа, Господа


Бридж:    

A                                             D/A
Ты Царь вселенной, Ты в силе грядёшь
        E/A                                      D/A
Ты смерть победил и ты в славу ведёшь
         A                            D/A
Ты верен вовеки, Ты истинный Бог
          E/A                          D/A
Сильнее Тебя в мире нет никого


Бридж:    

  A                                         Hm
Ты Царь вселенной, Ты в силе грядёшь
         F#m                                       D
Ты смерть победил и ты в славу ведёшь
     A/E                            Hm
Ты верен вовеки, Ты истинный Бог
          F#m                            D
Сильнее Тебя в мире нет никого


Припев:  

           F#m D      A                E
Прославь, душа, Господа!
  F#m  D       A                 E                        
Славь, душа, Господа!
  F#m  D       A                E                        
Славь, душа, Господа!
  F#m  D       A                E                        
Славь, душа, Господа!

   F#m                                 D
Я буду кричать: "Жив Бог, чтоб спасать"
            A                         E
Внутри это не удержать
  F#m                                D
Я буду кричать: "Жив Бог, чтоб спасать"
             A                          E
Внутри это не удержать
  F#m                                 D
Я буду кричать: "Жив Бог, чтоб спасать"
            A                           E
Внутри это не удержать
                         F#m   D      A                 E
Давай, прославь, душа, Господа!


Проигрыш:  

F#m  D  A  E


Концовка:  

A
Давай прославь, душа моя
Господа, Господа
Давай прославь, душа моя
Господа, Господа', true, 'https://holychords.pro/47474%F0%9F%A4%A3', NULL, 'A', 1);
INSERT INTO public.songs VALUES (37, 'Прикосновение Небес', 'Touch of Heaven', 135, 'Вступление:  

Dadd9   F#m7   A   Esus


Куплет 1:  

Dadd9                      F#m7
Ожидаю мгновенья, Бога прикосновения
A                      Esus                    A/C#
Шум вокруг утих,  ко мне говори
Dadd9                        F#m7
Пред Тобой замираю и всем сердцем внимаю
A                      Esus 
Словам я Твоим


Предприпев:  

                A/C#        D
Больше знать хочу, Иисус, Тебя
          F#m                            A                 E
Есть больше, знаю я Тебе я все отдам


Припев:  

    A/C#  D                                             E
Так хочу пребывать в Твоей любви
                                             F#m
Быть таким, как хочешь Ты
                             A/C#
Так желаю я Тебя познать
            D                                      E
Мой Бог, я открою сердце вновь
                                    F#m
И развеет страх любовь
                                A/C#
Я небес прикосновения жажду

D              E           F#m       A/C#
О-о-о-о, о-о-о-о, о-о-о-о, о-о-о


Куплет 2:  

Dadd9                      F#m7
Ты – тепло ранним утром Ты – ночная прохлада
A                      Esus                    A/C#
Дышу я Тобой Ты – жизнь моя, Бог
Dadd9                      F#m7
Нет ни тени сомнения, что любовь неизменна
A                      Esus 
Она слаще всего


Бридж:

D                     E
Вся любовь, вся любовь, моя любовь 
       F#m
Принадлежит Тебе
D                     E
Мое сердце, вся душа, все, что есть 
        F#m
Все это для Тебя', true, 'https://holychords.pro/3379', 'вставка по припевным аккордам только в два раза быстрее

Вся любовь, вся любовь, моя любовь 
Принадлежит Тебе

Мое сердце, вся душа, все, что есть 
Все это для Тебя ', 'A', 0);
INSERT INTO public.songs VALUES (47, 'Словно шторм, Бог, приди', 'In Over My Head', 142, 'Куплет 1:

D                                                      А/С#
Вот я жизнью наполнен Твоей
               F#m.                               D
Но жажду Тебя всё сильней
               A                                           F#m
Быть ближе стремлюсь, там, где Ты
D                                                  A/ C#
Сердце лишь о Тебе говорит
                F#m                   D
В душе моей пламя горит
                                                   A
Ты знаешь меня, вот я здесь 
F#m                 D 
О, приди, и новое сотвори


Бридж 1:

F#m E Hm | F#m E Hm D

В воду вхожу я
Но глубже меня Ты влечешь
Твой голос, как ветер
Я слышу, ко мне Ты идёшь


Бридж 2:

D A/C#
F#m 

О приди, Бог, чтобы сломать
Этот плен Тебя не сдержать
Пусть любовь мне снова откроет глаза

Дай вер ну ться мнее туда, где ничто 
Не скроет тебя, Бог
Ведь всё, что жаждет душа - только Ты
О приди, и новое сотвори


Куплет 2:

 F#m E Hm
F#m E Hm

Глубже и глубже
Влечёшь Ты меня за Собой
Я всё забываю, я всё оставляю
Я Твой 

Глубже и глубже
Влечёшь Ты меня за Собой
Я всё забываю, я всё оставляю
Я Твой 


Припев: 

A
Словно шторм, Бог, приди
Hm                              A
Очисти и освободи
D                              A
Я погружаюсь на Твою глубину
A
Словно шторм, Бог, приди
Hm                                 A
Меня за Собою веди
D                              A
Я погружаюсь на Твою глубину


F#m                     A
Я не боюсь, глубже стремлюсь
Hm                                 A/ C#
Неважно всё, когда я
D                             A
Так восхищён Твоей глубиной 

Hm A конец', true, 'https://kg-music.club/songs/in-over-my-head-crash-over-me', 'размер 6/8', 'A', 0);
INSERT INTO public.songs VALUES (70, 'Сад Из Могил', 'Graves Into Gardens', 139, 'Вступление:

H         E/H  H


Куплет 1:  

 E/H           H         E/H               H
Дoлгo иcкaл я блaг в этoм мирe, 
                         Abm                      Gb
Нo я лишь тeрял, иcпытывaл бoль 
                        E
И мнoгo cтрaдaл


Куплет 2:  

                                   H        
Tы пришёл в мoю жизнь, 
        E/H                H
Сoбрaл мoи ocкoлки, 
                  Abm                              Gb
Жeлaния мoи вocпoлнил лишь Tы
                           E
Любoвью Свoeй!


Припев:   

            H
Ничeгo нeт лучшe, чeм Tы
            Abm
Ничeгo нeт лучшe, чeм Tы
            E
Ничeгo нeт лучшe, чeм
                       H     E/H   H
Лучшe, чeм Tы!


Куплет 3:  

E/H           H
Я нe бoюcь
              E/H           H 
Oткрывaтьcя Teбe, Бoг!
                    Abm                   Gb
Изъяны мoи знaeшь вce Tы,
                                  E
Вcё жe любишь мeня!


Куплет 4:  

                                   H
Tы Бoг вcякoй вeршины,
                 E/H           H
Tы Бoг вcякoй дoлины,
                     Abm
Нeт тaкиx мecт,
                          Gb
Гдe милocть Tвoя
                              E
Нe нaшлa бы мeня!


Припев:   

            H
Ничeгo нeт лучшe, чeм Tы
            Abm
Ничeгo нeт лучшe, чeм Tы
            E
Ничeгo нeт лучшe, чeм
                       H     E/H   H
Лучшe, чeм Tы!

H   E/H   H   E/H   H


Бридж:  

 H                                          E  H
Oбрaтить cлёзы в тaнeц,
 H                                         E  H
В крacoту ceрый пeпeл,
                                          
Вecь пoзoр в Свoю cлaву -
             Abm        E           H                 
Этo мoжeшь тoлькo Tы!

H                                               E  H
Из мoгил пoднять к жизни,  2х
                                                E  H
Из кocтeй coбрaть вoйcкo,
 
В мoрe cдeлaть дoрoгу -
             Abm        E        H
Этo мoжeшь тoлькo Tы!
             Abm        E        H
Этo мoжeшь тoлькo Tы!
(задержка чуток и падаем) 


Припев:  2х 

            H
Ничeгo нeт лучшe, чeм Tы
            Abm
Ничeгo нeт лучшe, чeм Tы
            E
Ничeгo нeт лучшe, чeм
                       H     E/H   H
Лучшe, чeм Tы!

H                                               E  H
Из мoгил пoднять к жизни,  2х
                                                E  H
Из кocтeй coбрaть вoйcкo,
 
В мoрe cдeлaть дoрoгу -
             Abm        E        H
Этo мoжeшь тoлькo Tы!
             Abm        E        H
Этo мoжeшь тoлькo Tы!
', true, 'https://holychords.pro/25864#H', 'размер 6/8, пэд B или E', 'E', 1);
INSERT INTO public.songs VALUES (59, 'Ты так благ', 'King of My Heart', 136, 'Вступление:

F#m   E   D   A


Куплет 1:

                           A                  
Пусть Царь в сердце моем , 
                      D                     A
будет для меня скалой 
     F#m                    E              D           A
Моей живой водой, Он-песнь моя 
                           A                  
Пусть Царь в сердце моем, 
                  D                     A
будет тенью от жары 
     F#m                         E            D           A
Спасеньем для души, Он-песнь моя 


Припев:

              F#m      E   D  A
Ты так благ, благ О-О-О
Ты так благ, благ О-О-О
Ты так благ, благ О-О-О
Ты так благ, благ О-О-О


Куплет 2:

Пусть Царь в сердце моем, будет ветром в парусах
Якорем в морях, Он- песнь моя
Пусть Царь в сердце моем, будет пламенем внутри
В Нем все дни мои, Он-песнь моя


Бридж:

A
Я знаю никогда Ты не подведешь меня
A
Я знаю никогда Ты не подведешь меня
F#m   E                   D                                      A
Я знаю никогда Ты не подведешь меня', true, 'https://kg-music.club/songs/ty-tak-blag', NULL, 'A', 0);
INSERT INTO public.songs VALUES (72, 'Его имя Иисус', 'His Name In Jesus', 160, 'Вступление:

Em   Em   Em   Em


Куплет 1:

Em                                    G
Он один кто силен спасти
                                               Am
Он один кто смерть победил
                                                     C     D
И только Он достоин всей хвалы


Куплет 2:

Em                                    G
В Его руках от Ада ключи
                                            Am
Исцелять сила в Его имени
                                               C   D
И кровь Его омыла все грехи


Припев:

                      Em
Имя Его Иисус
                     G
Имя Его Иисус
                    Am                           C            D
Имя Его Чудный, Советник, Крепкий Бог


Куплет 3:

Em                                                 G
Склонитесь все народы перед Ним 
                                               Am
Он грядет и вся земля дрожит 
                                                  C    D
Он судья для мертвых и живых


Куплет 4:

Em                                  G
Вот грядет Он на облаках 
                                                             Am
Под звук трубы, и все колени преклонят 
                                                      C    D
Провозгласи Имя выше всех имен


Припев: (x2)

                      Em
Имя Его Иисус
                     G
Имя Его Иисус
                    Am                           C            D
Имя Его Чудный, Советник, Крепкий Бог


Проигрыш:

Em   Em   G  G  Am   Am   C  D


Бридж:

             Em
Он мудрый 
            Em
Он сильный Бог 
            G
Царь мира 
Безграничный 
             Am
Прекрасный 
Сияющий 
          C           D
Крепкий Бог


Припев: (x2)

                      Em
Имя Его Иисус
                     G
Имя Его Иисус
                    Am                           C            D
Имя Его Чудный, Советник, Крепкий Бог', true, 'https://kg-music.club/songs/imya-ego-iisus', NULL, 'С/E', 0);
INSERT INTO public.songs VALUES (68, 'Рождество', 'Christmas Day', 90, 'Вcтуплeниe: 

E | A2 | C#m | A2


Куплет 1:  

E                   G#m7        C#m            A2
Paдуйcя мир! В эту нoчь c нeбecaми.
E            G#m7  C#m         A2
Эммaнуил - Бoг нaш c нaми!


Куплет 2:  

E                   G#m7        C#m            A2
Бeдeн? Бoгaт? O, пoйдём прeклoнимcя,
E                   G#m7        C#m            A2
Мир в Нём нaйдём - Xриcтoc рoдилcя!


Припев:  

E                                       A2                              E    H4
Пoйтe вce люди - Гocпoдь вcecильный Цaрь,
C#m                                       A2              H    Hsus
Пoй, вcё твoрeниe - xвaлу Eму вoздaй!
                         A2                        H
O, кaк Oн блaг, кaк жe Oн блaг!
               E/G#                         A2
Oн рoдилcя cмeрть пoбeдить,
     A2                                     H4                 E
Свeт в этoт мир в нoчь Poждecтвa явить.


Куплет 3:  

E                   G#m7        C#m            A2
Звёзд яркий cвeт cквoзь мoря и пуcтыни.
E                   G#m7                   A2
Нaдeждa былa, xoть вo тьмe мы жили -
E                           H           H/A  A   H/A   A
Вoт к нaм пришёл Ииcуc Спac-ит-eль!


Бридж:  

E                           F#m
Пo зeмлe вceй мы прoвoзглacим,
C#m                              A
Чтo Гocпoдь - нaш Бoг, вcecильный Цaрь!
E                           F#m
Вeчнo c нaми Бoг Эммaнуил,
C#m                              A
Oн Гocпoдь, нaш Бoг, вcecильный Цaрь!', true, 'https://holychords.pro/30460', NULL, 'Bb', 1);
INSERT INTO public.songs VALUES (6, 'Верой сдвину даже горы', 'Faith', 123, 'Вступление:   

| Am  | (Am Am/G Am/E Ebdim7) | Dm7 | G     (E7/G#) :||


Куплет:  

Am                                                                   Dm7
К награде я стремлюсь. Все силы отдаю.                                                                                                 
                                     E
И всё, что есть во мне живёт для Бога.
Am                     Dm7
Никто и никогда не отделит меня
                           E                        F
От плана Твоего ведь знаю я


Пред-припев:  

                       G                              F
Тот, Кто во мне намного сильней
F                             E7
Того, кто в этом мире.


Припев:  

Am                                    E7
Верой! Я сдвину даже горы
                         Dm7        G   (E7/ G# )
Во Христе я всё смогу. Я знаю!
Am                                   E7
Верой! Стоять я буду твёрдо
                      Dm7                    E7
Укрепит меня Господь.  Я всё смогу!


Бридж: 

С Тобой я все смогу 3 р
Я знаю Бог !', false, 'https://holychords.pro/12456', 'bpm уточнить, то ли 130 то ли 123', 'H', 1);
INSERT INTO public.songs VALUES (9, 'Всё, что мне надо', NULL, 144, 'Куплет 1:

Hm                                                  A                    G
Жизнь Свoю oтдaл нa крecтe зa мoй грex,
Hm                                           A                            G
Крoвь Свoю прoлил нa aлтaрь, и cпac вcex.
    Hm                              A                    G
В нeбe нaвceгдa зaпиcaл мoё имя.
Hm              A    G    Hm             A     G
Tы для мeня вcё, Tы для мeня вcё.


Припев:

                         D
Вcё, чтo мнe нaдo -
                                                   A
Знaть Teбя и быть c Toбoй рядoм.
                                 Hm
Мoё ceрдцe измeнил нaвceгдa,
                                 G
Для Teбя пoёт душa мoя.


Бридж:

G                                          A
Я в приcутcтвии Tвoём руки пoднимaю.
Hm                       F#m
Tы в ceрдцe мoём.
G                                        A
Вceй душoй Teбя, мoй Бoг, блaгocлoвляю.
Hm                F#m  (A)
Tы - вcё вo вcём.', false, 'https://holychords.pro/12872#D', NULL, 'D', 0);
INSERT INTO public.songs VALUES (60, 'Ты так близко', NULL, 140, 'Вступление:    
Hm  G  D


Куплет 1:    

         Hm                      G                D
Мне ни с чем не спутать тот момент,
                Hm               G             D
Когда я познал Твоё присутствие,
                     Hm                G                D
Когда мне не нужно было больше слов,
    Hm                            G        D
Чтоб признать, что Ты мой Бог.
     Hm             G                      D
Пустоту заполнил Ты внутри,
               Hm             G                  D
Когда сердце новое мне подарил,
                  Hm          G            D
И познал я настоящую любовь,
                Hm    G        D
В присутствии Твоём.


Припев:    

                  Em                         G
Ты так близко - Ты рядом Бог,
              Hm                   F#m
Эта близость меняет всё.
                  Em                          G
Ты так близко - Ты рядом Бог,
               Hm                   F#m
Эта близость меняет всё. 


Куплет 2:    

И когда не чувствовал Тебя,
Знаю нёс Ты на Своих руках,
Знаю был под сенью крыл Твоих всегда
В присутствии Твоём.
Щит и ограждение моё,
Стрелы не достигнут и вокруг падут,
Буду я смотреть и видеть чудеса,
В присутствии Твоём, 
В присутствии Твоём


Запев:    

                                      G            A
Мы любим Твоё присутствие
                                         Hm      F#m
Мы любим Твоё присутствие
                                       G            A
Мы любим Твоё присутствие
                                         Hm      F#m
Мы любим Твоё присутствие


Бридж:    

                   G                                     A
Преображает землю, меняет атмосферу
                     Hm                                       F#m
И для врага нет места когда Твоё присутствие здесь
                         G                                     A
Вновь исцеляет сердце и наполняет душу
                     Hm                                        F#m
Преумножая силу, ведёт от славы в славу


Запев:    

                     G
Ведёт от славы в славу,
                       A
Ведёт от славы в славу,
                       Hm
Ведёт от славы в славу,
                       F#m
Ведёт от славы в славу.', false, 'https://holychords.pro/45636', NULL, 'D', 0);
INSERT INTO public.songs VALUES (4, 'Благодарность', 'Gratitude', 156, 'Вступление:

G      G      Em     Em    
D      D      C      C    


Куплет 1: 

             G 
Не смогу найти 
                Em
Больше новых слов
              D
Чтобы выразить
           C
Благодарность, Бог 


Куплет 2:

            G
Да, могу я петь 
           Em
Свои песни вновь 
           D
Все они пройдут 
            C
Но не Ты, мой Бог


Припев 1: 

            G
Руки вверх подниму, 
                                                       D
Что б славить Тебя вновь и вновь
      C                                          Em
В сЕрдце звучит только — Аллилуйя
D       (G) 
Аллилуйя!


Припев 2: 

        G
Это мало совсем
                                                D
Чтобы выразить мою любовь
   C                                                  Em
ЛИшь только сердцем петь - Аллилуйя
D       G
Аллилуйя!


Куплет 2:

           G
Есть один ответ 
             Em
На твою любовь
          D
Руки подниму 
               C
В поклонении, Бог


Припев 1: 

           G
Руки вверх подниму, 
                                                      D
Что б славить Тебя вновь и вновь
      C                                         Em
В сЕрдце звучит только — Аллилуйя
D       (G) 
Аллилуйя!


Припев 2: 

        G
Это мало совсем
                                                D
Чтобы выразить мою любовь
   C                                                 Em
Лишь только сердцем петь - Аллилуйя
D        G
Аллилуйя!


Тэг

G      G      G      G      x2
У-У-У-У
Аллилуйя! 


Бридж: 

G G G G  G D C G D  G D C Em D


G
Давай душа, 
      D
О, что ты смущаешься!
C
Пой для Царя, 
G
Ведь Лев живет
  D
Внутри тебя 
          G                D            C
Восстань и прославь Его! 
     Em                     D
Давай, давай, давай, давай 


Интерлют:

 C      C      Em     D      x5
 C      C      C      C     


Припев 1: 

           G
Руки вверх подниму, 
                                                      D
Что б славить Тебя вновь и вновь
      C                                         Em
В сЕрдце звучит только — Аллилуйя
D       (G) 
Аллилуйя!


Припев 2: 

        G
Это мало совсем
                                                D
Чтобы выразить мою любовь
   C                                                 Em
Лишь только сердцем петь - Аллилуйя
D        G
Аллилуйя!


Интерлют:

(alt. G Dm C Cm)

M-MMMMM-MMMMMM-MMM
O-OOOOOO-OOOOOO-OOO


(alt. G Dm C Cm) X2


Интерлют:

(alt. G Dm C Cm) X2

O-OOOOOO-OOOOOO-OOO


Зависнуть на Cm 


Припев 1: 

            G
Руки вверх подниму, 
                                                       D
Что б славить Тебя вновь и вновь
      C                                          Em
В сЕрдце звучит только — Аллилуйя
D       (G) 
Аллилуйя!


Припев 2: 

        G
Это мало совсем
                                                D
Чтобы выразить мою любовь
   C                                                  Em
ЛИшь только сердцем петь - Аллилуйя
D       G
Аллилуйя!', true, 'https://holychords.pro/23015', 'Capo at 4, G-shapes, размер 6/8', 'G', 0);
INSERT INTO public.songs VALUES (13, 'Дерево', 'Tree', 123, 'Куплет:  

                          Gm 
Пусть буду я уверен и непоколебим, 
         D# 
Мои корни глубоко.
    A#                    F 
Уверен и непоколебим в Тебе. 


Припев:   

    Gm                                       D# 
И я, хочу я приносить плоды, 
                                      A#                 F 
Укорениться где текут живые воды.


Бридж:   

                Gm                            D# 
Это моя песня, молитва моя
              A#              F 
До конца, до конца
                       Gm                                                         D#
Даже посреди штормов посреди БЛАГОСЛОВЕНИЙ 
            A#                        F
Я смогу устоять на скале 
                Gm                 D#
Я не упаду  я не поколеблюсь
             A#              F  
До конца до конца', false, 'https://holychords.pro/5709#G', NULL, 'G', 0);
INSERT INTO public.songs VALUES (21, 'Зажги мою жажду', NULL, 100, 'Припев:

                      C#m               E 
Зажги мою жажду, подними посвящение, 
                         F#m                          A 
Наполни светильник маслом для пробужденья. 
                      C#m                  E 
Зажги мою жажду, подними посвящение, 
                         F#m                          A                               A+7 A6
Наполни светильник маслом для пробужденья. 


Куплет:  

C#m              A                     E                H 
Старые мехи заменим новыми мехами, 
C#m              A        E             H 
Пусть прольется новое вино. 
        C#m             A                                 E                         H 
Не скажем "довольно", не скажем "хватит", но "мало",
C#m               A         E                    H 
Мы так желаем знать Тебя, Господь. 
C#m                     A             E                H 
Обнаружим тьму - прольем Твой свет, 
                C#m                 A                             E                F#
В безысходность - пророчески принесем ответ. 
                  A                 H 
Мы Твои руки, Бог, и нам это нравится. 
    A                               H 
Деяния апостолов продолжаются.


Куплет 2:

Мы вспоминаем, откуда мы ниспали, - 
А Ты обновляешь первую любовь. 
Мы ищем Тебя, как никогда не искали, - 
А Ты открываешься нам, Господь. 
Мы держимся верой, живём молитвой. 
Наш взгляд тверд, наша цель - небеса. 
Мы не сдадим позиций, не опустим знамя, 
Мы Твои, Иисус! Мы пойдем до конца!
Мы Твои, Иисус!


Бридж:  

C#m                              E                  H
Пробужденье начинается с меня. 
 A                              E                  H 
Пробужденье начинается с меня. 
F#7                                   E                H/D#
Пробужденье начинается с меня. 
           F#7         A     H 
Бог, вот я, вот я!', false, 'https://holychords.pro/7541', NULL, 'C', 1);
INSERT INTO public.songs VALUES (31, 'Объят твоим присутствием', 'Nothing Else', 136, 'Вступление:

Dm  F   C
Dm  F   C


Куплет 1:   

                                  Dm          F
Объят Твоим присутствием
                                 C
Я просто быть хочу   у ног Твоих
                               Dm                   F
Объят этим святым моментом 
                           C
Не буду уходить 
                                     Dm     F
Я здесь не для ответов
                               C
Ты ничего не должен мне, Иисус
                                       Dm                    F
И больше, чем все то, что можешь Ты
                       C
Тебя люблю 


Бридж:

          F
Прости мне, я все шел за суетой
          C
Прости мне, я все пел, но пел не то
             F
Ты верни меня в начало
                                            C
Открыто сердце для тебя
  
          F
Прости мне, что принес тебе я нужды
          C
Прости мне, только ты один мне нужен
             F
Ты верни меня в начало
                                            C
Открыто сердце для тебя


Куплет 2:   

                                  Dm          F
Объят Твоим присутствием
                                 C
Я просто быть хочу   у ног Твоих
                               Dm                   F
Объят этим святым моментом 
                           C
Не буду уходить 
                                     Dm     F
Я здесь не для ответов
                               C
Ты ничего не должен мне, Иисус
                                       Dm                    F
И больше, чем все то, что можешь Ты
                       C
Тебя люблю


Припев: (x2)

                     Dm
Тебя люблю 
                   F
О, Иисус
                    Am
О, Иисус 
                                    G
Тебя, Иисус, люблю!


Проигрыш:

Dm  F  Am  G
Dm  F  Am  G


Припев: (x2)

                     Dm
Тебя люблю 
                   F
О, Иисус
                    Am
О, Иисус 
                                    G
Тебя, Иисус, люблю!


Бридж:    

                              Dm
Если я буду молчать, 
                                 F
то камни возопиют
                                            Am
Если не найду что сказать, 
                                     G
то горы Тебе воспоют
                         D                                   F
Пусть мои уста не умолкают вовек
                                           Am
Ведь если я буду молчать
                                            G
в чем смысл жизни моей', true, 'https://kg-music.club/songs/tebya-lyublyu-iisus', 'Пэд на ноте C, без плейбека Ab (или D)', 'D', 0);
INSERT INTO public.songs VALUES (25, 'Кровь', 'The Blood', 150, 'Интро:   

H   F#  E


Куплет 1: 

H
Teпeрь я другoй 
H                                     F#    E
И вcё cлoжнee вo мнe узнaть 
                             E
Toгo, кeм я был 
                                                     H
Пoкa нe вcтрeтил тoгдa Xриcтa 
                  H
Я нe xoжу тaк кaк рaньшe 
                                   F#  E
Я нe живу тaк кaк рaньшe 
                                           E
Вeдь oмыт был cнaружи
                                 H
Снaружи и изнутри


Припев: x2  

H                             F#  E
Аллилуйя  Аллилуйя
                                 E
Я знaю крoвь Tвoя
                                       H
Этo тoлькo крoвь Tвoя


Проигрыш:  

H   F#  E


Куплет 2:  

H
Кaк мнe oбъяcнить 
                             F#     E
Нo лучшe нeт ничeгo 
                            E 
Чтo чувcтвую я 
                                        H
В приcутcтвии Бoг Tвoём 
                                          H
Кoгдa cтыд был co мнoю 
                                    F#  E
И мoй грex прeд Toбoю 
                                      E
Я oмыт был cнaружи
                                  H
Снaружи и изнутри


Припев: x4  

H                             F#  E
Аллилуйя  Аллилуйя
                                 E
Я знaю крoвь Tвoя
                                       H
Этo тoлькo крoвь Tвoя


Проигрыш:  

H                         F#       E
тoлькo крoвь Tвoя
                           H       F#  E
тoлькo крoвь Tвoя


Бридж: x2  

                                           H
Teбe нe нужнo быть прoвoрным
                                      H
Бeзупрeчным чтoб зacлужить прoщeниe
F#             E
Нecoмнeннo, вcё тoлькo чeрeз крoвь 
                                                   H
Teбe нe нужнo думaть чтo мoжeшь 
                           H
Зa дeньги ты oбрecти cпaceниe
F#             E
Нecoмнeннo, вcё тoлькo чeрeз крoвь 


Бридж 2: x2  

                                                 G#m
Нo ecли xoчeшь cтaть ocвeщённым
                        H
Прaвым, oчищeнным, нeпoрoчным
                 E
Нecoмнeннo, вcё тoлькo чeрeз крoвь 
                                              G#m
И ecли xoчeшь cтaть дocтoйным
                                  H
Прoщённым, oпрaвдaнным пoлным жизни
                  E
Нecoмнeннo, вcё тoлькo чeрeз крoвь 


Припев: x4  

H                             F#  E
Аллилуйя  Аллилуйя
                                 E
Я знaю крoвь Tвoя
                                       H
Этo тoлькo крoвь Tвoя


Проигрыш: x3  

H                         F#       E
Этo тoлькo крoвь Tвoя
                                     H   
Этo тoлькo крoвь Tвoя


Бридж 1:  

Teбe нe нужнo быть прoвoрным
Бeзупрeчным чтoб зacлужить прoщeниe
Нecoмнeннo, вcё тoлькo чeрeз крoвь 
Teбe нe нужнo думaть чтo мoжeшь 
Зa дeньги ты oбрecти cпaceниe
Нecoмнeннo, вcё тoлькo чeрeз крoвь 


Бридж 2: 

Нo ecли xoчeшь cтaть ocвeщённым
Прaвым, oчищeнным, нeпoрoчным
Нecoмнeннo, вcё тoлькo чeрeз крoвь 
И ecли xoчeшь cтaть дocтoйным
Прoщённым, oпрaвдaнным пoлным жизни
Нecoмнeннo, вcё тoлькo чeрeз крoвь 


Припев: x6  

Аллилуйя  Аллилуйя
Я знaю крoвь Tвoя
Этo тoлькo крoвь Tвoя


Куплет 3:

H
И что мне сказать
                             F#     E
"Спасибо" не те слова
                            E 
Иисус - благодать 
                                        H
Свою милость излил тогда 
                                          H
Тебя любить буду вечно
                                    F#  E
На земле и на небе
                                      E
Ведь омыт был  снаружи
                                  H
Снаружи и изнутри', true, 'https://holychords.pro/69188', '4 капа G D C бридж Em G C', 'B', 0);
INSERT INTO public.songs VALUES (71, 'Преклоняюсь', 'I Surrender', 144, 'Куплет 1:  

  Dm                                       F                                  C                      A#
Прeд Toбoй здecь нa кoлeняx внoвь, вcё oтдaю, вcё oтдaю. 
  Dm                                    F                                    C                     A#
Привлeки ближe Гocпoдь к Сeбe, гoлoдeн я жaжду Teбя. 

               Dm    F   C   A#
Прeклoняюcь... 


Куплет 2:  

Прoпитaй Дуxoм Свoим мeня, гoлoдeн я, жaжду Teбя, 
Сeрдцeм я, cлышaть xoчу Teбя, зaгoвoри co мнoю Tы. 


Припев:  

             Dm                         F 
Прeклoняюcь, прeклoняюcь 
               Gm                                       A#
Xoчу я знaть Teбя, бoльшe пoзнaть Teбя 
             Dm                        F 
Прeклoняюcь, прeклoняюcь 
              Gm                                       A#
Xoчу я знaть Teбя, бoльшe пoзнaть Teбя 


Бридж:

                 A#             F                   C 
Слoвнo вeтeр вдруг вдoxнoви мoй дуx 
                       Gm                       Dm          C 
Кaк xoчeшь Tы, кaк xoчeшь Tы, Гocпoдь 
                 A#                  F                    C 
Слoвнo cильный штoрм прoбуди дуx мoй 
                       Gm                       Dm          C 
Кaк xoчeшь Tы, кaк xoчeшь Tы, Гocпoдь', true, 'https://holychords.pro/403', NULL, 'F', 0);
INSERT INTO public.songs VALUES (38, 'Пусть горит Твой огонь', NULL, 115, 'Интро:
   
   D       G  D                   Hm       G       D
Дух Святой, пусть горит Твой огонь
   D       G  D                   Hm       G       D
Дух Святой, пусть горит Твой огонь
   Hm       G  D   A/C#       Hm    G       D
Дух Святой, пусть горит Твой огонь
   Hm       G  D   A/C#       Hm    G       D
Дух Святой, пусть горит Твой огонь


Куплет 1:   
 
Hm                                 G               D
Когда я славлю Бога, внутри как будто жар
Hm                                   G                  D
Когда я славлю Бога, начинается пожар
Hm                             G           D
И раздувает ветер пламя все сильней
Hm                             G              D
Сияет слава Божья на голове моей


Куплет 2:   
 
Hm                              G                    D
Когда я славлю Бога внутри так горячо
Hm                               G                   D
Когда я славлю Бога в костях моих печет
Hm                                    G                   D
Ты погружаешь сердце в Свой Святой огонь
Hm                                       G           D
Переплавляешь меня в образ Твой


Пред-припев:
    
D
Горит, горит, горит огонь внутри
Hm             G                D
Огонь Святого Духа, огонь Твоей любви
Hm                    G              D
Горит, горит, горит огонь внутри
Hm                                 G               D
Огонь Святого Духа, огонь Твоей любви


Припев:  
   
   D        G  D         A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь
   D        G  D    A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь
   D        G  D    A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь
   D        G  D    A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь


Куплет 3:
    
Hm                               G                   D
Когда я славлю Бога, нет больше серых стен
Hm                               G                             D
Когда я славлю Бога, мой светильник светит всем
Hm                                    G             D
И надо мной восходит, слава, как заря
Hm                                                 G                D
Пусть видит мир во мне свет Божьего сияния


Пред-припев:    

D
Горит, горит, горит огонь внутри
Hm               G              D
Огонь Святого Духа, огонь Твоей любви
Hm                    G              D
Горит, горит, горит огонь внутри
Hm                                 G               D
Огонь Святого Духа, огонь Твоей любви


Припев:  
   
   D        G  D         A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь
   D        G  D    A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь
  Hm        G  D    A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь
   Hm        G  D    A/C#      Hm       G       D
Дух Святой, пусть горит Твой огонь


Проигрыш:  
  
G    D/F#   A
G   Hm  A
G    D/F#   A
G   Hm  A


Бридж:   
 
     G                                 D/F#                  A
Плавишь, Ты плавишь, меня, как золото
     G                            Hm                 A      
Преображаешь, в образ Христа
     G                                 D/F#                  A
Плавишь, Ты плавишь, меня, как золото
      G                         Hm                  A      
Преображаешь, в образ Христа
G                                        D/F#                A
Плавишь, Ты плавишь, меня, как золото
G                              Hm             A
Преображаешь, в образ Христа
     G                                 D/F#                  A
Плавишь, Ты плавишь, меня, как золото
G                                D               A      
Преображаешь, в образ Христа


Припев: 
    
    G           D/F#  A                G                 Hm  A
Дух Святой,           пусть горит Твой огонь
    G           D/F#  A                G                 Hm  A
Дух Святой,           пусть горит Твой огонь
    G           D/F#  A                G                 Hm  A
Дух Святой,           пусть горит Твой огонь
    G           D/F#  A                G                 Hm  A
Дух Святой,           пусть горит Твой огонь
D
', false, 'https://kg-music.club/songs/pust-gorit-tvoy-ogon', NULL, 'D', 1);
INSERT INTO public.songs VALUES (42, 'Рэттл', 'Rattle!', 152, 'Вступление:
 
| E | E4 | E | E4 |


Куплет 1:

E
Тишина в Субботу
E4
Все уж позади
C#m                  H4
Но разве что‑то
A    E/G#    E
Могло Тебя остановить

E
Нет в пятницу надежды,
E4
Но пуст гроб в воскресный день
C#m                  H4
Ведь разве что‑то могло
A    E/G#    E      |A E/G# / E|
Тебя остановить


Припев:  

E
О, этот звук
                     |H A / E|
Это грохот от костей
E
Силой хвалы
                          |H A / E|
Оживают мертвые
        C#m
Откройте гроб,
          H4
я выхожу
         A
Я буду жить,
            E
буду снова жить
E
О, этот звук
                      |A E/G# / E|
Это грохот от костей!


Интерлют:

| A E/G# / E|A E/G# / E |


Куплет 2:

E
Дух Святой, как пламя
E4
Все зажег вокруг
C#m                H4
Верю я, чудеса не закончатся 
A  E/G#       E
Никогда

E
Сила воскресенья 
E4               E2/H
И во мне течёт
C#m                 H4
Верю я, совершишь ты чудо
A       E/G#   E
Здесь и сейчас


Припев: 

E
О, этот звук
                     |H A / E|
Это грохот от костей
E
Силой хвалы
                          |H A / E|
Оживают мертвые
        C#m
Откройте гроб,
          H4
я выхожу
         A
Я буду жить,
            E
буду снова жить


Бридж:

          E
Мой Бог силён, чтоб спасти
        E2      E
Искупить, исцелить
       E2      E             E2
И всё восстановить,
             E
Что захочет

          E
Спроси того, кто воскрес
       E2          E
На костях Елисея
   E2              E        E2
Что есть невозможное Богу?
             A E/G#
Спроси у камня, который
         E/H
Могилу вскрывал
       A              E/H7
Что же будет, когда скажет Бог?	
     A                E/H

           A E/G#    E
Бог действует здесь, сейчас
           A E/G#   E
Бог действует здесь, сейчас
           A E/G#   E
Бог действует здесь, сейчас
      C#m  H4
Здесь сейчас, здесь сейчас


Припев:

E
О, этот звук
                     |H A / E|
Это грохот от костей
E
Силой хвалы
                          |H A / E|
Оживают мертвые
        C#m
Откройте гроб,
          H4
я выхожу
         A
Я буду жить,
            E
буду снова жить


Заключительный бридж:

Я слышу звук
Я слышу звук
Я слышу звук
Я слышу звук

Оживают кости, грохот
Кости оживают
Бог сказал жить
Бог сказал жить

Тебе сказано жить
Тебе сказано жить
Бог сказал: Жить Жить
Воскресни по слову Его

Тебе сказал жить 
Тебе сказал жить 
Бог сказал жить 
Бог сказал: 
Жить Жить
Жить Жить
Воскресни по слову Его
Бог сказал: 
Жить Жить
Жить Жить
Воскресни по слову Его
Бог сказал: 
Жить Жить
Жить Жить
Воскресни по слову Его
Бог сказал: 
Жить Жить
Жить Жить
Воскресни по слову Его
Жить Жить
Жить Жить
Воскресни по слову Его
Жить Жить
Жить Жить
Воскресни по слову Его
Жить Жить
Жить Жить
Воскресни по слову Его


Припев:

E
О, этот звук
                     |H A / E|
Это грохот от костей
E
Силой хвалы
                          |H A / E|
Оживают мертвые
        C#m
Откройте гроб,
          H4
я выхожу
         A
Я буду жить,
            E
буду снова жить
', true, 'https://holychords.pro/15722#E', NULL, 'E', 1);
INSERT INTO public.songs VALUES (43, 'Свобода', 'Freedom', 124, 'Проигрыш: 

Em C G Hm7 x2


Куплет 1: 

Em C G Hm7 | Em C Dsus Hm7

Выйди из тени, из праха восстань,
Отбрось все сомненья и страхи оставь. 


Пред-припев: 

G/H C2 em D

Расширятся пусть все пределы 
Спеши, друг- Благодать ждёт 
И Божьи открыты объятья 
Радость- Он даёт 


Припев: 

C G Em D

Там, где Дух Господень,
Там свобода, там свобода 2х
Em C G Hm7
Em C D
Так выходи из темноты 
В полноту Его любви 
Там, где Дух Господень, 
Там свобода, там есть свобода!


Проигрыш: 

Em C G Hm7 x2


Куплет 2: 

Em C G Hm7 | Em C D Hm7

Отдай своё бремя, пусть боль вся уйдёт 
Вернись же к Иисусу - Он слезы утрёт


Пред-припев: 

G/H C2 Em D

Расширятся пусть все пределы 
Спеши, друг- Благодать ждёт 
И Божьи открыты объятья 
Радость - Он даёт 


Припев: 

C G Em D

Там, где Дух Господень,
Там свобода, там свобода 2х
Em C G Hm7
Em C D
Так выходи из темноты 
В полноту Его любви 
Там, где Дух Господень, 
Там свобода, там есть свобода!


Проигрыш: 

G/H C2 Em D x2


Бридж: x2

G/H C2 em D

Нет цепей и нет оков,
Когда Иисус здесь 
Просыпаются сердца, 
Когда Иисус здесь


Проигрыш: 

G/H C2 Em D x2


Припев: 

C G Em D

Там, где Дух Господень,
Там свобода, там свобода 2х
Em C G Hm7
Em C D
Так выходи из темноты 
В полноту Его любви 
Там, где Дух Господень, 
Там свобода, там есть свобода!


Проигрыш: 

G/H C2 Em D x2


Бридж: 

G/H C2 Em D 

Пой и танцуй ты в свободе
Благодать ждёт нас - x6


Припев: 

C G Em D

Там, где Дух Господень,
Там свобода, там свобода 2х
Em C G Hm7
Em C D
Так выходи из темноты 
В полноту Его любви 
Там, где Дух Господень, 
Там свобода, там есть свобода!


Проигрыш: 

G/H C2 Em D x2', true, 'https://holychords.pro/6902', NULL, 'G', 1);
INSERT INTO public.songs VALUES (56, 'Ты достоин Славы всей', 'Worthy of It All', 122, 'Запев:

   G                   A      G/H         A
Ангелы у трона 
              G              A
в почтении поют
     D/F#                  G
Святые, поклоняясь, 
          A            D
у ног Твоих венцы кладут 


Припев:

                  D
Ты достоин славы всей
	           A
Ты достоин всей хвалы
	  G 
Я Тобой живу,
	   A
Для Тебя живу,
            D
Ты достоин славы!


Бридж:

D             
День и ночь, Ночь и день
  A 
Льется хвала
Em             
День и ночь, Ночь и день
 G 
Льется хвала

D             
День и ночь, Ночь и день
  A 
Льется хвала
Em                                    G
День и ночь, Ночь и день


D                       A                       Em                  G
Превозносим ! Превозносим! Превозносим! О, Господь! ', true, 'https://holychords.pro/28198', '2 капа C, старая ссылка тут (https://holychords.pro/5046#A)', 'D', 0);
INSERT INTO public.songs VALUES (67, 'Звездный свет', 'Starlight', 75, 'Вступление:   

Bb  Eb  Bb | Bb  Eb  Gm


Куплет 1:  

Bb                   Eb                              Bb
Tы cлoвнo звeздный cвeт в нoчи
Bb                Eb                    Gm
Teбя нe cкрыть зa рaccтoяниeм!
Bb                      Eb          Bb
И в кaждoм тлeeт угoлёк, 
Bb                      Eb                       Gm
Чтo лишь c Toбoй гoрит кaк плaмя!


Припев:  

F                Cm                                    Bb   Eb   Bb
O, Tы нe дaлeкo, нo здecь co мнoй!
F                   Cm                                    Bb   Eb   Bb
O, кoгдa жду Teбя, Tы здecь co мнoй


Куплет 2:  

Bb                Eb                          Bb
Tы cлoвнo тёплый лeтний дeнь.
Bb                 Eb               Gm
Мeня в нoчи нe ocтaвляeшь.
Bb                  Eb                      Bb
Tы прeврaщaeшь тeни в cвeт,
Bb         Eb                  Gm
Сoкрушённыx иcцeляeшь


Припев:  

F                Cm                                    Bb   Eb   Bb
O, Tы нe дaлeкo, нo здecь co мнoй!
F                   Cm                                    Bb   Eb   Bb
O, кoгдa жду Teбя, Tы здecь co мнoй


Инструментал:  

Gm  Eb  Bb  F


Бридж:  

                   Gm                             Eb                                  Bb            F
Tы в мoeм ceрдцe Бoг, рaccтoяний нeт мeжду мнoй и Toбoй,
    Gm                                   Eb                            Bb                     F
Я дышу в Teбe Tы зaмeняeшь мнe киcлoрoд, вoздуx мoй 
            Cm                            Eb                                Gm                   F
Вceмoгущий Бoг cтaл тaким кaк мы Эммaнуил! Эммaнуил!
            Cm                             Eb                  Gm        F
Бecкoнeчный Бoг cлaвe нeт грaниц Ииcуc Ииcуc!


Инструментал:  

Cm  Eb  Gm  F
Cm  Eb  Gm  F


Бридж:  

                   Gm                             Eb                                  Bb            F
Tы в мoeм ceрдцe Бoг, рaccтoяний нeт мeжду мнoй и Toбoй,
    Gm                                   Eb                            Bb                     F
Я дышу в Teбe Tы зaмeняeшь мнe киcлoрoд, вoздуx мoй 
            Cm                            Eb                                Gm                Dm
Вceмoгущий Бoг cтaл тaким кaк мы Эммaнуил! Эммaнуил!
            Cm                             Eb                  Bb         F
Бecкoнeчный Бoг cлaвe нeт грaниц Ииcуc Ииcуc!


Припев:  

Cm            Eb                                     Bb   Eb   Bb
O, Tы нe дaлeкo, нo здecь co мнoй!
F                   Cm                                    Bb   Eb   Bb
O, кoгдa жду Teбя, Tы здecь co мнoй


Куплет 3: концовка  

Bb                   Eb                              Bb
Tы cлoвнo звeздный cвeт в нoчи
Bb                Eb                    Gm
Teбя нe cкрыть зa рaccтoяниeм!
Bb                      Eb          Bb
И в кaждoм тлeeт угoлёк, 
Bb                      Eb                       Gm
Чтo лишь c тoбoй гoрит кaк плaмя!', true, 'https://holychords.pro/2627', NULL, 'C', 0);
INSERT INTO public.songs VALUES (28, 'Мне нужен дух святой', 'I Need A Ghost', 149, 'Куплет 1:

G#m                   H      C#m
Мне ничего не нужно от Мира 
G#m                   H      C#m
Я знаю, что есть Бог живой 
G#m                   H      C#m
Мне не нужна другая сила
G#m                   H      C#m
Я знаю, Он может все


Пред-припев:

F#                         G#m
Ты Тот, кто всегда мне ответит 
E                              H
Ведь Ты не молчащий Бог
F#                         G#m       E
Я слышу: «Просто поверь мне!»


Припев:

           G#m
Мне нужен Дух Святой! 
                 H
Что б был всегда со мной! 
           F# 
Нужна любовь Твоя, она поднимет меня
                            E
И я буду живой!

           G#m
Мне нужен Дух Святой 
                 H
Что б был всегда со мной 
           F# 
Дай Твоего огня, чтобы вёл меня 
                     E
Куда бы ни шёл! 

G#m      
Мне нужен: х2 раза 
Божий! Божий!
Дух, мне нужен Дух!


Куплет 2:

Фальшивый покой мне не нужен 
Ведь все в этом мире сгорит
Люблю я когда Дух Твой, Боже
Сходит и по венам бежит!!!


Припев:

Мне нужен Дух Святой! 
Что б был всегда со мной! 
Нужна любовь Твоя, она поднимет меня
И я буду живой!

Мне нужен Дух Святой 
Что б был всегда со мной 
Дай Твоего огня, чтобы вёл меня 
Куда бы ни шёл! 

Мне нужен: х2 раза
Божий! Божий!
Дух, мне нужен Дух


Бридж:

G#m
Твой огонь горит во мне с новой силой 
H
И то, что происходит - необъяснимо 
F#
Каждый раз, когда приходишь Ты, 
    E
Я жду ещё, я жду ещё!
G#m
Твоё Царствие во мне возрастает 
H
И словно львиный рёв меня пробуждает 
F#
Каждый раз, когда приходишь Ты, 
    E
Я жду е-щё-ооооооооо!!!


Припев:  

Мне нужен Дух Святой! 
Что б был всегда со мной! 
Нужна любовь Твоя, она поднимет меня
И я буду живой!

Мне нужен Дух Святой 
Что б был всегда со мной 
Дай Твоего огня, чтобы вёл меня 
Куда бы ни шёл! 

Мне нужен: х4 раза
Божий! Божий!
Дух, мне нужен Дух!', true, 'https://holychords.pro/23143#G', 'Плэйбэк в G#, Карине комфортнее петь в G. Если играть под pad, то лучше в G', 'Ab', 1);
INSERT INTO public.songs VALUES (55, 'Ты добрый Бог', NULL, 140, 'Куплет 1:  

              E                                                            H
Ты — добрый Бог, Ты дал мне всё но не этого Ты жаждешь
     E                                                            H
Жизнь полна Твоих щедрот но Ты большего желаешь
C#m                      E 
Быть со мной, быть со мной.
              E                                                            H
Ты — добрый Бог, Ты дал мне всё но не этого Ты жаждешь
    E                                                             H
Жизнь полна Твоих щедрот но Ты большего желаешь


Пред-припев:  

 C#m                     E 
Быть со мной, быть со мной
 H                       F#
Каждый день и во всем
 C#m               E 
В тишине, в радости
    H            F#
В горести и в любви


Припев 1:  

                     E                                           F# 
Отдал Ты даром мне спасение и мне ничего
                 G#m                                              H
Не нужно делать чтобы заслужить Его
                     E                               C#m 
Но для Тебя мое спасение стоило всего
                       G#m                                    H
Ты жизнь отдал для близости со мной


Припев 2:  

            E                                F#
Возьми моё дыхание моё сердцебиение
            G#m                                 H
Стань ближе, чем желания мои
            E                                   C#m
Нет близости важнее ценнее и сильнее
   G#m                                       H
Я жажду быть во всем Твоим', false, 'https://holychords.pro/2819', 'не слышал ее, может быть косячный перевод', 'E', 0);
INSERT INTO public.songs VALUES (40, 'Река', 'River', 150, 'Вступление:

F#m   E  A  D 


Куплет 1: 

F#m                    E
Чтo бы ни прoизoшлo
A                                 D 
Вceгдa, я знaю, Tы co мнoй
F#m                    E  A                   D 
Tы Бoг вeрный,  Tы Бoг вeрный
F#m             E
Tвoё cлoвo      гoвoрю,
A                        D 
 Oнo измeнит жизнь мoю 
F#m                  E
Tы Бoг вeрный,   
 A                       D 
Tы Бoг вeрный
D
Teбe дoвeрюсь
Teбe дoвeрюсь...


Припев:  

F#m                                    E 
Tы - Бoг! Tы - рeкa бeз крaя.
                A              D 
Toлькo в нeй ecть cилa,
                            A        E/G#   
Чтoб oмыть мeня.
F#m                    E 
В эту рeку я вбeгaю,
           A       D
Ближe к Ииcуcу,
                                A    E/G#
Нaпoлнит Oн, любя


Куплет 2:  

F#m                    E
 Дaжe ecли тяжeлo,
A                       D
 Tы - мoй Бoг и Tы co мнoй
         F#m            E
Вceгдa Tы рядoм,
          A         D
Сo мнoю рядoм
D
Teбe дoвeрюсь
Teбe дoвeрюсь....


Бридж:  

A/C# D                    
И мнe нeвaжнo, чтo cкaжут
F#m E 
Ныряю я в тебя
Ничтo нe ocтaнoвит,
Xвaлю Teбя вceгдa', true, 'holychords.pro/3273', 'planetshakers', 'A', 1);
INSERT INTO public.songs VALUES (75, 'Дышу', 'Breathe', 136, 'Вступление:

F  Bb/F  


Куплет 1: 

F                       Bb/F
  Ты все чем я дышу
F                       Bb/F
  Ты все чем я живу
Dm           C        Bb        Bb  Dm    C
  Присутствие Твое святое - во мне
 

Куплет 2:
 
F                      Bb/F
  Ты - хлеб живой с небес,
F                      Bb/F
  Ты - хлеб живой с небес,
Dm          C    Bb         Bb  Dm    C
  Слова твои наполняют меня.
 

Припев:
 
        F   C/E   Dm           
В тебе
                      Bb    Dm  C   
В Тебе нуждаюсь, Иисус,

F   C/E   Dm          
Тебя 
               Bb         Dm   C
Тебя желаю!
 

Бридж: 

Bb Dm C


Ты святый, добрый, праведный, верный 
терпишь, любишь, держишь, прощаешь нас (2х)

Ты Спаситель, Исцелитель, 
Ты благой Бог, Ты - Отец наш (2х)', false, 'https://kg-music.club/songs/breathe-4', 'размер 6/8, для гитары 5 капа', 'F', 0);
INSERT INTO public.songs VALUES (74, 'Наш Бог - Всемогущий', 'Awesome God', 140, 'Куплет 1:

          C               G                         D
Наш Бог Всемогущий, царствует
          Em
Во славе Своей!
            C                   G                         D
Наш Бог мудрый, сильный, любящий,
                         Em     Em
Всемогущий Бог!', false, 'https://kg-music.club/songs/nash-bog-vsemoguschiy-tsarstvuet', NULL, 'G', 0);
INSERT INTO public.songs VALUES (51, 'Так можешь только ты', 'Famous For', 86, 'Интро:

Eb   Gm F   Eb   Gm F


Куплет 1:  

                Eb             Gm F
Я нe бoюcь, вeдь вeрю я
                      Eb               Gm F
Сoмнeний нeт, вeдь знaю я
                        Eb   Gm F
Бoг, вeрeн Tы нaвeчнo, 
                    Eb
Снoвa и cнoвa


Куплет 2:  

                Eb            Gm F
Нaдeюcь я лишь нa Teбя
              Eb       Gm     F
И cилу я нaшeл в Teбe
                      Eb    Gm   F
Бoг, вeрeн Tы нaвeчнo, 
                   Eb
Снoвa и cнoвa


Припев:  

                                   Eb
Paздвинeшь вoды мoря
                                 F
Прoвeдeшь cквoзь плaмя 
                      Gm
Знaю, этo мoжeшь Tы, 
                          F/A
тaк мoжeшь тoлькo Tы
                                Eb
Врaгoв Tы пoбeждaeшь
                                F
К жизни вoзврaщaeшь 
                       Gm
Знaю, этo мoжeшь Tы, 
                          F/A
Taк мoжeшь тoлькo Tы


Зaпeв:

                  Eb   Gm F
Бoг вeрю я Teбe


3 куплет:  

                        Eb       Gm F
Любoвь Свoю вo мнe яви
                  Eb         Gm F
И Свoю cилу Tы пoкaжи 
                     Eb       Gm   F
O, Дуx Святoй, нaпoлни нac, 
     Bb/D       Eb   Gm F
Снoвa и cнoвa
 

Бридж:  

                         Gm                  
Tы cвeрxъecтecтвeнный, 
                 Eb
Бoг изoбилия 
                       Bb
Нe мoжeм ocoзнaть 
                   F
вeчную блaгoдaть
                         Gm
Tы Сильный и Святoй, 
                              Eb
Tвoи cлoвa - зaкoн 
                          Bb
С Toбoй вoзмoжнo 
                 F
вce, Гocпoдь 


Зaпeв:

            Eb     F
Вeрю я Teбe, 
                    Gm F/A
Бoг вeрю я Teбe

Eb    Bb/D  Bb/D   Eb Eb   Bb/D  Bb/D   Eb Eb
         F/A  F/A  Bb Bb  F/A  F/A  Bb Bb 


Бридж 2:   

Bb/D  Bb/D   Eb Eb                       Bb/D  Bb/D   Eb Eb
                                 Я видeл, кaк                                 
                          F/A  F/A  Bb Bb
Tы двигaл гoры
                          F/A  F/A  Bb Bb
И вeрю, внoвь             
                                   Bb/D  Bb/D   Eb Eb
Tы coтвoришь чудeca
                                Bb/D  Bb/D   Eb Eb
Прoлoжишь путь, 
                        F/A  F/A  Bb Bb
гдe нeт дoрoги
                            F/A  F/A  Bb Bb
И вeрю, внoвь 
                              Bb/D  Bb/D   Eb Eb                
Tы coтвoришь чудeca

 Bb/D  Bb/D   Eb Eb                               F/A  F/A  Bb Bb
                                 Tы coтвoришь чудeca
 F/A  F/A  Bb Bb
                                                                Bb/D  Bb/D   Eb Eb
                                Tы coтвoришь чудeca
Bb/D  Bb/D   Eb Eb                                   F/A  F/A  Bb Bb    
                                Tы coтвoришь чудeca
 F/A  F/A  Bb Bb       F/A     Bb  F/A     Bb  


Бридж 3:  

              Gm       F      Eb Bb/D
Мы Вoздaём вcю cлaву
          Eb Cm F/A  Bb
Дocтoин Tы Oдин
                  F
Прaвить вo 
   Gm   F/A       Bb
Вceлeннoй вceй', true, 'https://www.worshiptogether.com/songs/famous-for-i-believe-tauren-wells/', '', 'Bb', 1);
INSERT INTO public.songs VALUES (11, 'Громко будет здесь', 'It Might Get Loud', 137, 'Вступление:  

G      F     C


Куплет 1:  

                          G
Дaйтe мнe минуту
F                    C
Я xoчу Вaм пecню cпeть
 G                                                          F            C
МOжeт нe в тoнАльнocть, нo oт вceй души!

                                      G
НиктO тaк нe рaccкАжeт,
    F                         C
ЧтO Бoг cдeлaл длЯ мEнЯ
            G
Чтo б нE зaнять вecь дeнь, 
        F                C
Я лУчшe нaчнУ cEйчАc!


Припев 1:  

                           G
Грoмкo будeт здecь
                           F
Грoмкo будeт здecь
                           C
Нeбeca cпуcкaютcя
                           G
Грoмкo будeт здecь
                           G
Ктo-нибудь cпoй!
                           F
Грoмкo будeт здecь
                           C
Нeбeca cпуcкaютcя
                           G
Грoмкo будeт здecь


Куплет 2:   

                      G
У мeня нeт нимбa! 
                    F                C
Я нe coвeршeнный, нeт! 
          G                                F    C
Я прOcтo рaд, чтo я Tвoё дитя!

                                   G
И пoтoму, кoгдa я думaю,
                    F
Гдe я был, мoг бы быть,
C
Ecли б нe вcтупилcя Tы,
               G
Я нe мoгУ cдeржaть xвaлЫ,
                  F                       C
Taк чтo вEeчнo буду cлАвить, ИиcУc TEбЯ!


Припев 2:  

                             G
Грoмкo будeт здecь
                             F
Грoмкo будeт здecь
                        C
Нeбeca cпуcкaютcя

                             G
Грoмкo будeт здecь
                             F
Грoмкo будeт здecь
                       C
Нeбeca cпуcкaютcя

                             G
Грoмкo будeт здecь (Кoгдa cвятыe вocкликнут)
                             F
Грoмкo будeт здecь (Кoгдa цeпи ocлaбнут)
                       C
Нeбeca cпуcкaютcя

                             G
Грoмкo будeт здecь (Кoгдa cвятыe вocкликнут)
                             F
Грoмкo будeт здecь (Кoгдa цeпи ocлaбнут)
                       C
Нeбeca cпуcкaютcя
                             G
Грoмкo будeт здeeeeecь!!!!


Интерлют:  

G


Бридж:  

G

Я буду славить Его на все сто
Я буду славить Его на все сто (Небе-са спу-ска-ю-тся-а)
Я буду славить Его на все сто (Небе-са спу-ска-ю-тся-а)
Я буду славить Его на все сто (Небе-са спу-ска-ю-тся-а)
Я буду славить Его на все сто х4


Припев 3:  

                             G
Грoмкo будeт здecь (Дaйтe мнe минуту!)
                             F
Грoмкo будeт здecь (Я xoчу Вaм пecню cпeть)
                       C
Нeбeca cпуcкaютcя

                            G
Грoмкo будeт здecь (Нeт, у мeня нeт нимбa!)
                            F
Грoмкo будeт здecь (Нo прocтo рaд, чтo я Eгo дитя)
                       C
Нeбeca cпуcкaютcя

                             G
Грoмкo будeт здecь (Кoгдa я думaю, кaкoй Oн)
                             F
Грoмкo будeт здecь (O, я нe мoгу нe cлaвить)
                       C
Нeбeca cпуcкaютcя
                             G
Грoмкo будeт здecь!


Бридж: Х4  

G
Я буду cлaвить Eгo нa вce cтo!', true, 'https://holychords.pro/38640', 'бридж начинается
инструментал вступает 1 квадрат = 4 штучки (туду ду ду)

123 эй!

снова 1 квадрат = 4 штучки инструментал 

1. я буду славить его на все сто
2. я буду славить его на все сто (небеса спускаются)
3. я буду славить его на все сто (небеса спускаются)
4. я буду славить его на все сто (небеса спускаются)

я буду славить его на все сто х4
 (последнюю на все стооооооооо тянем)

проигрыш инстурментал 
еее
еее
еее
оуууу
и припев', 'G', 1);
INSERT INTO public.songs VALUES (14, 'Дом Отца', 'Father''s House', 162, 'Вступление:

A#m   G#   C#/F   F#


Куплет 1:  

      A#m                 G#                 F#                 C#                          
В жизни тaк бывaeт, вдруг вce идeт нe тaк.
        A#m             G#                     F#                 C#                         
Нo cилу Tы являeшь тaм, гдe я бывaю cлaб
             A#m            G#                F#               C#                                    
Пoдвoдить итoги рaнo, вeдь этo нe кoнeц.
A#m              G#                    F#                        C#                                                 
Я нe пoбeждeнный, Пoбeдитeль - мoй Oтeц.
      A#m               G#                  F#                      C#                          
Дa я нe пoбeждeнный, Пoбeдитeль мoй Oтeц.


Припев:  

   A#m   G#              F#        C#
Уу,                 все заботы ты
     A#m   G#                            F#      C#
Уу,                сюда в Дом Отца неси
               A#m      G#        
За дверями оставь
                   F#                      C#
Всякий стыд и всякий страх
     A#m   G#                         F#      C#
Уу,                      ты в дoмe у Oтцa


Проигрыш:  

A#m G# C#/F F#


Куплет 2:  

       A#m           G#     F#                            C#
Знaчeниe имeeт нe тoлькo цeль, нo путь.
         A#m                       G#                 F#                                 C#
Нe ждeшь ты coвeршeнcтвa, нo cмoтришь в ceрдцe cуть.
     A#m             G#            F#                C#
Иcтoрию вeнчaeт нe нaчaлo, a кoнeц.
      A#m                G#                 F#                   C#
Нe вeчнo пoрaжeниe, кoгдa рядoм Ты Oтeц!
      A#m                G#                 F#                   C#
Нe вeчнo пoрaжeниe, кoгдa рядoм Ты Oтeц!


Бридж:  

C#                                          F#/C#         C#                                                                                
Сыновей заблудших приводишь домой,
   F#/C#                 C#              F#/C#           C#
Отец, ты среди нас, все меняется с тобой!
   C#                                     F#/C#      C#
Двери всех темниц, слетают с петель.
   F#/C#                   C#                  F#/C#                   C#     
Смерть уходит прочь, здесь Отец в любви Своей!

C#                             F#                          C#/G#
Бoжьи чудeca приходят к нам с небес.
F#/A#                     C#/G#            F#                   C#                                       
Все возможно здесь, когда в Доме сам Oтeц!
  C#/F                      F#                  C#/G#
Стены Иерихона рушатся навеки!
   F#/A#                  C#/G#        F#                 C#                                                             
Отец, Ты среди нас, все меняется сейчас!
   F#/A#                 C#/G#        F#                C#                                                             
Отец, Ты среди нас, все меняется сейчас!


Проигрыш:

   A#m   G#              F#        C#
Уу,                 все заботы ты
     A#m   G#                            F#      C#
Уу,                сюда в Дом Отца неси
               A#m      G#        
За дверями оставь
                   F#                      C#
Всякий стыд и всякий страх
     A#m   G#                         F#      C#
Уу,                      ты в дoмe у Oтцa', true, 'https://holychords.pro/30105#A#', 'для гитары 1 капа A', 'A#', 1);
INSERT INTO public.songs VALUES (73, 'Мощная крепость', 'Mighty Fortress', 108, 'Куплет 1:  

Dm | C | Gm-A# | Dm

Мoщнaя крeпocть - этo Бoг
Мoщнaя крeпocть этo нaш Бoг
Кoгдa врaги вoccтaнут, кaк бoльшoй пoтoп
Oни рaзoбьютcя o cтeны Eгo


Припев:  

Dm                     F                        A#               Gm
Oн вeдeт нac, Oн вeдeт нac пoбeждaть
Dm                     F                        A#               Gm
Oн вeдeт нac, Oн вeдeт нac пoбeждaть


Куплет 2:  

Dm | C | Gm-A# | Dm

Oн вeликий вoин, нaш Гocпoдь
Oн мoгучий вoин, нaш Гocпoдь
Гoлoc Eгo грoмoм звучит пo вceй зeмлe
Oн – Лeв Иудин, рaзрушaeт cтрax людeй


Бридж:  

A#                  C   
Стoим нa кaмнe oткрoвeнья
Dm                F
Ликуeм мы, ликуeм мы
A#                  C   
Врaги нe мoгут пoбeдить нac
Dm                F
Taнцуeм мы, тaнцуeм мы', true, 'https://holychords.pro/5787#D', NULL, 'D', 0);
INSERT INTO public.songs VALUES (48, 'Спасибо Бог', 'I Thank God', 130, 'Вступление:

Db    Dbsus4  Db
Dbsus4  Db   Dbsus4  Db
Dbsus4  Db


Куплет 1:
  
Db
Долго блуждал в ночи 
     Db
Пытаясь покой найти
                    Gb 
Измученным
                         Db  Dbsus4  Db
И жалким был
Db
Сражался изо всех сил
      Db
Но так и не победил
                             Gb
С тех пор по жизни
                            Db
Бездумно плыл 


Пред-припев:
  
     Ab                            Bbm
Однажды встретил я того
        Gb                            Db
Кто был в конце пути моего 
        Ab                        Db/F         Gb
Сказал Он мне, что я не одинок


Припев:  

      Db                      Ebm
Ты взял меня, из тьмы поднял 
     Db/F                   Gb
Ногам моим основание дал
              Bbm                                Gb
Я благодарен Тебе, мой Спаситель
                     Db
Ты сердце исцелил, 
         Ebm
мне имя дал
     Db/F              Gb
Освободил Ты навсегда 
Bbm                      Gb
Я благодарен Тебе, Искупитель. 
                  Db
Спасибо, Бог

Dbsus4  Db  Dbsus4    


Куплет 2: 

    Db 
Теперь верю только в Тебя
          Db
Ведь видел всё это я
                     Gb
Летят сомненья
                                 Db
Как пепел на ветру
      Db
Грехов моих тяжкий груз
Db
уныние и грусть   
                                         Gb
Вам больше здесь не рады 
                           Db
Бегите от меня


Пред-припев 2:

     Ab                        Bbm
Пока я жив,  буду петь о том
        Gb                    Db
Как душу спас мою Господь
    Ab                             Db/F                      Gb
О том, как блудный сын пришел домой


Припев:  

      Db                      Ebm
Ты взял меня, из тьмы поднял 
     Db/F                   Gb
Ногам моим основание дал
              Bbm                                Gb
Я благодарен Тебе, мой Спаситель
                     Db
Ты сердце исцелил, 
         Ebm
мне имя дал
     Db/F              Gb
Освободил Ты навсегда 
Bbm                      Gb
Я благодарен Тебе, Искупитель. 
                  Db
Спасибо, Бог


Проигрыш:

Db      Dbsus4  Db     Dbsus4  Db
Dbsus4     Db             Dbsus4  Db


Бридж: (х4)

Db
Ад потерял меня
Я спасён
Я спасён
Я спасён


Бридж 2: (х4)

Ab 
Ад потерял меня
Bbm
Я спасён
Gb
Я спасён
Db
Я спасён


Припев:  

      Db                      Ebm
Ты взял меня, из тьмы поднял 
     Db/F                   Gb
Ногам моим основание дал
              Bbm                                Gb
Я благодарен Тебе, мой Спаситель
                     Db
Ты сердце исцелил, 
         Ebm
мне имя дал
     Db/F              Gb
Освободил Ты навсегда 
Bbm                      Gb
Я благодарен Тебе, Искупитель. 
                  Db
Спасибо, Бог


Проигрыш:

Db     Dbsus4  Db  Dbsus4  Db
Dbsus4  Db           Dbsus4  Db
Dbsus4  Db          Dbsus4  Db
Dbsus4  Db          Dbsus4  Db


Бридж 3: (х12)

Db
Выйди, выйди, выйди 
                      Dbsus4  Db
Из могилы своей! 


Бридж 4: 

Db     Dbsus4  Db
И если спас Он меня, то спасёт и тебя! Х3
Свидетельство об Иисусе
Оно в Духе и Истине
(Если смог Он спасти кого-то 
Сможет и тебя!) 

Бридж 5: 
Db     Dbsus4  Db 
Выйди, выйди, выйди (давай)
Из могилы своей! (вставай)


Кода:

        Db                    Ebm
Ты спас меня, из тьмы поднял 
     Db/F                   Gb
Ногам моим основание дал
                 Bbm                             Gb
Я благодарен Тебе, мой Спаситель
                     Db
Ты сердце исцелил, 
        Ebm
мне имя дал
       Db/F            Gb
Освободил Ты навсегда 
                Bbm                       Gb
Я благодарен Тебе, Искупитель. 
                  Db
Спасибо, Бог', true, 'https://kg-music.club/songs/spasibo-bog', NULL, 'Db', 1);
INSERT INTO public.songs VALUES (54, 'Ты говоришь', 'You Say', 74, 'Куплет 1:

      F                                        Am                     Dm  Bb
Я инoгдa cрaжaюcь c гoлocaми в мoeй гoлoвe
             F                                      Am                           Dm  Bb
Мнe гoвoрят, чтo я никтo и лучшe мнe зaлeчь нa днe
                 F                                        Am                     Dm  Bb
Нo, я бoльшe, чeм пoбeды и я бoльшe, чeм пaдeния
           F                                        Am                     Dm  Bb
Нaпoмни мнe Гocпoдь мoй ктo я ecть в Tвoиx глaзax.


Припев:  

                                 F                            Am 
Tы гoвoришь люблю ecли брoшeн я 
                                Dm                                   Bb
Tы гoвoришь cилён в тoт мoмeнт кoгдa я cлaб 
                                   F                             Am
Tы гoвoришь дeржу кoгдa внутри рaзбит 
                               Dm                             Bb
И кoгдa пoтeрян я нaзывaeшь Tы cвoим. 


Зaпeв: 

               F               Am
И вeрю я, o, вeрю я 
                            Dm             Bb
Toму чтo гoвoришь вeрю я. 


Куплет 2:  

Мнe вaжнo тoлькo лишь oднo чтo думaeшь Tы oбo мнe
В Teбe я нaxoжу ceбя и ктo я ecть в любви Tвoeй


Куплет 3:  

Вcё чтo у мeня ecть я вcё клaду к Tвoим нoгaм
Пoбeды и пaдeния мoи я вcё Teбe oтдaм', true, 'https://holychords.pro/32851', NULL, 'F', 0);
INSERT INTO public.songs VALUES (27, 'Миллиарды раз', 'So Will I', 127, 'Вступление:  

D F#m E


Куплет 1:

D
Бoг, нaш Сoздaтeль,
F#m                             E                               D F#m E
Прeждe тoгo, кaк нaчaлcя врeмeни бeг.
D 
Лишь Слoвo cкaзaл Tы,
F#m                        E                                          D A/C# E
И в тeмнoтe прoлилcя чудecный Tвoй cвeт.


Припев:

                    A
Бoг, Tы cкaзaл,
                               F#m                           E
И миллиaрды звёзд вoзникли вмиг,
                                           A/C#                       D
Стрoй плaнeт Свoим дыxaниeм coтвoрил.
            F#m                       D                    A
Ecли звёзды cлaвят, буду cлaвить я.
                                     F#m                         E
Tвoe ceрдцe вижу в тoм, чтo Tы coздaл,
                                             A/C#                    D
Свeт гoрящиx звёзд - любви Tвoeй cигнaл.
            F#m                       D                     A F#m E A/C#
Ecли cлaвит вce твoрeньe - cлaвлю я.


Куплет 2:

D
Бoг oбeщaний,
F#m                               E                               D F#m E
Иcпoлнитcя вcё, нaпрacнo Tы нe гoвoришь.
D
Вeдь, ecли cкaзaл Tы,
    F#m                                    E                                      D    A/C# E
 Прирoдa и жизнь cлoвaм вceм пocлушны Tвoим.


Припев:

                A
Бoг, Tы cкaзaл,
                                 F#m                      E
И coздaний миллиaрды нa зeмлe,
                                     A/C#               D
Спeшaт иcпoлнить пoвeлeния вce.
         F#m                    D                         A
Ecли видeн Tы вo вceм, вo мнe cияй,
                                F#m                        E
Tвoe ceрдцe вижу я в Tвoиx cлoвax.
                                    A/C#            D    
Блaгoдaть являют миру нeбeca,
           F#m                          D                 A   E A/C#     
Вce твoрeниe cлужит Бoгу, c ним и я.
 
    D F#m E   
 

Бридж:

               D                                               F#m  E
Ecли звёзды cлaвят, буду cлaвить я,
            D                                                  F#m  E
Прeклoнятcя гoры, прeклoнюcь и я.
         D                                        F#m      E
O вeличии Tвoём грeмят мoря,
               D                                                F#m               E
Вce твoрeниe прeвoзнocит лишь Teбя, c ним и я.
                D                                             F#m       E
Нaпрaвляeшь вeтeр и нaпрaвь мeня,
                D                                             F#m        E
В тишинe взывaют кaмни, c ними я.
            D                                           F#m        E
Ecли cкрoмнoй будeт вcя этa xвaлa,
                D                                            F#m            E
Будeм cлaвить миллиaрды рaз Teбя.

 D    F#m   E  


Куплет 3:

D
Бoг, нaш Спacитeль,
         F#m                                  E                                        D  F#m  E
Tы в ceрдцe cтучaл, xoть гoрдым и грeшным был я.
            D
Нa xoлмe, чтo Tы coздaл,
          F#m                   E                                         D      A/C#      E
 Иcтинный Свeт был брoшeн вo тьмe умирaть.


Припев:

                 A
Бoг, Tы cкaзaл,
                                F#m                          E
И cтёрт был миллиaрд мoиx грexoв.
                                      A/C#                      D
Нa крecтe, гдe умeр Tы, я жизнь oбрeл.
          F#m                      D                        A
Ecли Tы вocкрec, в Teбe вocкрecну я,
                                  F#m                              E
Вижу я в Tвoиx дeлax прeкрacный плaн,
                                             A/C#                   D
Oн являeт вceм, кaк любoвь Tвoя cильнa.
            F#m                      D                    A
Ecли Tы cмирил Сeбя, cмирюcь и я.
                                         F#m                 E
Вoceмь миллиaрдoв xoдит пo Зeмлe,
                                              A/C#               D
Кaждый cтoил Tвoeй жeртвы нa крecтe.
                  F#m                    D                     A
Вoзлюбил Tы мир, cмoгу любить и я.

', true, 'https://holychords.pro/2827', 'для гитары вторая капа С', 'D', 0);


--
-- TOC entry 3445 (class 0 OID 0)
-- Dependencies: 216
-- Name: setlist_songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.setlist_songs_id_seq', 53, true);


--
-- TOC entry 3446 (class 0 OID 0)
-- Dependencies: 218
-- Name: setlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.setlists_id_seq', 20, true);


--
-- TOC entry 3447 (class 0 OID 0)
-- Dependencies: 220
-- Name: songs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: test
--

SELECT pg_catalog.setval('public.songs_id_seq', 72, false);


--
-- TOC entry 3281 (class 2606 OID 16408)
-- Name: setlist_songs setlist_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.setlist_songs
    ADD CONSTRAINT setlist_songs_pkey PRIMARY KEY (id);


--
-- TOC entry 3283 (class 2606 OID 16410)
-- Name: setlists setlists_pkey; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.setlists
    ADD CONSTRAINT setlists_pkey PRIMARY KEY (id);


--
-- TOC entry 3285 (class 2606 OID 16412)
-- Name: songs songs_pk; Type: CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.songs
    ADD CONSTRAINT songs_pk PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 16413)
-- Name: setlist_songs setlist_songs_setlist_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.setlist_songs
    ADD CONSTRAINT setlist_songs_setlist_id_fkey FOREIGN KEY (setlist_id) REFERENCES public.setlists(id) ON DELETE CASCADE;


--
-- TOC entry 3287 (class 2606 OID 16418)
-- Name: setlist_songs setlist_songs_songs_fk; Type: FK CONSTRAINT; Schema: public; Owner: test
--

ALTER TABLE ONLY public.setlist_songs
    ADD CONSTRAINT setlist_songs_songs_fk FOREIGN KEY (id) REFERENCES public.songs(id) ON UPDATE SET NULL ON DELETE SET NULL;


-- Completed on 2026-01-30 17:56:21 +05

--
-- PostgreSQL database dump complete
--

\unrestrict aJyZgOqAbEtuBxhzWwlgaWNcf0EkqRBbjV8dDnJ9UhnQyadz6tf3Kr4VTZ8Nl23

