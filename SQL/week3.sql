/*
모든 문제는 postgresql기준으로 작성되어있습니다.
*/

-- < 실습문제 3-6 >

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

select c.name
from category as c
where exists (
	select fc.category_id
	from rental as r
	join inventory as i on r.inventory_id = i.inventory_id
	join film_category as fc on i.film_id = fc.film_id
	where fc.category_id = c.category_id
)

-- 문제3번) 대여가 한번도이라도 된 영화 카테 고리 이름을 알려주세요. (쿼리는, Any 조건을 이용하여 풀어봅시다)
select c.name
from category as c
where category_id = any ( select fc.category_id from rental as r
			join inventory as i on r.inventory_id = i.inventory_id
			join film_category as fc on i.film_id = fc.film_id
)

-- 문제4번) 대여가 가장 많이 진행된 카테고리는 무엇인가요? (Any, All 조건 중 하나를 사용하여 풀어봅시다)

select c.*

from category as c

where category_id = any (

	select fc.category_id
	
	-- ,  count(distinct r.rental_id) as cnt
	
	from rental as r
	
	join inventory as i on r.inventory_id = i.inventory_id
	
	join film_category as fc on i.film_id = fc.film_id
	
	group by  fc.category_id
	
	order by  count(distinct r.rental_id) desc
	
	limit 1

)

;

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
select *

from  film as f

where not exists (

select *

from film_category as fc

where  f.film_id   = fc.film_id

);


-- <3주차 퀴즈>

-- 문제1번) 4개이상의 업체에서 판매하는 상품번호가 무엇인지 알려주세요.

select productnumber , count(distinct vendorid) as cnt_vendor
from product_vendors pv 
group by productnumber 
having count(distinct vendorid) >3)


-- 문제2번) 주문일자별, 고객의 아이디별로, 주문번호에 해당하는 주문 금액은 얼마인가요?

select orderdate, customerid, ordernumber,sum(prices) as order_price
from (
        select o.orderdate, o.customerid, o.ordernumber, od.productnumber,
		od.quotedprice * od.quantityordered as prices
        from orders as o
        join order_details as od 
	on o.ordernumber = od.ordernumber
) as db  
group by orderdate, customerid , ordernumber

-- 문제3번) 고객의 이름과, 직원의 정보를 하나의 이름 정보로 보여주세요. - 단 이름과 타입으로 컬럼을 구성하여 타입은 고객/직원의 타입에 따라 각각 customer, staff으로 값을 넣어주세요.

-- 문제4번) 1번 주문 번호에 대해서, 상품명, 주문 금액과 1번 주문 금액에 대한 총 구매금액을 함께 보여주세요.

select ordernumber , customerid , null as productnumber , sum(prices) as price 
from (
        select o.orderdate, o.customerid, o.ordernumber, od.productnumber,
                        od.quotedprice * od.quantityordered as prices
        from orders as o
        join order_details as od 
	on o.ordernumber = od.ordernumber
        where o.ordernumber =1 
) as db 
group by ordernumber , customerid , ordernumber

union all 

select  ordernumber , customerid  , productnumber ,prices 
from (
        select o.orderdate, o.customerid, o.ordernumber, od.productnumber,
                        od.quotedprice * od.quantityordered as prices
        from orders as o
             join order_details as od on o.ordernumber = od.ordernumber
        where o.ordernumber =1 
) as db 


-- 문제5번) 헬멧을 주문한 모든 고객과 자전거를 주문한 모든 고객을 나열하세요. (Union 활용) 헬멧과 자전거는 Products 테이블의 productname 컬럼을 이용해서 확인해주세요.


select o.customerid
        from orders as o 
             join order_details as od
 on o.ordernumber = od.ordernumber
             join products as p 
on od.productnumber =p.productnumber
        where p.productname like '%Bike'
union 
select o.customerid
        from orders as o 
             join order_details as od 
on o.ordernumber = od.ordernumber
             join products as p 
on od.productnumber =p.productnumber
        where p.productname like '%Helmet'
-- 문제6번) 고객이 구매 제품의 가격이, 평균 제품 소매 가격보다 높은 제품의 이름과 번호를 알려주세요.

select distinct od.productnumber, p.productname , od.quotedprice
from order_details as od 
      join products as p on od.productnumber = p.productnumber
where od.quotedprice >= (select avg(p.retailprice) as avg_p
                                from products  as p )
                                
                     
 1,2,6,11                         
                                  
                            
 
 select productnumber ,retailprice,  avg(retailprice) 
 from products p 
 group by productnumber ,retailprice

-- 문제7번) 주문일자가 2017/09/01 ~ 2017/09/30 일에 해당하는 주문에 대해서 주문일자와 고객별로 주문 수를 확인해주세요. 또한 고객별 주문 수도 함께 알려주세요.

select orderdate , customerid , count(distinct ordernumber) as cnt 
from orders o 
where orderdate  between '2017-09-01' and '2017-09-30'
group by grouping sets ((orderdate,customerid), (customerid))


-- 문제8번) 주문일자가 2017/09/01 ~ 2017/09/30일에 해당하는 주문에 대해서,주문일자와 고객별로 주문 수를 확인해주세요. 또한 주문일자별 주문 수도 함께 알려주시고, 전체 주문 수도 함께 알려주세요.

select orderdate , customerid , count(distinct ordernumber) as cnt 
from orders o 
where orderdate  between '2017-09-01' and '2017-09-30'
group by rollup (orderdate,customerid)



--문제9번) 2017년도의 주문일 별 주문 금액과, 월별 주문 총 금액을 함께 보여주세요. 동시에 일별 주문 금액이 월별 주문 금액에 해당하는 비율을 같이 보여주세요. (analytic function 활용)

select orderdate, 
           sum(product_price) over (partition by orderdate ) as day_price ,
           sum(product_price) over (partition by mm ) as monthly_price,
           sum(product_price) over (partition by orderdate )  / 
           sum(product_price) over (partition by mm )  as perc
from (
       select mm , orderdate , sum(product_price) product_price
       from 
               (
		select o.ordernumber, orderdate, EXTRACT(month from o.orderdate) as mm, 
                                   od.productnumber, od.quotedprice * od.quantityordered as product_price
		from orders as o 
		     join order_details as od  on o.ordernumber= od.ordernumber 
		where o.orderdate between '2017-01-01' and '2017-12-31'
                   ) dt  
                group by mm , orderdate
) as dt 



-- 문제10번) 주문을 많이 한 고객 순서 대로 순위를 매겨 나열하세요. (analytic function 활용) 
-- 같은 주문 수치 일 때, 같은 등수로 보여주세요.
select  c.custfirstname || c.custlastname as cust_name  , o.customerid , order_cnt , 
                DENSE_RANK() over(order by order_cnt  desc) drnk ,
                rank () over(order by order_cnt  desc) rnk ,
                row_number () over(order by order_cnt  desc) rnum 
from 
(
  select o.customerid  , count(*) order_cnt 
    from orders as o 
   group by o.customerid 
) o inner join customers as c on c.customerid = o.customerid
