-- not null 조건 추가
ALTER TABLE 테이블명 MODIFY column 컬럼명 타입 NOT NULL;

-- auto_increment
ALTER TABLE author modify column id bigint auto_increment; -- 오류 발생
alter table post modify column id bigint auto_increment;  

-- author.id에 제약조건 추가시 fk로 인해 문제 발생시
-- fk먼저 제거 이후에 author.id에 제약조건 추가
select * from information_schema.key_column_usage where table_name = 'post';

-- fk 제약조건 삭제
alter table post drop foreign key post_ibfk_1;
alter table author modify column id bigint auto_increment;
describe author;

alter table post modify column author_id bigint;

-- 삭제된 제약조건 추가
alter table post add CONSTRAINT post_author_fk foreign key(author_id) REFERENCES author(id);

-- post 글 삭제해서 삭제되지 않으면 제약조건이 걸린 것을 확인할 수 있음.
DELETE from post where id = 2;

-- auto_increment 테스트 (id 넣지않고 insert)
insert into author (email,role) values ('hihi@avc.com','admin'); --id 값을 넣지 않고 그 다음 순서로 입력된 것 확인

-- UUID(유효ID)
ALTER TABLE post add column user_id char(36) default(UUID()); --UUID()함수 지원
INSERT INTO post(title) values ('abc');
select * from post; --확인

-- UNIQUE 제약조건
ALTER TABLE author modify column email varchar(255) UNIQUE; 
show index from author;

-- ON DELETE CASCADE 테스트 -> 부모테이블의 id를 수정하면 -> 수정안됨
-- 제약 조건 drop
alter table post drop foreign key post_author_fk;

-- on delete cascade다시 추가
alter table post add CONSTRAINT post_author_fk foreign key(author_id) REFERENCES author(id) on delete cascade;

-- 제약 조건 drop
alter table post drop foreign key post_author_fk;

-- on update cascade 다시 추가 
alter table post add CONSTRAINT post_author_fk foreign key(author_id) REFERENCES author(id) on update cascade;

select * from post;

-- (실습) delete는 set null, update cascade
alter table post drop foreign key post_author_fk; -- 제약 조건 삭제 후
alter table post add CONSTRAINT post_author_fk foreign key (author_id) REFERENCES author(id) on delete set null; -- ON DELETE SET NULL조건설정

alter table post drop foreign key post_author_fk; -- 제약 조건 삭제 후
alter table post add CONSTRAINT post_author_fk foreign key (author_id) REFERENCES author(id) on update CASCADE; -- ON UPDATE CASCADE 조건설정


