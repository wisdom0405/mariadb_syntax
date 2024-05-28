# !/bin/bash

# 200번 반복하면서 재고 확인 및 감소
for i in {1..200}; do
    quantity=$(redis-cli -h localhost -p 6379 get apple:1:quantity)
    if [ "$quantity" -lt 1 ]; then
        echo "재고가 부족합니다. 현재재고 $quantity"
        break;
    fi

    # 재고감소
    redis-cli -h localhost -p 6379 decr apple:1:quantity
    echo "현재재고 : $quantity"
done

# redis 캐싱기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id = 1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\" : \"hong\", \"email\" : \"hong@naver.com\", \"age\":30}" ex 10 #ex : 10초, \ : escape문
get user detail # detail 조회

# list
# redis의 list는 java의 deque와 같은 구조 
# 즉, double-ended queue 구조

# RPUSH(right push), LPOP(left pop)
# 데이터 왼쪽 삽입 (LPUSH)
LPUSH [key][value] #  대괄호 안에 key값, value값 입력

# 데이터 오른쪽 삽입
RPUSH key value

# 데이터 왼쪽부터 꺼내기
LPOP key

# 데이터 오른쪽부터 꺼내기
RPOP key

# 어떤목적으로 사용될 수 있을까? : 최근 본 상품목록, 최근 방문한 페이지(RPUSH -> RPOP)
# 시간순서대로 데이터 삽입, 원하는대로 데이터 추출
LPUSH hongildongs hong1
LPUSH hongildongs hong2
LPUSH hongildongs hong3

# 꺼내서 없애는게 아니라, 꺼내서 보기만
lrange hongildongs -1 -1
lrange hongildongs 0 0

# =lpop 하면 hong3이 나온다
lpop hongildongs

# 데이터 개수 조회
llen key
llen hongildongs

# 리스트의 요소 조회시에는 범위지정을 해줘야 함
lrange hongildongs 0 -1 # 처음부터 끝까지

# range 지정
lrange hongildongs start end
lrange hongildongs 1 2 # 1~2 까지

# ttl 적용(time to live) : ex(expire)
expire hongildongs 20

# ttl  조회
ttl hongildongs

# pop과 push 동시에
# A리스트에서 POP 해서 B 리스트에 PUSH
RPOPLPUSH A리스트 B리스트 

# 최근 방문한 페이지
# 5개 정도 데이터 push
# 최근방문한 페이지 3개 정도만 보여주는 
rpush mypages www.google.com
rpush mypages www.naver.com
rpush mypages www.google.com
rpush mypages www.daum.com
rpush mypages www.naver.com
rpop mypages
rpop mypages
rpop mypages

# rpop사용해도 되나 lrange 사용가능
lrange mypages 2 -1

# 위 방문페이지를 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로가기 누르면 앞으로간 페이지가 뭔지 출력
rpush mypages www.google.com
rpush mypages www.naver.com
rpush mypages www.google.com
rpush mypages www.daum.com
rpush mypages www.naver.com

rpoplpush mypages pages # mypages 에서 rpop해서 pages에 lpush
rpop mypages # 뒤로가기
lpop pages # 다시 앞으로 가기

rpush forwards www.google.com
rpush forwards www.naver.com
rpush forwards www.yahoo.com
rpush forwards www.daum.net
lrange forwards -1 -1

rpoplpush backward # forward에서 꺼내소 backwoard에 넣어줌
# 방문한 페이지 =>


rpush 사과
rpush 배
rpush 사과
rpop 
rpop
# 중복제거 && 순서 => set 중에 tree set
# list를 써서는 최근 방문한 페이지를 구현하는데는 문제가 있을 수 있음

# 최근 본 상품목록 => sorted set(zset)을 활용하는 것이 적절

# set 자료구조
# set 자료구조에 멤버추가
sadd members member1
sadd members member2
sadd members member3

# set 조회
smembers memebers

# set에서 member 삭제
srem members member2

# set멤버 개수 반환
scard members

# 특정 멤버가 set안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
sadd visit:2024-05-27 hong1@naver.com

# zset(sorted set)
zadd zmembers 3 member1 
zadd zmembers 4 member2 
zadd zmembers 1 member3 
zadd zmembers 2 member4

# score 기준 오름차순 정렬
zrange zmembers 0 -1

# score 기준 내림차순 정렬
zrevrange zmemebers 0 -1

# 최근 본 상품 목록 : 조회한 시간 초로 환산
# 리스트 사용 -> 중복이 제거안됨
# zset -> 중복이 제거, score통해서 기준

# 최근 본 상품 목록 => sorted set(zset)을 활용하는 것이 적절
# 조회한 시간을 초로 환산해야 중복이 없음
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192420 orange
zadd recent:products 192425 apple
zadd recent:products 192430 apple

zrerange recent:products 0 2

# zset 삭제
zrem zmemebers member2
# zrank : 해당멤버가 index 몇번째인지 출력한다.
zrank zmemebers member2

# 











