# local 컴퓨터의 board DB-> 마이그레이션 ->  linux 이전
# linux에 DB 설치 -> 윈도우(local)에 dump 작업 후 sql 쿼리 생성 -> github에 upload -> git clone -> linux에서 해당 쿼리 실행 
# mysqldump -uroot -p board -r dumpfile.sql (한글 깨질 때 r옵션)
mysqldump -u root -p --default-character-set=utf8mb4 board > dumpfile.sql
