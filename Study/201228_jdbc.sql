SELECT  author_id,
        author_name,
        author_desc
FROM    author;

INSERT INTO author VALUES(SEQ_AUTHOR_ID.nextval, 'J.K. 롤링', '해리포터 시리즈로 세계적인 명성을 얻다.');
UPDATE author SET author_desc = '2010년 안데르센 문학상' WHERE author_id = 7;
DELETE FROM author WHERE author_id = 7;

-----------------------------------------------------------------------------------------------

SELECT  book_id,
        title,
        pubs,
        pub_date,
        author_id
FROM    book;

INSERT INTO book VALUES(SEQ_BOOK_ID.nextval, '해리포터와 마법사의 돌', '문학수첩', '14/12/18', 7);
UPDATE book SET title = '해리포터 시리즈' WHERE book_id = 9;
DELETE FROM book WHERE book_id = 9;

-----------------------------------------------------------------------------------------------

SELECT  b.book_id,
        b.title,
        b.pubs,
        b.pub_date,
        a.author_id,
        a.author_name,
        a.author_desc
FROM    book b, author a
WHERE   b.author_id = a.author_id
ORDER BY b.book_id asc;

COMMIT;

ROLLBACK;