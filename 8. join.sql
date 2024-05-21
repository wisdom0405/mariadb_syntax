-- inner join
-- 위 테이블 사이에 지정된 조건에 맞는 레코드만 반환. on 조건을 통해 교집합 찾기
-- 글 중에 글쓴이가 있는 있ㄴ는 사람을 고르고, 글에 글쓴이 데이터를 합한 테이블 생성
select * from post inner join author on author.id = post.author_id;

select * from author a inner join post p on a.id = p.author_id; -- alias 사용

-- 글쓴이가 있는 글 목록과 글쓴이의 이메일을 출력하시오.
select p.id, p.title, p.contents from post p inner join author a on p.author_id = a.id; -- 익명글은 다 날라갔다.

-- 모든 글목록을 출력하고, 만약에 글쓴이가 있다면 이메일을 출력
-- on 조건에 상관없이 왼쪽에 있는 테이블에 있는 데이터는 무조건 다 나온다
select p.id, p.title, p.contents, a.email 
    from post p left outer join author a
    on p.author_id = a.id; --  post는 다 나옴.

-- ex) author와 post를 inner 조인하면 글을 작성한 적이 있는 author와 해당 author가 작성한 post정보를 결합하여 조회

-- ex) post와 author를 inner 조인하면 저자가 있는 글과 해당 저자의 정보를 결합하여 한 테이블로 생성하여 조회
selecct p.title, a.email from author a inner join post p on a.id = p.author_id;
selecct p.title, a.email from post p inner join author a on a.id = p.author_id;
-- => 같은 의미의 쿼리

-- join된 상황에서의 where 조건 : on 뒤에 where 조건이 나옴
-- 1) 글쓴이가 있는 글 중에 글의 title과 저자의 email을 출력, 저자의 나이는 25세 이상
select p.title, a.email, a.age from author a inner join post p on a.id = p.author_id where a.age >= 25;

-- 2) 모든 글 목록 중에 글의 title과 저자가 있다면 email을 출력, 2024-05-01 이후에 만들어진 글만 출력
 select p.title, ifnull(a.email, '익명')as '저자' 
    from post p left join author a 
    on a.id = p.author_id 
    where p.title is not null and p.created_time >= '2024-05-01';

-- 프로그래머스 : 조건에맞는 도서와 저자 리스트 출력
SELECT B.BOOK_ID, A.AUTHOR_NAME, 
    DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE
    FROM BOOK B INNER JOIN AUTHOR A
    ON B.AUTHOR_ID = A.AUTHOR_ID
    WHERE B.CATEGORY = '경제'
    ORDER BY B.PUBLISHED_DATE ASC;









