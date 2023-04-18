USE fastkart;

show tables;

select productid, productname, QuantityAvailable from products pr
ORDER BY QuantityAvailable desc
limit 3
;

select EmailId
from purchasedetails pur, products pr
group by EmailId
having count(distinct(pur.PurchaseId)) > 10
;

select CategoryName, sum(QuantityAvailable) as TotalQuantityAvailable
from categories ca, products pr
where pr.CategoryId = ca.CategoryId
group by CategoryName
order by TotalQuantityAvailable desc
;

Select pr.ProductId, ProductName, CategoryName, sum(QuantityPurchased) as Total_Purchased_Quantity
from purchasedetails pur, products pr, categories ca
where pr.ProductId = pur.ProductId
group by pr.ProductId
order by Total_Purchased_Quantity desc
limit 1
;

Select Gender, count(us.RoleId)
from users us, roles ro
where us.RoleId = ro.RoleId
group by Gender
;

Select ProductId, ProductName, Price,
Case
	when Price < 2000 then "Affordable"
    when Price between 2000 And 50000 then "High End Stuff"
    when Price > 50000 then "Luxury"
end as Item_Classes
from products
;

Select ProductId, ProductName, CategoryName, Price as Old_Price,
Case
	when CategoryName = "Motors" then Price - 3000
    when CategoryName = "Electronics" then Price + 50
    when CategoryName = "Fashion" then Price + 150
else Price
end as New_Price
from products pr, categories ca
where pr.CategoryId = ca.CategoryId
;

Set @Total = (select count(*) from users);
Set @Female = (select count(*) from users where Gender = "F");
Select ((@Female/@Total)*100) as Percentage_of_Females; 


Select CardType, avg(Balance)
from carddetails
where NameOnCard like '%e'
and CVVNumber > 333
group by CardType
;

Select ProductName, CategoryName, (Price*QuantityAvailable) AS Value_of_item
from products pr, categories ca
where pr.CategoryId = ca.CategoryId
and CategoryName not like "Motor"
order by Value_of_item desc
limit 1,1
;