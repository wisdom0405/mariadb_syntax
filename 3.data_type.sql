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