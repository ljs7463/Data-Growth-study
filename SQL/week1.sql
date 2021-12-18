-- 1. Dvd 렌탈 업체의 dvd대여가 있었던 날짜를 확인해주세요.
-- 날짜는 중복이 되기때문에 "distinct"를 반드시 넣어주어야 하며, 시간을 추출하는 "date" 함수 역시 실제로 많이 활용된다.
select distinct(date(rental_date)) from rental;



-- 2. 영화길이가 120분 이상이면서, 대여기간이 4일 이상이 가능한, 영화제목을 알려주세요.
-- 비교연산자를 넣어서 조건을 완성해 주면 된다.
select title from film 
where length >=120 and rental_duration >= 4;

-- 3. 직원의 id가 2번인 직원의 id, 이름, 성을 알려주세요
-- where 조건문을 사용하는 간단한 문제이다.
select staff_id, first_name, last_name   from staff 
where staff_id  = 2;

-- 4. 지불 내역 중에서, 지불 내역번호가 17510에 해당하는, 고객의 지출 내역(amount)는 얼마인가요?
-- where 조건문을 사용하는 간단한 문제이다.
select amount from payment 
where payment_id = 17510;

-- 5. 영화 카테고리 중에서, Sci-fi 카테고리의 카테고리 번호는 몇번인가요?
-- where 조건문을 사용하는 간단한 문제이다.
select category_id from category 
where name = 'Sci-Fi';

-- 6. Film 테이블을 활용하여, rating 등급(?) 에 대해서, 몇개의 등급이 있는지 확인해보세요.
-- ratig에 distinct를 사용하여 unique한 값을 불러와서 count함수를 사용하여 갯수를 구할 수 있다.
select count(distinct(rating)) from film;

-- 7. 대여 기간이 (회수 - 대여일) 10일 이상이였던 rental 테이블에 대한 모든 정보를 알려주세요.(단, 대여기간은 대여일자부터 대여기간으로 포함하여 계산합니다.)
-- date함수를 사용할 "년-월-일" 로 변경해주고 연산을 하면되는 단수 조건문 활용문제이다. 주의할점은 대여일자를 포함해야하 때문에 "+1일" 을 해주어야한다.
select * from rental 
where date(return_date) - date(rental_date) + 1  >= 10

-- 8. 고객의 id가 50, 100, 150..등 50번의 배수에 해당하는 고객들에 대해서, 회원 가입 감사 이벤트를 진행하려고 합니다. 고객 아이디가 50번 배수인 아이디와, 고객의 이름(성, 이름)과 이메일에 대해서 확인해주세요.
-- mod함수를 통해 50의배수 -> 50으로 나누었을때 나머지가 0인경우 로 생각해서 풀수있는 간단한 문제이다.
select customer_id, first_name, last_name, email  from customer 
where mod(customer_id,50) =0;

-- 9. 영화 제목의 길이가 8글자인, 영화 제목 리스트를 나열해 주세요.
-- length 함수를 통해서 선택한 필드내 각 레코드의 길이를 조회할 수 있다.
select title from film 
where length(title) =8;

-- 10. City 테이블의 city 갯수는 몇개인가요?
select count(city) from city;
-- null값을 제외할 경우 -> "where city is not null" 를 추가해준다.







