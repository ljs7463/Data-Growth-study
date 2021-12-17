-- 1. Dvd 렌탈 업체의 dvd대여가 있었던 날짜를 확인해주세요.
-- 날짜는 중복이 되기때문에 "distinct"를 반드시 넣어주어야 하며, 시간을 추출하는 "date" 함수 역시 실제로 많이 활용된다.
select distinct(date(rental_date)) from rental;



-- 2. 영화길이가 120분 이상이면서, 대여기간이 4일 이상이 가능한, 영화제목을 알려주세요.
-- 비교연산자를 넣어서 조건을 완성해 주면 된다.
select title from film 
where length >=120 and rental_duration >= 4;
