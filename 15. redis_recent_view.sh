
while true; do
    # 사용자가 product를 입력할때마다, 현재시간을 score 해서 zadd
    echo "원하는 상품 입력 또는 나가기(exit)"
    read product
    if [ "$product" == "exit" ]; then
        echo "나갑니다"
        break
    fi
    timestamp = $(date +%s)
    redis-cli zadd recent:products $timestamp $product
done

echo "사용자의 최근 본 상품목록 5개: "
redis-cli zrevrange recent:products 0 4

# hashes
# 해당 자료구조에서는 문자, 숫자가 구분
hset product:1 name "apple" price 1000 stock 50
hget product:1 price 

# 모든 객체값 get
hgetall product:1

# 특정 요소값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가(increment by)
hincrby product:1 stock 5 # stock을 5만큼 증가시키겠다.
hget product:1 stock

# 특정 요소의 값을 감소
