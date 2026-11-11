--Sual 1:Məhsul üzrə gəlir
select item as mehsul,
sum(total_spent) as umumi_gelir,
count(transaction_id) as emeliyyat_sayi
from cafe_sales_clean
group by item
order by sum(total_spent) DESC;

Sual 2:2023-cü il üzrə kafenin gəliri aylar üzrə necə dəyişib? 
--Hansı ay ən yüksək, hansı ən aşağı gəlir gətirib? 
select substr(transaction_date,4,5) as Aylar,
sum(total_spent) as umumi_gelir
FROM cafe_sales_clean
where length(transaction_date)>0
group by substr(transaction_date,4,5)
order by sum(total_spent) DESC;

Sual 3:--müştərilər hansı ödəniş üsulunu daha çox seçir və hansı üsulla gəlir daha çoxdur? 
SELECT payment_method as ödəniş_üsulu,
sum(total_spent) as ümumi_gəlir,
count(transaction_id) as əməliyyat_sayı,
round(sum(total_spent)*100.0/(SELECT sum(total_spent) from cafe_sales_clean),1) as pay_faizi
FROM cafe_sales_clean
GROUP BY payment_method
ORDER BY SUM(total_spent) DESC;

Sual 4:satışlar mağaza daxilində (In-store) və paket (Takeaway) arasında necə bölünür? 
select location as unvan,
sum(total_spent) as umumi_gelir,
count(transaction_id) as emeliyyat_sayi,
round(avg(total_spent),2),
ROUND(sum(total_spent*100.0/(SELECT sum(total_spent) from cafe_sales_clean)),1)
from cafe_sales_clean
group by location
order by sum(total_spent) DESC;

Sual 5:kafenin gəlirini kim formalaşdırır: çoxlu sayda kiçik əməliyyatlar, 
--yoxsa az sayda böyük əməliyyatlar?
select sum(total_spent) as umumi_gelir,
count(transaction_id) as emeliyyat_sayi,
round(avg(total_spent),2) AS orta_mebleg,
round(sum(total_spent*100.0/(SELECT (sum(total_spent)) from cafe_sales_clean)),2) as pay_faizi,
	CASE
    when total_spent <=8 then 'asagi'
    when total_spent <=15 then 'orta'
    ELSE 'yuksek'
   end as kateqoriya
from cafe_sales_clean
group by kateqoriya;
