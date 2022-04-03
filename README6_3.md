# Домашнее задание к занятию "6.3. MySQL"

### Задача 1
- Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume:

       docker run -d --name netology-mysql -v bd:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=secret mysql

- Изучите бэкап БД и восстановитесь из него:

      docker exec -i netology-mysql sh -c 'exec mysql -uroot -p"secret" --database=test_db' < test_dump.sql

- Найдите команду для выдачи статуса БД и приведите в ответе из ее вывода версию сервера БД:

      mysql> status
    
      mysql  Ver 8.0.28 for Linux on x86_64 (MySQL Community Server - GPL)
    
      Server version:         8.0.28 MySQL Community Server - GPL
- Подключитесь к восстановленной БД и получите список таблиц из этой БД:
    
      mysql> show tables;

      | Tables_in_test_db |

      | orders            |
- Приведите в ответе количество записей с price > 300:
    
    
        select * from orders where price>300;
        
        | id | title          | price |
            
        |  2 | My little pony |   500 |

