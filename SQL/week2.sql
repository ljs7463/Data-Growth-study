-- < 실습 문제 2-3 >

-- 문제1번) 고객의 기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone 번호를 함께 보여주세요.

select customer_id, 
	first_name, 
	last_name,
	email,
	a.address,
	a.district,
	a.postal_code,
	a.phone 
from customer c 
inner join address a 
	on c.address_id = a.address_id; 

-- 문제2번) 고객의  기본 정보인, 고객 id, 이름, 성, 이메일과 함께 고객의 주소 address, district, postal_code, phone , city 를 함께 알려주세요.

select c.customer_id, c.first_name, c.last_name, c.email,  a.address, a.district, a.postal_code, a.phone, c2.city 
from customer c 
inner join address a 
	on c.address_id  =  a.address_id 
inner join city c2 
	on a.city_id = c2.city_id; 

-- 문제3번) Lima City에 사는 고객의 이름과, 성, 이메일, phonenumber에 대해서 알려주세요.

select c2.first_name , c2.last_name, c2.email, a.phone 
from city c
inner join address a  
	on c.city_id = a.city_id 
inner join customer c2  
	on a.address_id = c2.address_id 
where c.city like '%Lima%';

-- 문제4번) rental 정보에 추가로, 고객의 이름과, 직원의 이름을 함께 보여주세요.(고객의 이름, 직원 이름은 이름과 성을 fullname 컬럼으로만들어서 직원이름/고객이름 2개의 컬럼으로 확인해주세요.)

select r.*, c.first_name||',' ||c.last_name as fullname,
	s.first_name ||','||s.last_name as fullname from rental r
left join customer c 
	on r.customer_id = c.customer_id 
left join staff s 
	on c.address_id = s.address_id;

-- 문제5번) [seth.hannon@sakilacustomer.org](mailto:seth.hannon@sakilacustomer.org) 이메일 주소를 가진 고객의  주소 address, address2, postal_code, phone, city 주소를 알려주세요.

SELECT a.address, a.address2, a.postal_code, a.phone, c2.city 
from customer c 
left join address a 
	on c.address_id =a.address_id 
left join city c2 
	on a.city_id =c2.city_id 
where email = 'seth.hannon@sakilacustomer.org';

-- 문제6번) Jon Stephens 직원을 통해 dvd대여를 한 payment 기록 정보를  확인하려고 합니다.(payment_id,  고객 이름 과 성,  rental_id, amount, staff 이름과 성을 알려주세요.)

select p.payment_id, 
	c.first_name,
	c.last_name,
	p.rental_id,
	p.amount,
	s.first_name,
	s.last_name
from payment p 
left join staff s 
	on p.staff_id = s.staff_id 
left join customer c  
	on p.customer_id = c.customer_id 
where s.last_name = 'Stephens';

-- 문제7번) 배우가 출연하지 않는 영화의 film_id, title, release_year, rental_rate, length 를 알려주세요.

SELECT f.film_id, f.title, f.release_year, f.rental_rate, f.length 
FROM film f
left join film_actor fa 
	on f.film_id = fa.film_id
where fa.actor_id is null;

-- 문제8번) store 상점 id별 주소 (address, address2, distict) 와 해당 상점이 위치한 city 주소를 알려주세요.

select s.store_id, a.address, a.address2, a.district, c.city 
from store s 
inner join address a 
	on s.address_id = a.address_id 
inner join city c 
	on a.city_id = c.city_id;

-- 문제9번) 고객의 id 별로 고객의 이름 (first_name, last_name), 이메일, 고객의 주소 (address, district), phone번호, city, country 를 알려주세요.

select c.first_name, c.last_name, c.email, a.address, a.district, a.phone, c2.city, c3.country_id 
from customer c 
left join address a on c.address_id = a.address_id 
left join city c2 on a.city_id = c2.city_id 
left join country c3 on c2.country_id = c3.country_id;

-- 문제10번) country 가 china 가 아닌 지역에 사는, 고객의 이름(first_name, last_name)과 , email, phonenumber, country, city 를 알려주세요

select c3.first_name, c3.last_name, c3.email, a.phone, c2.country_id, c2.city from country c 
left join city c2 on c.country_id = c2.country_id 
left join address a on c2.city_id  = a.city_id 
left join customer c3 on a.address_id = c3.address_id 
where c.country not in ('china');

