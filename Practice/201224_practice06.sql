SELECT
    *
FROM    book;

DELETE FROM book WHERE book_id = 1;

DELETE FROM book WHERE author_id = 4;

DELETE FROM book;

CREATE TABLE book (book_id NUMBER(10),
                   title VARCHAR2(100),
                   pubs VARCHAR2(100),
                   pub_date DATE,
                   author_id NUMBER(10),
                   PRIMARY KEY (book_id),
                   CONSTRAINT book_fk FOREIGN KEY (author_id) REFERENCES author(author_id));

CREATE SEQUENCE seq_book_id INCREMENT BY 1 START WITH 1;

DROP SEQUENCE seq_book_id;

SELECT  seq_book_id.currval
FROM    dual;

INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);
INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '삼국지', '민음사', '2002-03-01', 1);
INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '토지', '마로니에북스', '2012-08-15', 2);
INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '유시민의 글쓰기 특강', '생각의 길', '2015-04-01', 3);
INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);
INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '순정만화', '재미주의', '2011-08-03', 5);
INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '오직 두사람', '문학동네', '2017-05-04', 6);
INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '26년', '재미주의', '2012-02-04', 5);

SELECT
    *
FROM    author;

UPDATE author SET author_desc = '서울특별시'
WHERE   author_id = 5;

DELETE FROM author WHERE author_id = 4;

DELETE FROM author;

CREATE SEQUENCE seq_author_id INCREMENT BY 1 START WITH 1;

DROP SEQUENCE seq_author_id;

SELECT  seq_author_id.currval
FROM    dual;

INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '이문열', '경북 영양');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '박경리', '경남 통영');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '유시민', '제17대 국회의원');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '기안84', '기안동에서 산 84년생');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '강풀', '1세대 온라인 만화가');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '김영하', '알쓸신잡');

SELECT  b.book_id,
        b.title 제목,
        b.pubs 출판사,
        b.pub_date 출판일,
        a.author_id,
        a.author_name 지은이,
        a.author_desc 기타
FROM    book b, author a
WHERE   b.author_id = a.author_id
ORDER BY b.book_id asc;

COMMIT;
ROLLBACK;