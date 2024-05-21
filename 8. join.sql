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

-- 조건에 맞는 도서와 저자 리스트 출력

-- union : 중복제외한 두 테이블의 select문을 결합
-- 컬럼의 개수와 타입이 같아야함에 유의
-- union all : 중복포함
select 컬럼1, 컬럼2 from table1 union select 컬럼1, 컬럼2 from table2;

-- author 테이블의 name, email 그리고 post 테이블의 title, contents, union
selecct name, email from author union select title, contents from post;

-- 유지보수성 : 서비스를 유지하고, 서비스를 고치고 
-- 코드의 간결성과 직관성이 있어야 함

-- 서브쿼리: select문 안에 또다른 select문을 서브쿼리라고 한다.
-- select절 안에 서브쿼리
-- author email과 해당 author가 쓴 글이 개수를 출력
select email, (select count(*) from post p where p.author_id = a.id) as count
    from author a;

-- from절 안에 서브쿼리
select a.name from (select * from author) as a;

-- where절 안에 서브쿼리
select a.* from author a inner join post p on a.id = p.author_id;
select * from author a where a.id in (select p.author_id from post p);

-- 프로그래머스 없어진 기록 찾기 문제 : join으로 풀 수 있는 문제, subquery 로도 풀어보면 좋을 것
-- LEFT JOIN 이용
SELECT O.ANIMAL_ID, O.NAME 
    FROM ANIMAL_OUTS O LEFT JOIN ANIMAL_INS I
    ON O.ANIMAL_ID = I.ANIMAL_ID
    WHERE I.ANIMAL_ID IS NULL 
    ORDER BY O.ANIMAL_ID;

-- 서브쿼리 이용
SELECT O.ANIMAL_ID, O.NAME 
    FROM ANIMAL_OUTS O 
    WHERE O.ANIMAL_ID NOT IN (SELECT I.ANIMAL_ID FROM ANIMAL_INS I);

-- 집계함수
SELECT COUNT(*) FROM AUTHOR;
SELECT sum(price) from post;
select rount(avg(price),0) from post;

--group by와 집계함수
select title from post group by author_id;
select author_id, count(*) from post group by author_id;
select author_id, count(*), sum(price), max(price) from post group by author_id; 

-- 저자 email, 해당 저자가 작성한 글 수를 출력
select a.id, if(p.id is null, 0, count(*)) 
from author a left join post p 
on a.id = p.author_id 
group by a.id; 

-- where와 group by
-- 연도별 post 글 출력, 연도가 null인 데이터는 제외(where 조건)
select 연도, count(*) from where xxxx group by 연도;

select date_format(created_time, "%Y") as year, count(*) as count
from post
where created_time is not null 
group by year; -- year alias를 group by 변수로도 사용가능

-- 프로그래머스 : 자동차 종류 별 특정 옵션이 포함된 자동차 수 구하기
SELECT CAR_TYPE, COUNT(*) AS CARS 
FROM CAR_RENTAL_COMPANY_CAR
WHERE OPTIONS LIKE '%통풍시트%' OR OPTIONS LIKE '%열선시트%' OR OPTIONS LIKE '%가죽시트%'
GROUP BY CAR_TYPE
ORDER BY CAR_TYPE;

-- 프로그래머스 문제 : 입양 시각 구하기
SELECT date_format(DATETIME, "%H") AS HOUR, COUNT(*)  -- 한자리수로 출력 : 9시 (CAST 사용 unsigned 사요하여 문자 -> 숫자 형 변환)
FROM ANIMAL_OUTS
WHERE date_format(DATETIME, "%H:%i") between '09:00' and '19:59'
GROUP BY HOUR
ORDER BY HOUR;

SELECT cast(date_format(DATETIME, "%k")as unsigned)AS HOUR, COUNT(*) -- 두자리수로 출력 : 09시
FROM ANIMAL_OUTS
WHERE date_format(DATETIME, "%H:%i") between '09:00' and '19:59'
GROUP BY HOUR
ORDER BY HOUR;

-- HAVING : group by를 통해 나온 통계에 대한 조건
select author_id, count(*) from post group by author_id;

-- 글을 2개이상 쓴 사람에 대한 통계정보
SELECT author_id, count(*) as count from post
group by author_id having count >= 2; 

-- (실습) 포스팅 price가 2000원 이상인 글을 
-- 작성자별로 몇건인지와 평균 price를 구하되, 
-- 평균 price가 3000원 이상인 데이터를 대상으로만 통계 출력
SELECT author_id, COUNT(*) AS COUNT, AVG(price) as avg_price
from post
where price >= 2000
group by author_id
having avg_price >= 3000
order by avg_price;

select author_id, avg(price) as avg_price 
from post
where price >= 2000
group by author_id 
having avg_price >= 3000;

-- 프로그래머스 : 동명 동물 수 찾기
SELECT NAME, COUNT(*) AS COUNT
FROM ANIMAL_INS
WHERE NAME IS NOT NULL
GROUP BY NAME
HAVING COUNT(NAME) >= 2
ORDER BY NAME ASC;

-- (실습)2건 이상의 글을 쓴 사람의 id와 email, 글의 수(count) 구할건데,
-- 나이는 25세 이상인 사람만 통계에 사용하고, 
-- 가장 나이 많은 사람 1명의 통계만 출력하시오.

select a.id, count(a.id)as count, a.email, a.age 
from author a inner join post p
on a.id = p.author_id
where a.age >= 25
group by a.id
having count >= 2 
order by a.age desc limit 1;

select a.id, count(a.id) as count 
from author a inner join post p 
on a.id = p.author_id
where a.age >= 25
group by a.id 
having count >= 2 and max(a.age) DESC LIMIT 1;

-- 다중열 group by
select author_id, title, count(*) 
from post 
group by author_id, title;

-- 프로그래머스 : 재구매가 일어난 상품과 회원 리스트 구하기
-- 이중 GROUP BY 사용
SELECT USER_ID, PRODUCT_ID
FROM ONLINE_SALE 
GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(PRODUCT_ID) >= 2 AND COUNT(USER_ID) >= 2
ORDER BY USER_ID ASC, PRODUCT_ID DESC;

SELECT USER_ID, PRODUCT_ID
FROM ONLINE_SALE 
GROUP BY USER_ID, PRODUCT_ID
HAVING COUNT(*) >= 2 
ORDER BY USER_ID ASC, PRODUCT_ID DESC;