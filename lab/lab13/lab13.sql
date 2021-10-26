.read data.sql

-- QUESTIONS --

-------------------------------------------------------------------------
------------------------ Give Interest- ---------------------------------
-------------------------------------------------------------------------

update accounts set amount = amount * 1.02;


create table give_interest_result as select * from accounts; -- just for tests

-------------------------------------------------------------------------
------------------------ Split Accounts ---------------------------------
-------------------------------------------------------------------------

create table tmp as
    select name || "'s Savings account" as name, amount/2
    from accounts;
insert into tmp select name || "'s Checking account", amount/2 from accounts;

drop table accounts;
CREATE TABLE accounts AS
  SELECT * FROM tmp;


create table split_account_results as select * from accounts; -- just for tests

-------------------------------------------------------------------------
-------------------------------- Whoops ---------------------------------
-------------------------------------------------------------------------

drop table tmp;
drop table accounts;


CREATE TABLE average_prices AS
  SELECT category, avg(MSRP) as average_price
  from products group by category;

CREATE TABLE lowest_prices AS
  SELECT store, item, min(price) from inventory group by item;

CREATE TABLE shopping_list AS
SELECT name, store FROM (
                            SELECT products.name, MAX(products.rating / products.MSRP), lowest_prices.store
                            FROM products, lowest_prices
                            WHERE products.name = lowest_prices.item
                            GROUP BY products.category
                        );

CREATE TABLE total_bandwidth AS
  SELECT SUM(stores.Mbs)
  FROM shopping_list, stores
  WHERE shopping_list.store = stores.store;
