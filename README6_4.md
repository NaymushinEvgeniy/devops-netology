# Домашнее задание к занятию "6.4. PostgreSQL"
### Задача 1
- вывод списка БД:

      postgres-# \l 
     
      List of databases
      Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
      -----------+----------+----------+------------+------------+-----------------------
      postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
      template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                |          |          |            |            | postgres=CTc/postgres
      template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
                |          |          |            |            | postgres=CTc/postgres

- подключение к БД:
  
      \conninfo
      You are connected to database "postgres" as user "postgres" via socket in "/var/run/postgresql" at port "5432".

- вывод списка таблиц:
  
      postgres-# \dt
               List of relations
      Schema |        Name        | Type  |  Owner
      --------+--------------------+-------+----------
      public | untitled_table_204 | table | postgres
      public | untitled_table_205 | table | postgres
      public | untitled_table_206 | table | postgres
      (3 rows)
- вывод описания содержимого таблиц:
      
      postgres-# \d untitled_table_204
               Table "public.untitled_table_204"
      Column |  Type   | Collation | Nullable |                    Default
      --------+---------+-----------+----------+------------------------------------------------
      id     | integer |           | not null | nextval('untitled_table_204_id_seq'::regclass)
- выход из psql

       \q

### Задача 2

Используя таблицу pg_stats, найдите столбец таблицы orders с наибольшим средним значением размера элементов в байтах.

Приведите в ответе команду, которую вы использовали для вычисления и полученный результат.

    test_database=# select max(avg_width) from pg_stats;
     max
     ------
       1237
    (1 row)

### Задача 3

Разбиение данных для уже существующей таблицы

    create table orders_1 ( like orders including all );
    insert into orders_1 (id,title,price) select id,title,price from orders where price>499;
    alter table orders_1 inherit orders;

    create table orders_2 ( like orders including all );
    insert into orders_2 (id,title,price) select id,title,price from orders where price<499;
    alter table orders_2 inherit orders;

Таблицу можно было бы шардировать на изначальном этапе используя ограничения:

    create table orders_1 check (price>499) inherit orders;
    create table orders_2 check (price<499) inherit orders;

### Задача 4

    pg_dump -U postgres -W -f test_db.backup test_database

Добавить уникальность значения столбца title используем UNIQUE:

    CREATE TABLE public.orders (
    ...
    title character varying(80) NOT NULL UNIQUE,
    ...
    );