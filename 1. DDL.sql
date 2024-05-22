-- 데이터베이스 접속
mariadb -u root -p

-- 스키마(database) 목록조회
show databases;

-- (스키마) database 생성
CREATE DATABASE board;

-- 데이터베이스 선택
USE board; -- Database changed

-- 테이블 조회
show tables;

-- author 테이블 생성
CREATE TABLE author(
    id INT PRIMARY KEY, 
    name VARCHAR(255), 
    email VARCHAR(255), 
    password VARCHAR(255)
    );

CREATE TABLE author(id INT PRIMARY KEY, name VARCHAR(255), email VARCHAR(255), password VARCHAR(255));

-- 테이블 컬럼조회
describe author;

-- 테이블 생성문 조회
show CREATE TABLE author;

-- 컬럼 상세 조회
show full columns from author;

-- post테이블 신규 생성 
CREATE TABLE posts(
    id INT PRIMARY KEY,
    title VARCHAR(255),
    content VARCHAR(255),
    author_id INT, 
    FOREIGN KEY(author_id) REFERENCES author(id) 
);

-- 테이블 index 조회
show index from author;
show index from posts;

-- ALTER 문 : 테이블의 구조를 변경
-- 테이블 이름 변경
ALTER TABLE posts RENAME post;

-- 테이블 컬럼 추가
ALTER TABLE author ADD column test1 VARCHAR(50);

-- 추가됐는지 확인
describe author;

-- 다시 테이블 컬럼 삭제
ALTER TABLE author DROP column test1;

-- 삭제됐는지 확인
describe author;

-- 테이블 컬럼명 변경

ALTER TABLE post change column content contents VARCHAR(255);  

-- 테이블 컬럼 타입과 제약조건 변경
ALTER TABLE author MODIFY COLUMN email VARCHAR(255) NOT NULL; -- 사실상 덮어쓰기

-- 실습1 : author 테이블에 address 컬럼 추가, varchar(255)
ALTER TABLE author ADD COLUMN address VARCHAR(255);

-- 실습2 : post 테이블에 title은 not null 제약조건 추가, contents 3000자로 변경
ALTER TABLE post MODIFY column title VARCHAR(255) NOT NULL;
ALTER TABLE post MODIFY column contents VARCHAR(3000);

-- 테이블 삭제
DROP TABLE 테이블명;

show create table post;

 CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
 );

DROP TABLE post; --post 테이블 삭제
describe post; -- 테이블 다시 생성 후 확인

INSERT INTO POST(id, title, contents, author_id) VALUES (2, 'super-nova','super-nova-nova', 2);





