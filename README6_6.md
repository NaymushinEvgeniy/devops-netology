# Домашнее задание к занятию "6.6. Troubleshooting"

### Задача 1
Список операций для остановки запроса пользователя:
1. Определим id (UUID) операции:

        db.currentOp(
           {
             "active" : true,
             "secs_running" : { "$gt" : 180 },
             "ns" : /^db1\./
           }
            )
Для операции берем значение opid в формате "shardName:opid on that shard>"

2. Выполним остановку запроса:

        db.killOp("shardName:opid on that shard>")