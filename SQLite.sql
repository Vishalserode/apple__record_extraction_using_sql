--creating a table using other csv files--
create table appleStore_description_combined AS

select * from appleStore_description1

union ALL

SELECT *  from appleStore_description2

union all 

SELECT * from appleStore_description3

union ALL

select * from appleStore_description4


--cheking unique apps in table--

select COUNT(DISTINCT id) from AppleStore

select COUNT(DISTINCT id) from appleStore_description_combined

--above two lines ends in same result =7197--

--↓↓↓↓ checking for any missing values in the table ↓↓↓↓--

select count(*) from AppleStore
where track_name is null 
or size_bytes is null
or user_rating is null
or cont_rating is NULL
or prime_genre is NULL
or vpp_lic is NULL--there is no missing values in AppleStore table--


select count(*) from appleStore_description_combined
where track_name is null 
or size_bytes is null
or app_desc is null--there is no missing values in appappleStore_description_combined table--
--the result will be 0 --

--grouping the prime_genre by the count↓↓↓↓↓↓--
SELECT prime_genre,COUNT(*) as count_apps
FROM AppleStore
group by prime_genre
order by count_apps DESC

--getting overview of app_rating from AppleStore--
SELECT MIN(user_rating) as minimim_rating
,max(user_rating) as maximum_rating
,avg(user_rating) as average_rating
from AppleStore

--right_joining--
SELECT AppleStore.user_rating,
AppleStore.cont_rating,
appleStore_description2.track_name,
appleStore_description2.app_desc
from AppleStore RIGHT join
appleStore_description2
ON AppleStore.id=appleStore_description2.id

--using between getting price data between 3.99 and 7.99 and not between them↓↓↓↓↓↓--

select * from AppleStore
where price BETWEEN 3.99 and 7.99
--not between↓↓↓↓--
select * from AppleStore
where price NOT BETWEEN 3.99 and 7.99

--getting the count of prime_geenre is games↓↓↓↓--

select count(*) from 
AppleStore where prime_genre='Games'
--result=3862

--getting the count of prime_geenre is Productivity↓↓↓↓--
select count(*) from
AppleStore where prime_genre='Productivity'
--result=178

--like operator AppleStore
select track_name from 
AppleStore where track_name LIKE 'PAC%'

--extracting data using subqueries--
--getting track_name start with C and price > 2.99--

select * from
(SELECT appleStore_description1.track_name,AppleStore.price from AppleStore
 RIGHT join appleStore_description1
 on AppleStore.id=appleStore_description1.id) 
 where track_name like 'C%' and price > 2.99
 
 
 --getting the count of count_rating that are not like 9+ and 12+--
 SELECT count(ipadsc_urls_num) from
 (SELECT AppleStore.ipadsc_urls_num,AppleStore.cont_rating,
  appleStore_description3.track_name,appleStore_description3.size_bytes from 
  appleStore_description3 RIGHT join 
  AppleStore on AppleStore.id=appleStore_description3.id) WHERE
  cont_rating not like '9+%' and '12+%'
  
  
  --getting count of track_name which are similar in AppleStore and aappleStore_description3 table and the track_name is not starting of C
  SELECT count(*) FROM
  (select AppleStore.track_name,appleStore_description3.track_name from AppleStore
   LEFT join appleStore_description3 where
   AppleStore.track_name=appleStore_description3.track_name)
   where track_name not like 'C%'
   
   
   --getting the count of price is equal to 0 for a specific record
   select count(*) from (select track_name,price,app_desc FROM
   (SELECT AppleStore.track_name,AppleStore.price,
    appleStore_description4.track_name,
    appleStore_description4.app_desc
    from AppleStore full join 
    appleStore_description4
   where AppleStore.id=appleStore_description4.id)
   where track_name like 'Em%') where price=0
   
   
   
   
   
   
   
   
 
 
 
 







