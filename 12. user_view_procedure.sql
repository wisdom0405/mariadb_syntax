-- 사용자관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
-- %는 원격 포함한 anywhere 접속
create user 'test1'@'localhost' identified by '4321'; --@: 원격허용

-- 사용자 삭제
drop user 'test1'@'localhost';
-- 사용자에게 권한부여
grant select on board.author to 'test1'@'localhost';

-- test1으로 로그인 후에 
select * from board.author;

-- 사용자 권한 회수
revoke select on board.author from 'test1'@'localhost';

-- 환경설정을 변경 후 확정
flush privileges;

-- test1으로 로그인 후에
select * from board.author;

-- 권한 조회
show grants for 'test1'@'loacalhost';

-- 사용자 계정 삭제
drop user 'test1'@'localhost';

-- view 생성
create view author_for_marketing_team as
select name, age, role from author;

-- view 조회
select * from author_for_marketing_team;

-- view에 권한부여
-- test1 계정에 view select 권한부여
grant select on board.author_for_marketing_team to 'test1'@'localhost';

-- 환경설정을 변경 후 확정
flush privileges;

-- test1 계정 로그인 후 view 조회
select * from board.author_for_marketing_team;

-- view 변경(대체)
create or replace view author_for_marketing_team as 
select name, email, age, role from author;

-- view 삭제
drop view author_for_marketing_team;

-- 프로시저 생성 (프로시저명 한글지정 가능)
DELIMITER //
CREATE PROCEDURE test_procedure()
BEGIN
    select 'Hello world!';
END
// DELIMITER;

-- 프로시저 호출
call test_procedure();

-- 프로시저 삭제
drop procedure test_procedure;

-- 프로시저 생성 (프로시저명 한글지정 가능)
DELIMITER //
CREATE PROCEDURE 게시글목록조회()
BEGIN
    select * from post;
END
// DELIMITER ;

-- 프로시저 호출
call 게시글목록조회();

-- 게시글 1건 조회
DELIMITER //
CREATE PROCEDURE 게시글단건조회(in 아이디 int)
BEGIN
    select * from post where id = 아이디;
END
// DELIMITER ;

-- 프로시저 호출
call 게시글단건조회(3);

-- 글쓰기 : title, contents, 저자id
DELIMITER //
CREATE PROCEDURE 글쓰기(in 제목 varchar(255), in 내용 varchar(255), in 저자id int)
BEGIN
    INSERT INTO post(
    title,
    contents,
    author_id
) VALUES(
    제목,
    내용,
    저자id
); 
END
// DELIMITER ;

-- 프로시저 호출
call 글쓰기('today','is hard day',1);

-- 글쓰기 : title, contents, 저자id
DELIMITER //
CREATE PROCEDURE 글쓰기(in title varchar(255), in contents varchar(255), in authorId int)
BEGIN
    INSERT INTO post(
    title,
    contents,
    author_id
) VALUES(
    title,
    contents,
    authorId
); 
END
// DELIMITER ;

-- 글쓰기2 : title, contents, email
DELIMITER //
CREATE PROCEDURE 글쓰기2(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255))
BEGIN
    declare authorId int; -- 변수선언
    select id into authorId from author where email = emailInput;
    INSERT INTO post(
    title,
    contents,
    author_id
) VALUES(
    titleInput,
    contentsInput,
    authorId
); 
END
// DELIMITER ;

-- 프로시저 호출
DELIMITER //
CREATE PROCEDURE 글 상세조회(in postId int)
BEGIN
    declare authorName varchar(255); -- 변수선언
    select name into authorName from author where id = (select author_id from post where author_id = postId);
    set authorName = concat(authorName,'님');
    select title, contents, authorName from post where id = postId;
 
END
// DELIMITER ;

-- 등급조회
-- 글을 100개 이상 쓴 사용자는 고수입니다. 출력
-- 10개 이상 100개 미만 : 중수입니다.
-- 그외에는 초수입니다.
-- email 입력 -> 고수,중수,초수인지 출력
-- 프로시저 호출
CREATE PROCEDURE 등급조회(in email_input varchar(255))
BEGIN
    declare authorId int; --글쓴이 아이디
    declare count int; 
    select id into authorId from author where email = email_input;
    select count(*) into count from post where author_id = authorId;
    if count >= 100 then
        then select '고수입니다';
    elseif count  >= 10 and count < 100 
        then select '중수입니다';
    else
        select '초수입니다';
    end if;
END
// DELIMITER ;

-- 프로시저 호출
call 등급조회('wisdom@naver.com');

-- 반복문을 통해 post 대량생성
-- 사용자가 입력한 반복 횟수에 따라 글이 도배되는데, 타이틀은 '안녕하세요'
-- 프로시저 호출
DELIMITER //
CREATE PROCEDURE 글도배(in count int)
BEGIN
    declare countValue int default 0;
    while countValue < count DO
        insert into post(title) values ('안녕하세요');
        set countValue = countValue + 1;
END
// DELIMITER ;

show create procedure 프로시저명;

-- 프로시저 권한 부여
grant excute on board.글도배 to 'test1'@'localhost';