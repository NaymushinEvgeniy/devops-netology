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