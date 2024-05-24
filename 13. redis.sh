# 우분투에서 redis 설치
sudo apt-get update
sudo apt-get install redis-server
redis-server --version

# 레디스 접속
# cli : command line interface 프로그램과 상호작용할 수 있는 툴 
redis-cli

# 레디스 나가기
exit

# redis는 0~15번까지의 database 구성
# 데이터베이스 선택 (default : 0번) 
select 번호 # DB 번호 선택 - select 0

# 모든것이 key와 value로 이루어짐
# 모든 키를 조회하는 명령어
# 데이터베이스 내 모든 키 조회
keys *

# key 추가
# 일반 string 자료구조
# key:value 값 세팅
# key값은 중복되면 안됨 
SET key(키) value(값)
set test_key1 test_value1

# key를 통해서 value(값)을 얻음
# get을 통해 value값 얻기 --굉장히 빠르다
get test_key1

# 사용자 이메일이 세팅되어있다고 가정
set user:email:1 "hongildong@naver.com" # 1번 user의 email은 hongildong@naver.com 이다.
# -> 덮어쓰고 싶으면 
set user:email:1 "hongildong2@naver.com"

# set할때 key값이 이미 존재하면 덮어쓰기 되는 것이 기본
# map 저장소에서 key값은 유일하게 관리가 되므로 
# nx : not exist (해당 key가 없을때만 set한다.)
set user:email:1 "hongildong2@naver.com" nx # nx를 붙이면 덮어씌워지지 않음(not exist일때만 set됨)

# ex(만료시간-초단위) - ttl(time to live)
set user:email:2 hong2@naver.com ex 20

# 특정 key 삭제
del user:email:1

# 현재 DB에 모든 key값 삭제
flushdb

# 좋아요 기능 구현
select likes from posting where email = "ronaldo" for update; # 배타lock
update posting set likes = likes + 1 where ..;

# redis  : 싱글스레드 && 인메모리기반(성능)
set likes:posting:1 0 # 포스팅아이디1번에 대한 좋아요
incr likes:posting:1 # 특정 key값의 value를 1만큼 증가 (incr : increment증가)

# decr : 1 감소
decr likes:posting:1
get likes:posting:1 

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock

# bash 쉘을 활용하여 재고감소 프로그램 작성

