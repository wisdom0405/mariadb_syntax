-- Insert into : 데이터 삽입
INSERT INTO 테이블명(컬럼1, 컬럼2, 컬럼3) VALUES(데이터1, 데이터2, 데이터3)

--- id, name, email-> author 1건 추가
INSERT INTO author(
    id,
    name,
    email
) VALUES(
    1,
    'wisdom',
    'wisdom@naver.com'
);

-- SELECT : 데이터조회, * : 모든컬럼 조회
SELECT * FROM author;

-- id, title, content, author_id -> post 테이블에 1건 추가
INSERT INTO posts(
    id,
    title,
    content,
    author_id
) VALUES(
    1,
    'super-hamster',
    'about super-hamsters',
    1
);

SELECT * FROM posts;

-- 테이블 제약조건 조회
SELECT * FROM information_schema.key_column_usage WHERE table_name = 'posts';

show databases;

-- 내가 현재 use하고 있는 스키마에서는 select * from 테이블명;
-- 다른 스키마 테이블 조회시에는 select * from 스키마명.테이블명; 

-- UPDATE 테이블명 SET 컬럼명 = 데이터 WHERE id = 1;
UPDATE author SET email = 'abc@test.com' WHERE id = 1;

-- insert문을 통해 author 데이터 4개정도 추가, post 데이터5개 추가
INSERT INTO author(id,name,email,password, address) VALUES (2,'wisdom2','wisdom2@naver.com','1234','어쩌구저쩌구');
INSERT INTO author(id,name,email,password, address) VALUES (3,'wisdom3','wisdom3@naver.com','1234','어쩌구저쩌');
INSERT INTO author(id,name,email,password, address) VALUES (4,'wisdom4','wisdom4@naver.com','1234','어쩌구저');
INSERT INTO author(id,name,email,password, address) VALUES (5,'wisdom5','wisdom5@naver.com','1234','어쩌구');


INSERT INTO post(id, title, contents, author_id) VALUES(1,'super-hamster','about super-hamsters',1);
INSERT INTO post(id, title, contents, author_id) VALUES(2,'super-hamster2','about super-hamsters2',2);
INSERT INTO post(id, title, contents, author_id) VALUES(3,'super-hamster3','about super-hamsters3',3);
INSERT INTO post(id, title, contents, author_id) VALUES(4,'super-hamster4','about super-hamsters4',4);
INSERT INTO post(id, title, contents, author_id) VALUES(5,'super-hamster5','about super-hamsters5',5);

-- UPDATE 테이블명 set 컬럼명 (where 조건 무조건 있어야 함. WHERE문 없으면 전체 데이터 수정됨)
UPDATE author SET name = 'wisdom33', email = 'wisdom33@naver.com' WHERE id = 3; 

-- DELETE 문 실습
-- DELETE FROM 테이블명 WHERE 조건
-- WHERE 조건이 생략될 경우 모든 데이터가 삭제됨에 유의
DELETE FROM post WHERE id = 5;
DELETE FROM author WHERE id = 5;
SELECT * FROM author;

-- SELECT 문의 다양한 조회 방법
SELECT * FROM author;
SELECT * FROM author WHERE id=1;
SELECT * FROM author WHERE id > 2; 
SELECT * FROM author WHERE id > 2 and name = 'wisdom33'; -- 두 조건 모두 만족

-- 특정 컬럼만을 조회할 때
SELECT name, email FROM author where id = 3;

-- 중복제거하고 조회하기
-- 중복 만들기
UPDATE post SET title = 'super-hamster' WHERE title = 'super-hamster2'; --title 중복 생성
SELECT distinct title FROM post; --중복제거
SELECT title FROM post; -- 중복제거X

-- 정렬 : group by, 데이터의 출력결과를 특정 기준으로 정렬
-- 아무런 정렬조건 없이 조회할 경우에는 PK기준으로 오름차순 정렬이다.
-- asc : 오름차순, desc : 내림차순
SELECT * FROM author ORDER BY name ASC; -- 내림차순 DESC

-- 멀티 order by : 여러 컬럼으로 정렬, 먼저 쓴 컬럼 우선 정렬. 중복 시, 그 다음 정렬옵션 적용
SELECT * FROM post ORDER BY title; --asc/desc 생략하면 오름차순
SELECT * FROM post ORDER BY title, id DESC;

-- limit number : 특정숫자로 결과값 개수 제한
SELECT * FROM author ORDER BY id DESC LIMIT 1;

-- alias(별칭)을 이용한 SELECT : AS 키워드 사용
SELECT name AS 이름, email AS 이메일 FROM author;
SELECT a.name as 이름, a.email as 이메일 from author as a; -- 테이블이 하나일때는 생략가능

-- nulll을 조회조건으로
SELECT * FROM post WHERE author_id IS NULL; --비어있는 것만 조회하겠다.
SELECT * FROM post WHERE author_id IS NOT NULL; --비어있지 않은 것만 조회하겠다.






