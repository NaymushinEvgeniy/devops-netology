# Домашнее задание к занятию "6.2. SQL"

### Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

docker run -d --name netology-postgres -e POSTGRES_PASSWORD=secret -e PGDATA=/var/lib/postgresql/data/pgdata -v bd_netology:/var/lib/postgresql/data -v backups_netology:/mnt/backups -p 5432:5432 postgres


### Задача 2

Итоговый список БД после выполнения пунктов:

![](https://i.ibb.co/zV0PW8r/dz6-1-2-1.png)

Описание таблиц (describe):

![](https://i.ibb.co/yybtHfF/dz6-1-2-2.png)

SQL-запрос для выдачи списка пользователей с правами над таблицами test_db

![](https://i.ibb.co/3z53xs1/dz6-1-2-3.png)

Список пользователей с правами над таблицами test_db

![](https://i.ibb.co/Jkw5kvy/dz6-1-2-4.png)

### Задача 3

Наполнение таблицы Orders

insert into orders (name,price) values ('Шоколад', 10);

INSERT 0 1

insert into orders (name,price) values ('Принтер', 3000);

INSERT 0 1

insert into orders (name,price) values ('Книга', 500);

INSERT 0 1

insert into orders (name,price) values ('Монитор', 7000);

INSERT 0 1

insert into orders (name,price) values ('Гитара', 4000);

INSERT 0 1

Наполнение таблицы Clients

insert into clients (family,country)  values ('Иванов Иван Иванович','USA');

INSERT 0 1

insert into clients (family,country)  values ('Петров Петр Петрович','Canada');

INSERT 0 1

insert into clients (family,country)  values ('Иоганн Себастьян Бах','Japan');

INSERT 0 1

insert into clients (family,country)  values ('Ронни Джеймс Дио','Russia');

INSERT 0 1

insert into clients (family,country)  values ('Ritchie Blackmore','Russia');

INSERT 0 1

Количество записей в таблице Clients:
select (count(*)) from clients;
 count
-------
     5
(1 row)

Количество записей в таблице Orders:
select (count(*)) from orders;
 count
-------
     5
(1 row)

### Задача 4
Создаем связь для таблицы с клиентами

ALTER TABLE clients ADD CONSTRAINT orders_id FOREIGN KEY (id) REFERENCES orders(id);

Заполняем ID заказов для клиентов:

UPDATE clients set orders_id='3' WHERE id=1;

UPDATE 1

UPDATE clients set orders_id='4' WHERE id=2;

UPDATE 1

UPDATE clients set orders_id='5' WHERE id=3;

UPDATE 1

Вывод исходного запроса:
select family,name from clients INNER JOIN orders ON clients.orders_id=orders.id;

        family        |  name
----------------------+---------
 Иванов Иван Иванович | Книга
 Петров Петр Петрович | Монитор
 Иоганн Себастьян Бах | Гитара
(3 rows)

Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса:

select family from clients where orders_id is not null;

        family
----------------------
 Иванов Иван Иванович
 Петров Петр Петрович
 Иоганн Себастьян Бах
(3 rows)

### Задача 5

 EXPLAIN select family from clients where orders_id is not null;

                       QUERY PLAN
--------------------------------------------------------
 Seq Scan on clients  (cost=0.00..1.05 rows=5 width=32)
   Filter: (orders_id IS NOT NULL)
(2 rows)


Cost (1 значение) - Приблизительная стоимость запуска - время, которое проходит, прежде чем начнётся этап вывода данных, 
Сost (2 значение) - Приблизительная общая стоимость. Она вычисляется в предположении, что запрос выполняется до конца, 
то есть возвращает все доступные строки.
Rows - Ожидаемое число строк, которое должен вывести этот узел плана. При этом так же предполагается, что запрос
выполняется до конца.
width - Ожидаемый средний размер строк, выводимых этим запросом (в байтах).
Filter - критерий фильтрации данных запроса

### Задача 6

pg_dump -U postgres test_db > /mnt/backups/test_db.sql


docker stop netology-postgres
docker rm netology-postgres

docker run -d --name netology-postgres -e POSTGRES_PASSWORD=secret -e PGDATA=/var/lib/postgresql/data/pgdata -v 
bd_netology:/var/lib/postgresql/data -v backups_netology:/mnt/backups -p 5432:5432 postgres


psql -U postgres test_db < /mnt/backups/test_db.sql


