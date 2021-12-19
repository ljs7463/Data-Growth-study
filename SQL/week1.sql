-- < 실습문제 1 >
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

-- 11. 영화배우의 이름 (이름+' '+성) 에 대해서,  대문자로 이름을 보여주세요.  단 고객의 이름이 동일한 사람이 있다면,  중복 제거하고, 알려주세요.
-- upper 함수를 통해서 대문자로 변경할 수 있다.
select distinct(upper(first_name||''||last_name))
from actor;

-- 12	고객 중에서,  active 상태가 0 인 즉 현재 사용하지 않고 있는 고객의 수를 알려주세요.
-- 간단한 조건문을 사용하여 조회하는 문제이다.
select count(customer_id) from customer 
where active =0;

-- 13	Customer 테이블을 활용하여,  store_id = 1 에 매핑된  고객의 수는 몇명인지 확인해보세요.
-- 간단한 조건문을 사용하여 조회하는 문제이다.
select count(customer_id) from customer 
where store_id =1;

-- 14	rental 테이블을 활용하여,  고객이 return 했던 날짜가 2005년6월20일에 해당했던 rental 의 갯수가 몇개였는지 확인해보세요.
-- date함수를 사용하여 날짜를 원하는 형태로 변경하는 문제이다.
select count(rental_id) from rental 
where date(return_date) = '2005-06-20' ;

-- 15	film 테이블을 활용하여, 2006년에 출시가 되고 rating 이 'G' 등급에 해당하며, 대여기간이 3일에 해당하는  것에 대한 film 테이블의 모든 컬럼을 알려주세요.
-- 비교연산자를 활용하여 여러가지 조건을 사용하는 문제이다.
select * from film
where release_year = 2006 and rating ='G' and rental_duration =3;

-- 16	langugage 테이블에 있는 id, name 컬럼을 확인해보세요 .
select language_id, name from language;  

-- 17	film 테이블을 활용하여,  rental_duration 이  7일 이상 대여가 가능한  film 에 대해서  film_id,   title,  description 컬럼을 확인해보세요.
select film_id, title, description from film
where rental_duration >=7;

-- 18	film 테이블을 활용하여,  rental_duration   대여가 가능한 일자가 3일 또는 5일에 해당하는  film_id,  title, desciption 을 확인해주세요.
-- 비교연산자를 활용하는 문제이다.
select film_id ,title, description from film
where rental_duration =3 or rental_duration  =5;

-- 19	Actor 테이블을 이용하여,  이름이 Nick 이거나  성이 Hunt 인  배우의  id 와  이름, 성을 확인해주세요.
-- 비교연산자를 활용하는 문제이다.
select * from actor
where first_name ='Nick' or last_name ='Hunt';

-- 20	Actor 테이블을 이용하여, Actor 테이블의  first_name 컬럼과 last_name 컬럼을 , firstname, lastname 으로 컬럼명을 바꿔서 보여주세요
-- as를 활용하 컬럼명을 원하는 형태로 만들수 있다.
select first_name as firstname, last_name as lastname from actor;


-- < 실습문제2 >
-- 1. film 테이블을 활용하여,  film 테이블의  100개의 row 만 확인해보세요.
select * from film
limit 100;

-- 2. actor 의 성(last_name) 이  Jo 로 시작하는 사람의 id 값이 가장 낮은 사람 한사람에 대하여, 사람의  id 값과  이름, 성 을 알려주세요.
select * from actor
where last_name like 'Jo%';

-- 3. film 테이블을 이용하여, film 테이블의 아이디값이 1~10 사이에 있는 모든 컬럼을 확인해주세요.
select * from film
where film_id >= 1 and film_id <= 10;

-- 4. country 테이블을 이용하여, country 이름이 A 로 시작하는 country 를 확인해주세요.
select * from country
where country like 'A%';

-- 5. country 테이블을 이용하여, country 이름이 s 로 끝나는 country 를 확인해주세요.
select * from country
where country like '%s';
 
-- 6. address 테이블을 이용하여, 우편번호(postal_code) 값이 77로 시작하는  주소에 대하여, address_id, address, district ,postal_code  컬럼을 확인해주세요.
select address_id, address, district ,postal_code from address
where postal_code like '77%';

-- 7. address 테이블을 이용하여, 우편번호(postal_code) 값이  두번째글자가 1인 우편번호의  address_id, address, district ,postal_code  컬럼을 확인해주세요.
select address_id, address, district ,postal_code from address
where postal_code like '_1%';

8. payment 테이블을 이용하여,  고객번호가 341에 해당 하는 사람이 결제를 2007년 2월 15~16일 사이에 한 모든 결제내역을 확인해주세요.

9. payment 테이블을 이용하여, 고객번호가 355에 해당 하는 사람의 결제 금액이 1~3원 사이에 해당하는 모든 결제 내역을 확인해주세요.

10. customer 테이블을 이용하여, 고객의 이름이 Maria, Lisa, Mike 에 해당하는 사람의 id, 이름, 성을 확인해주세요.

11. film 테이블을 이용하여,  film의 길이가  100~120 에 해당하거나 또는 rental 대여기간이 3~5일에 해당하는 film 의 모든 정보를 확인해주세요.

12. address 테이블을 이용하여, postal_code 값이  공백('') 이거나 35200, 17886 에 해당하는 address 에 모든 정보를 확인해주세요.

13. address 테이블을 이용하여,  address 의 상세주소(=address2) 값이  존재하지 않는 모든 데이터를 확인하여 주세요.

14. staff 테이블을 이용하여, staff 의  picture  사진의 값이 있는  직원의  id, 이름,성을 확인해주세요.  단 이름과 성을  하나의 컬럼으로 이름, 성의형태로  새로운 컬럼 name 컬럼으로 도출해주세요.

15. rental 테이블을 이용하여,  대여는했으나 아직 반납 기록이 없는 대여건의 모든 정보를 확인해주세요.

16. address 테이블을 이용하여, postal_code 값이  빈 값(NULL) 이거나 35200, 17886 에 해당하는 address 에 모든 정보를 확인해주세요.

17. 고객의 성에 John 이라는 단어가 들어가는, 고객의 이름과 성을 모두 찾아주세요.

18. 주소 테이블에서, address2 값이 null 값인 row 전체를 확인해볼까요?
