-- dirty read 실습(commit 안한 것이 읽히는 문제)
-- 워크벤치에서 auto_commit 해제 후 update 실행 -> commit이 아직 안된 상태 --> 워크벤치에서는 임시저장되어 있기 때문에 확인 됨
-- 터미널을 열어서 select 했을 때(다른 트랜잭션 생성된 것) 위 변경사항이 변경됐는지 확인 --> 확인 안됨

-- phantom read 동시성 이슈 실습
-- 워크벤치에서 시간을 두고 2번의 select 가 이루어지고
-- 터미널에서 중간에 insert 실행 -> 2번의 select 결과값이 동일한지 확인
START TRANSACTION;
SELECT count(*) FROM author;
do sleep(15);
select * from author;
commit;

-- 터미널에서 아래 insert 문 실행
insert into author(name, email) values('kim', 'kim@naver.com');

-- lost update 이슈를 해결하기 위한 공유락(shared lock)
-- workbench에서 아래 코드 실행
start transaction;
select post_count from author where id = 1 lock in share mode;
do sleep(15);
select post_count from author where id = 1 lock in share mode;
commit;


-- 터미널에서 실행
select post_count from author where id=1 lock in share mode;
update author set post_count=0 where id=1;


-- 배타적 잠금(exclusive lock):select for update
-- select 부터 lock
start transaction;
select post_count from author where id = 1 lock for update;
do sleep(15);
select post_count from author where id = 1 lock for update;
commit;

-- 터미널에서 실행
select post_count from author where id=1 lock for update;
update author set post_count=0 where id=1;