-- 문제11번) Horror 카테고리 장르에 해당하는 영화의 이름과 description 에 대해서 알려주세요

select f.title, f.description from film f 
left join film_category fc on f.film_id =fc.film_id 
left join category c on fc.category_id = c.category_id 
where c."name" ='Horror';

-- 문제12번) Music 장르이면서, 영화길이가 60~180분 사이에 해당하는 영화의 title, description, length 를 알려주세요.(영화 길이가 짧은 순으로 정렬해서 알려주세요.)

select f.title, f.description, f.length from film f 
inner join film_category fc on f.film_id = fc.film_id 
inner join category c on fc.category_id = c.category_id 
where (c."name" ='Music') and (f.length between 60 and 180)
order by f.length;

-- 문제13번) actor 테이블을 이용하여,  배우의 ID, 이름, 성 컬럼에 추가로    'Angels Life' 영화에 나온 영화 배우 여부를 Y , N 으로 컬럼을 추가 표기해주세요.  해당 컬럼은 angelslife_flag로 만들어주세요.

select a.actor_id, a.first_name, a.last_name, 
	case when a.actor_id in 
		(select a2.actor_id from actor a2 
		inner join film_actor fa on a2.actor_id = fa.actor_id 
		inner join film f on fa.film_id = f.film_id
		where f.title = 'Angels Life')
	then 'Y'
	else 'N'
end as angelslife_flag
FROM actor a;


-- 문제14번) 대여일자가 2005-06-01~ 14일에 해당하는 주문 중에서 , 직원의 이름(이름 성) = 'Mike Hillyer' 이거나  고객의 이름이 (이름 성) ='Gloria Cook'  에 해당 하는 rental 의 모든 정보를 알려주세요.(추가로 직원이름과, 고객이름에 대해서도 fullname 으로 구성해서 알려주세요.)

select r.* , c.first_name , c.last_name ,
s.first_name , s.last_name from rental r 
inner join staff s on r.staff_id = s.staff_id 
inner join customer c on r.customer_id = c.customer_id 
where (date(r.rental_date) between '2005-06-01' and '2005-06-14')
	and s.first_name || ' ' || s.last_name ='Mike Hillyer' 
	or c.first_name  || ' ' || c.last_name ='Gloria Cook'

-- 문제15번) 대여일자가 2005-06-01~ 14일에 해당하는 주문 중에서 , 직원의 이름(이름 성) = 'Mike Hillyer' 에 해당 하는 직원에게  구매하지 않은  rental 의 모든 정보를 알려주세요.(추가로 직원이름과, 고객이름에 대해서도 fullname 으로 구성해서 알려주세요.)

select r.* , c.first_name , c.last_name ,
s.first_name , s.last_name from rental r 
inner join staff s on r.staff_id = s.staff_id 
inner join customer c on r.customer_id  = c.customer_id 
where (date(r.rental_date) between '2005-06-01' and '2005-06-14')
	and s.first_name || ' ' || s.last_name not in ('Mike Hillyer');


-- < 실습문제 2-4 >

-- 문제1번) store 별로 staff는 몇명이 있는지 확인해주세요.

select s.store_id ,count(s2.staff_id) from store s 
inner join staff s2 on s.store_id = s2.store_id 
group by s.store_id; 

-- 문제2번) 영화등급(rating) 별로 몇개 영화film을 가지고 있는지 확인해주세요.

select rating, count(film_id) from film
group by rating;

-- 문제3번) 출현한 영화배우(actor)가  10명 초과한 영화명은 무엇인가요?

select f.title, count(fa.*) from film f 
inner join film_actor fa on f.film_id = fa.film_id 
group by f.title 
having count(fa.actor_id) > 10;

-- 문제4번) 영화 배우(actor)들이 출연한 영화는 각각 몇 편인가요?( 영화 배우의 이름 , 성 과 함께 출연 영화 수를 알려주세요.)

select a.first_name , a.last_name, count(f.film_id) from film f
inner join film_actor fa on f.film_id = fa.film_id 
inner join actor a on fa.actor_id =a.actor_id 
group by a.actor_id;


-- 문제5번) 국가(country)별 고객(customer) 는 몇명인가요?

select c3.country ,count(c.customer_id) from customer c 
inner join address a on c.address_id = a.address_id 
inner join city c2 on a.city_id = c2.city_id 
inner join country c3 on c2.city_id =c3.country_id 
group by c3.country;

