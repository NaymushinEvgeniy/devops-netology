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

### Задача 2

    CREATE USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test-pass';
    ALTER USER 'test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'test-pass' PASSWORD EXPIRE INTERVAL 180 DAY FAILED_LOGIN_ATTEMPTS 3 PASSWORD_LOCK_TIME 100;
    ALTER USER 'test'@'localhost' ATTRIBUTE '{"family":"Pretty","name":"James"}';

    REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'test'@'localhost';
    GRANT SELECT ON test_db.* TO 'test'@'localhost';

    mysql> SHOW GRANTS FOR 'test'@'localhost';
    +------------------------------------------+
    | Grants for test@localhost                |
    +------------------------------------------+
    | GRANT USAGE ON *.* TO `test`@`localhost` |
    +------------------------------------------+
    1 row in set (0.00 sec)

Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю test и приведите в ответе к задаче:

    mysql> SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE user='test';
    +------+-----------+---------------------------------------+
    | USER | HOST      | ATTRIBUTE                             |
    +------+-----------+---------------------------------------+
    | test | localhost | {"name": "James", "family": "Pretty"} |
    +------+-----------+---------------------------------------+
    1 row in set (0.00 sec)

### Задача 3

    mysql> SELECT TABLE_NAME, ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA='test_db';
    +------------+--------+
    | TABLE_NAME | ENGINE |
    +------------+--------+
    | orders     | InnoDB |
    +------------+--------+
    1 row in set (0.00 sec)

Измените engine и приведите время выполнения и запрос на изменения из профайлера в ответе:
    
    ALTER TABLE orders ENGINE=MyISAM;
     SHOW PROFILES;
    +----------+------------+---------------------------------------------------------------------------------------+
    | Query_ID | Duration   | Query                                                                                 |
    +----------+------------+---------------------------------------------------------------------------------------+
    |       1 | 0.25268150 | ALTER TABLE orders ENGINE=MyISAM                                                      |
    +----------+------------+---------------------------------------------------------------------------------------+
    
    ALTER TABLE orders ENGINE=InnoDB;
    mysql> SHOW PROFILES;
    +----------+------------+---------------------------------------------------------------------------------------+
    | Query_ID | Duration   | Query                                                                                 |
    +----------+------------+---------------------------------------------------------------------------------------+
    |       1  | 0.25268150 | ALTER TABLE orders ENGINE=MyISAM                                                      |
    |       2  | 0.24371925 | ALTER TABLE orders ENGINE=InnoDB                                                      |
    +----------+------------+---------------------------------------------------------------------------------------+

### Задача 4
Изучите файл my.cnf в директории /etc/mysql.
Измените его согласно ТЗ 

    [mysqld]
    pid-file        = /var/run/mysqld/mysqld.pid
    socket          = /var/run/mysqld/mysqld.sock
    datadir         = /var/lib/mysql
    secure-file-priv= NULL
    
    # Netology DZ 6.3.4
    # I/O priority
    
    innodb_flush_log_at_trx_commit = 2
    
    # Compression
    innodb_file_per_table = 1
    
    # Buffer with uncommit transations
    innodb_log_buffer_size = 1048576
    
    # Buffer for cash funcitons (exampler RAM=12 Gb)
    innodb_buffer_pool_size = 4G
    
    # Size of file with log operations (example total_disk_space = 100Gb)
    innodb_log_file_size = 50G