-- TABLE 생성
CREATE TABLE book (book_id NUMBER(5),
                   title VARCHAR2(50),
                   author VARCHAR2(10),
                   pub_date date);

-- column 추가
ALTER TABLE book ADD (pubs VARCHAR2(50));

-- column 수정
ALTER TABLE book MODIFY (title VARCHAR2(100));
ALTER TABLE book RENAME COLUMN title TO subject;

-- column 삭제
ALTER TABLE book DROP (author);

-- TABLE 이름 수정
RENAME book TO article;

-- TABLE 삭제
DROP TABLE article;

/*
제약조건
#1 NOT NULL: NULL 데이터 입력 불가
#2 UNIQUE: 중복 데이터 입력 불가(NULL 데이터는 허용)
#3 PRIMARY KEY: NOT NULL + NUIQUE >> 각 데이터의 유일성을 보장하는 'column'에 설정
                                     'TABLE'당 1개만 설정 가능(여러개를 묶어서 설정 가능)
#4 FOREIGN KEY: 일반적으로 'REFERENCE TABLE'의 'PK'를 참조
                'REFERENCE TABLE'에 없는 데이터 삽입 불가
                'REFERENCE TABLE'의 레코드 삭제 시 동작
*/

CREATE TABLE author (author_id NUMBER(10),
                     author_name VARCHAR2(100) NOT NULL,
                     author_desc VARCHAR2(500),
                     PRIMARY KEY (author_id));

-- INSERT
INSERT INTO author VALUES(1, '박경리', '토지 작가');-- VALUES(author_id, 'author_name', 'author_desc');
INSERT INTO author(author_id, author_name) VALUES(2, '이문열');-- INSERT INTO author VALUES(2, '이문열', 'NULL'); >> 지정되지 않은 'column'의 데이터는 NULL 자동입력

-- UPDATE
UPDATE author SET author_name = '기안84',
                  author_desc = '[나 혼자 산다] 출연 웹툰작가'
WHERE   author_id = 1;

-- DELETE
DELETE FROM author WHERE author_id = 1;

DELETE FROM author;-- 테이블 데이터 전부 삭제

-- 'TABLE' 조회
SELECT
    *
FROM    author;

-- SEQUENCE
CREATE SEQUENCE seq_author_id INCREMENT BY 1 START WITH 1;-- 1번부터(START WITH 1) +1씩(INCREMENT BY 1)하여 'author_id'에 번호 부여 >> 주로 'PRIMARY KEY'에 사용

INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '이문열', '경북 영양');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '박경리', '경남 통영');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '유시민', '17대 국회의원');
INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, '기안84', '[나 혼자 산다] 출연 웹툰작가');

-- 모든 'SEQUENCE' 조회
SELECT
    *
FROM    user_sequences;

-- 현재 'SEQUENCE' 조회
SELECT  seq_author_id.currval
FROM    dual;

-- 다음 'SEQUENCE' 조회 > 실행시 무조건 1 증가
SELECT  SEQ_AUTHOR_ID.nextval
FROM    dual;

-- 'SEQUENCE' 삭제
DROP SEQUENCE seq_author_id;

-- 쿼리문 적용 >> 'DML'(INSERT, DELETE, UPDATE) 명령어에만 사용 가능
COMMIT;

-- 쿼리문 미적용 >> 'DML'(INSERT, DELETE, UPDATE) 명령어에만 사용 가능
ROLLBACK;