-- 문제6번) 영화 재고 (inventory) 수량이 3개 이상인 영화(film) 는?( store는 상관 없이 확인해주세요. )

select f.title, count(i.inventory_id) as count_inventory
from film f
inner join inventory i ON f.film_id = i.film_id 
group by f.title 
having count(i.inventory_id) >=3;

-- 문제7번) dvd 대여를 제일 많이한 고객 이름은?

select c.first_name,c.last_name,count(p.payment_id) from customer c 
inner join rental r on c.customer_id = r.customer_id 
inner join payment p on r.rental_id = p.rental_id 
group by c.first_name, c.last_name 
order by count(p.payment_id) desc 
limit 1;

-- 문제8번) rental 테이블을  기준으로,   2005년 5월26일에 대여를 기록한 고객 중, 하루에 2번 이상 대여를 한 고객의 ID 값을 확인해주세요.

select r.customer_id, count(r.rental_id) from rental r 
where date(r.rental_date) ='2005-05-26' 
group by r.customer_id 
having count(distinct(r.rental_id)) >=2;
  
-- 문제9번) film_actor 테이블을 기준으로, 출현한 영화의 수가 많은  5명의 actor_id 와 , 출현한 영화 수 를 알려주세요.

select fa.actor_id, count(fa.film_id) from film_actor fa 
group by fa.actor_id 
order by count(fa.film_id) desc
limit 5;

-- 문제10번) payment 테이블을 기준으로,  결제일자가 2007년2월15일에 해당 하는 주문 중에서  ,  하루에 2건 이상 주문한 고객의  총 결제 금액이 10달러 이상인 고객에 대해서 알려주세요.(고객의 id,  주문건수 , 총 결제 금액까지 알려주세요)

select p.customer_id,count(p.payment_id) ,sum(p.amount) from payment p 
where date(p.payment_date) ='2007-02-15'
group by p.customer_id 
having count(p.payment_id) >=2 and sum(p.amount)>=10;

-- 문제11번) 사용되는 언어별 영화 수는?

select l.name, count(f.film_id) from film f
inner join language l on f.language_id = l.language_id
group by l.name; 

-- 문제12번) 40편 이상 출연한 영화 배우(actor) 는 누구인가요?

select a.actor_id , count(fa.film_id) from actor a 
inner join film_actor fa on a.actor_id =fa.actor_id 
group by a.actor_id 
having count(fa.film_id)>=40;

-- 문제13번) 고객 등급별 고객 수를 구하세요. (대여 금액 혹은 매출액  에 따라 고객 등급을 나누고 조건은 아래와 같습니다.)
/*
A 등급은 151 이상
B 등급은 101 이상 150 이하
C 등급은   51 이상 100 이하
D 등급은   50 이하

- 대여 금액의 소수점은 반올림 하세요.

HINT
반올림 하는 함수는 ROUND 입니다.	
*/

select sq.amount, count(sq.*) 
from (select c.customer_id, 
		case when sum(round(p.amount)) >= 151 then 'A'
			 when sum(round(p.amount)) between 101 and 150 then 'B'
			 when sum(round(p.amount)) between 51 and 100 then 'C'
			 when sum(round(p.amount)) <= 50 then 'D' end as amount 
	  from customer c 
	inner join rental r on c.customer_id = r.customer_id
	inner join payment p on r.rental_id = p.rental_id
	group by c.customer_id) as sq
group by sq.amount




-- < 실습문제 2-5 >


-- 문제1번) 영화 배우가,  영화 180분 이상의 길이 의 영화에 출연하거나, 영화의 rating 이 R 인 등급에 해당하는 영화에 출연한  영화 배우에 대해서,  영화 배우 ID 와 (180분이상 / R등급영화)에 대한 Flag 컬럼을 알려주세요.
/*
- film_actor 테이블와 film 테이블을 이용하세요.
- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.
- actor_id 가 동일한 flag 값 이 여러개 나오지 않도록 해주세요.
*/

select fa.actor_id , 'length_over_180' as flag from film f 
inner join film_actor fa on f.film_id = fa.film_id 
where f.length >= 180 
union 
select fa.actor_id, 'rating_R' as flag from film f 
inner join film_actor fa on f.film_id = fa.film_id 
where f.rating ='R';



-- 문제2번) R등급의 영화에 출연했던 배우이면서, 동시에, Alone Trip의 영화에 출연한  영화배우의 ID 를 확인해주세요.
/*
- film_actor 테이블와 film 테이블을 이용하세요.
- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.
*/

