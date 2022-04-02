# Домашнее задание к занятию "6.2. SQL"

### Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, в который будут складываться данные БД и бэкапы.

Приведите получившуюся команду или docker-compose манифест.

docker run -d --name netology-postgres -e POSTGRES_PASSWORD=secret -e PGDATA=/var/lib/postgresql/data/pgdata -v bd_netology:/var/lib/postgresql/data -v backups_netology:/mnt/backups -p 5432:5432 postgres


### Задача 2

