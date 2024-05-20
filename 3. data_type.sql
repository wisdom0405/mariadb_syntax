-- tinyint는-128 ~ 127까지 표현
-- author테이블에 age컬럼 추가
ALTER TABLE author ADD column age tinyint;

-- insert시에 age :  200 -> 125
INSERT INTO author(id, email, age) VALUES (5,'wisdom5@naver.com', 130);
INSERT INTO author(id, email, age) VALUES (5,'wisdom5@naver.com', 125);
alter table author modify column age tinyint unsigned;
insert into author(id, email, age) VALUES (6, 'hello@naver.com',200);

--unsigned 시에 255까지 표현범위 확대
alter table author modify column age tinyint unsigned;
insert into author(id, email, age) values(6, 'hello@naver.com', 200);

-- decimal 실습
-- 소수점은 이진법으로 표현하기 어려움 -> 근사치만 표현가능 
-- 정확한 소수점 표현을 위해서 bigdecimal 사용(java)
alter table post add column price decimal(10,3);
describe post;

-- decimal 소수점 초과 값 입력 후 짤림 확인
insert into post(int, title, price) values (6, 'hello', 3.1212112121);

--update : price를 123.1;
update post set price=1234.1 where id = 6;

-- blob 바이너리 데이터 실습
-- author테이블에 profile_image 컬럼을 blob형식으로추가 (ALTER)
-- 
alter table author add column profile_image longblob;
describe author;

alter table author modify column profile_image longblob;

insert into author(id, email, profile_image) values (7,'morucar@naver.com', LOAD_FILE('C:\morucar.jpg'));

-- enum : 삽입될 수 있는 데이터 종류를 한정하는 데이터 타입
-- role 컬럼
alter table author add column role enum('user',  'admin') not null;
alter table author modify column role enum('user',  'admin') not null default 'user'; -- default값  : user (수정했으므로 add->modify)


-- enum 컬럼 실습 테스트
-- user1을 insert -> 에러
insert into author (id, email, role) values (8, 'hamster@naver.com', 'user1'); -- enum에서 정의하지 않은 데이터가 들어가면 오류발생
-- user 또는 admin insert -> 정상처리
insert into author (id, email, role) values (8, 'hamster@naver.com', 'user');

-- author 테이블 : 생년월일, 가입일시(가입일, 시간만 꺼내쓰기 가능)
-- date 타입
-- author 테이블에 birth_day 컬럼을 date로 추가
-- 날짜 타입의 insert는 문자열 형식으로 insert
ALTER TABLE author add column birth_day date;
insert into author(id, email, birth_day) values (9, 'hello@abc.com','1999-04-05');

-- datetime 타입
-- author, post 둘다 datetime으로 created_time 컬럼추가
ALTER TABLE author add column created_time datetime;
ALTER TABLE post add column created_time datetime;

INSERT INTO author (id, name, created_time) VALUES (10, 'hi', '1999-01-01 12:11:11');
INSERT INTO post (id, title, created_time) VALUES (5, 'hi', '1999-01-01 12:11:11');

-- default옵션으로 시간 자동 생성
ALTER TABLE author modify column created_time datetime default current_timestamp;
INSERT INTO author (id, email, role) VALUES (11, 'hii@avc.com', 'user');
select * from author;

ALTER TABLE post modify column created_time datetime default current_timestamp;
INSERT INTO post (id, title) VALUES (7, 'hii');
select * from post;

-- create_time 확인
select created_time from author;

-- 비교연산자
-- and 또는 &&
select * from post where id >=2 and id <=4;
select * from post where id between 2 and 4; --똑같은 용도로 사용한다.

-- id < 2 거나 id > 4
-- or 또는 ||
-- NOT 또는 |
select * from post where id < 2 or id > 4;
select * from post where not(id < 2 or id > 4);
select * from post where !(id < 2 or id > 4);

-- NULL인지 아닌지
SELECT * FROM post WHERE contents is null;
SELECT * FROM post WHERE contents is not null;

-- in(리스트형태), not in(리스트 형태)
select * from post where id in(1,2,3,4);
select * from post where id not in(1,2,3,4);

-- LIKE : 특정 문자를 포함하는 데이터를 조회하기 위해 사용하는 키워드
SELECT * FROM post where title like "h%";
select * from post where title like "w%"; 

select * from post where title like "%llo%"; -- 단어의 중간에 llo라는 키워드가 있는 경우
select * from post where title not like "%o";  --o로 끝나지 않는 title 검색

-- ifnull(a,b) : 만약에 a가 null이면 b반환, null이 아니면 a반환
select title, contents, ifnull(author_id, '익명')as writer from post;

-- 프로그래머스 SQL : 경기도에 위치한 식품창고 목록 출력하기
SELECT WAREHOUSE_ID, WAREHOUSE_NAME, ADDRESS, IFNULL(FREEZER_YN, 'N') FROM FOOD_WAREHOUSE WHERE ADDRESS LIKE "경기도%";

-- REGEXP : 정규표현식을 활용한 조회
SELECT * FROM author WHERE name REGEXP '[a-z]'; --알파벳을 만족하는 name을 조회
SELECT * FROM author WHERE name REGEXP '[가-힣]'; -- 한글을 만족하는 name을 조회

-- 날짜변환 : 숫자 -> 날짜, 문자 -> 날짜타입
-- CAST와 CONVERT
SELECT CAST(20100101 AS DATE); -- 형식변환하여 사용자화면에 뿌려줌 (테이블에서 조회하는 것 아님)
SELECT CAST('20200101' AS DATE);

SELECT CONVERT(20100101, DATE);
SELECT CONVERT('20200101', DATE);

--datetime 조회 방법
SELECT * FROM post WHERE created_time LIKE '2024-05%';

-- datetime 조회 방법
select * from post where created_time like'2024-05%';
select * from post where created_time >= '1999' and created_time <='2024';
select * from author where created_time between '1999-01-01' and '2024-12-31';

-- date_format을 이용하여 원하는 형태로 출력
-- Y(연도), m(월), d(일)
select date_format(created_time, '%Y-%m') from author;

--date_format 실습. date_format()을 이용하여 created_time이 2024년도인 데이터 검색
select * from author where date_format(created_time, '%Y')='2024';

-- 현재 시간
select now();
select date_format(now(), '%Y');

-- 오늘날짜
SELECT now();