select fa.actor_id from film f 
inner join film_actor fa on f.film_id = fa.film_id 
where f.rating ='R'
intersect 
select fa2.actor_id from film f2 
inner join film_actor fa2 on f2.film_id = fa2.film_id 
where f2.title ='Alone Trip';



-- 문제3번) G 등급에 해당하는 필름을 찍었으나,   영화를 20편이상 찍지 않은 영화배우의 ID 를 확인해주세요.
/*
- film_actor 테이블와 film 테이블을 이용하세요.
- union, unionall, intersect, except 중 상황에 맞게 사용해주세요.
*/

select distinct(fa.actor_id) from film f 
inner join film_actor fa on f.film_id = fa.film_id 
where f.rating ='G'
except 
select distinct(fa2.actor_id) from film f2 
inner join film_actor fa2 on f2.film_id = fa2.film_id 
group by fa2.actor_id 
having count(fa2.film_id) >= 20;




--문제4번) 필름 중에서,  필름 카테고리가 Action, Animation, Horror 에 해당하지 않는 필름 아이디를 알려주세요.
/*
- category 테이블을 이용해서 알려주세요.
*/

select DISTINCT(f.film_id) from film f 
except
select DISTINCT(f2.film_id) from film f2 
inner join film_category fc on f2.film_id =fc.film_id 
inner join category c on fc.category_id = c.category_id 
where c."name" in ('Action', 'Animation', 'Horror')

-- except  절은 Distinct를 주의하자!(결과가 달라질 수 있음)

-- 문제5번) Staff  의  id , 이름, 성 에 대한 데이터와 , Customer 의 id, 이름 , 성에 대한 데이터를  하나의  데이터셋의 형태로 보여주세요.
/*
- 컬럼 구성 : id, 이름 , 성, flag (직원/고객여부) 로 구성해주세요.
*/

select s.staff_id, s.first_name, s.last_name, '직원' as flag 
from staff s 
union all
select c.customer_id, c.first_name, c.last_name, '고객' as flag 
from customer c; 

-- 문제6번) 직원과  고객의 이름이 동일한 사람이 혹시 있나요? 있다면, 해당 사람의 이름과 성을 알려주세요.
SELECT first_name,
       last_name
FROM   customer
INTERSECT
SELECT first_name,
       last_name
FROM   staff


-- 문제7번) 반납이 되지 않은 대여점(store)별 영화 재고 (inventory)와 전체 영화 재고를 같이 구하세요. (union all)

SELECT null as null,
       Count(*) cnt
FROM   rental r
       INNER JOIN inventory i
               ON r.inventory_id = i.inventory_id
WHERE  return_date IS NULL
UNION ALL
SELECT i.store_id,
       Count(*) cnt
FROM   rental r
       INNER JOIN inventory i
               ON r.inventory_id = i.inventory_id
WHERE  return_date IS NULL
GROUP  BY i.store_id

-- 문제8번) 국가(country)별 도시(city)별 매출액, 국가(country)매출액 소계 그리고 전체 매출액을 구하세요. (union all)

SELECT cty.country,
       ct.city,
       Sum(p.amount) rental_amount
FROM   payment p
       INNER JOIN customer c
               ON p.customer_id = c.customer_id
       INNER JOIN address a
               ON a.address_id = c.address_id
       INNER JOIN city ct
               ON ct.city_id = a.city_id
       INNER JOIN country cty
               ON cty.country_id = ct.country_id
GROUP  BY cty.country,
          ct.city
UNION ALL
SELECT cty.country,
       NULL,
       Sum(p.amount) rental_amount
FROM   payment p
       INNER JOIN customer c
               ON p.customer_id = c.customer_id
       INNER JOIN address a
               ON a.address_id = c.address_id
       INNER JOIN city ct
               ON ct.city_id = a.city_id
       INNER JOIN country cty
               ON cty.country_id = ct.country_id
GROUP  BY cty.country
UNION ALL
SELECT NULL,
       NULL,
       Sum(p.amount) rental_amount
FROM   payment p
       INNER JOIN customer c
               ON p.customer_id = c.customer_id
       INNER JOIN address a
               ON a.address_id = c.address_id
       INNER JOIN city ct
               ON ct.city_id = a.city_id
       INNER JOIN country cty
               ON cty.country_id = ct.country_id
ORDER  BY 1,
          2;
