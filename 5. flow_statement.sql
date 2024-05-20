-- 흐름제어 : case문
SELECT 컬럼1, 컬럼2, 컬럼3;
CASE 컬럼4
    WHEN [비교값1] THEN 결과값1
    WHEN [비교값2] THEN 결과값2
    ELSE 결과값3
END
FROM 테이블명;

-- post테이블에서 1번 user는 first_author, 2번 user는 second_author 이라고 출력
select id, title, contents,
    case author_id
        when 1 then 'first_author'
        when 2 then 'second_author'
        else 'others'
    END as author_id
from post;

-- 프로그래머스 : 조건에 부합하는 중고거래 상태 조회하기
SELECT BOARD_ID, WRITER_ID, TITLE, PRICE, 
    CASE STATUS
        WHEN 'SALE' THEN '판매중'
        WHEN 'RESERVED' THEN '예약중'
        ELSE '거래완료'
    END as STATUS
FROM USED_GOODS_BOARD
WHERE CREATED_DATE =  '2022-10-05'
ORDER BY BOARD_ID DESC;

-- author id가 없으면 그대로 출력 else author_id, 
-- 없으면 '익명 사용자'로 출력되도록 post테이블 조회
select id, title, contents,
    case author_id
        when author_id is null then 'anonymous_author'
        else author_id
    END as anonymous_author
from post;

-- 위 case문을 ifnull 구문으로 변환
select id, title, contents,
    ifnull(author_id, 'anonymous_author') as anonymous_author
from post;

-- if는 구문으로 변환
select id, title, contents,
    if(author_id is null, 'anonymous', author_id) as anonymous_author
from post;

--프로그래머스 : 12세 이하인 여자 환자 목록 출력하기
SELECT PT_NAME, PT_NO, GEND_CD, AGE,
    IFNULL(TLNO, 'NONE') AS TLNO
FROM PATIENT
WHERE AGE < 13 AND GEND_CD = 'W'
ORDER BY AGE DESC, PT_NAME;
