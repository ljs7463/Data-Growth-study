< 실습문제 3-6 >

--문제1번) 매출을 가장 많이 올린 dvd 고객 이름은? (subquery 활용)
select first_name , last_name 
from customer c
where c.customer_id in (
                        select p.customer_id from payment p 
                        group by p.customer_id 
                        order by sum(amount) desc   
                        limit 1
);

-- 문제2번) 대여가 한번도이라도 된 영화 카테 고리 이름을 알려주세요. (쿼리는, Exists조건을 이용하여 풀어봅시다)


-- 문제3번) 대여가 한번도이라도 된 영화 카테 고리 이름을 알려주세요. (쿼리는, Any 조건을 이용하여 풀어봅시다)


-- 문제4번) 대여가 가장 많이 진행된 카테고리는 무엇인가요? (Any, All 조건 중 하나를 사용하여 풀어봅시다)


-- 문제5번) dvd 대여를 제일 많이한 고객 이름은? (subquery 활용)

SELECT c.first_name, c.last_name 
from customer c
where customer_id in ( 
						select customer_id
						from payment p 
						group by customer_id 
						order by count(payment_id) desc
						limit 1
);


-- 문제6번) 영화 카테고리값이 존재하지 않는 영화가 있나요?
