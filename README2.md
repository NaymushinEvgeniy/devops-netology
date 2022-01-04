# Домашнее задание к занятию "4.3. Языки разметки JSON и YAML"

### Обязательная задача 1.
Мы выгрузили JSON, который получили через API запрос к нашему сервису:
```json
{ "info" : "Sample JSON output from our service\t",
        "elements" :[
            { "name" : "first",
            "type" : "server",
            "ip" : 7175 
            }
            { "name" : "second",
            "type" : "proxy",
            "ip : 71.78.22.43
            }
        ]
    }
```

Нужно найти и исправить все ошибки, которые допускает наш сервис

Решение: 
```json
{ "info" : "Sample JSON output from our service\t",
        "elements" : [
            { "name" : "first",
            "type" : "server",
            "ip" : 7175
            },
            { "name" : "second",
            "type" : "proxy",
            "ip" : "71.78.22.43"
            }
        ]
    }
```

### Обязательная задача 2.
В прошлый рабочий день мы создавали скрипт, позволяющий опрашивать веб-сервисы и получать их IP. К уже реализованному функционалу нам нужно добавить возможность записи JSON и YAML файлов, описывающих наши сервисы. Формат записи JSON по одному сервису: { "имя сервиса" : "его IP"}. Формат записи YAML по одному сервису: - имя сервиса: его IP. Если в момент исполнения скрипта меняется IP у сервиса - он должен так же поменяться в yml и json файле.
Ваш скрипт:
```python
#!/usr/bin/env python3

import os
import sys
import socket
import json

url = sys.argv[1]
ip = socket.gethostbyname(url)
ips = []

# Формирование структуры JSON
data = { "url" : url, "ip" : ips }

# Вспомогательная функция поиска в списке IP-адресов
def find_in_json (set_ip, list_json):
    if set_ip not in list_json:
        list_json.append(set_ip)

# Работа скрипта

print("Текущий IP проверки сервиса " + url + " - " + ip)

# Проверяем наличие БД, если ее нет - создаем
with open("bdn.json", "r+") as f:
    content = f.readlines()
    if len(content) == 0:
        json.dump(data, f)

# Считываем данные из текущей БД, проверяем на наличие
with open("bdn.json", "r") as f:
    content = json.load(f)
    list_json = content["ip"]
    find_in_json(ip, list_json)

# Записываем в БД все изменения
with open('bdn.json', 'w') as f:
    json.dump(content, f)

```
Вывод скрипта при запуске при тестировании:

```python
Текущий IP проверки сервиса google.com - 142.250.190.78
```

json-файл(ы), который(е) записал ваш скрипт:
```json
{"url": "google.com", "ip": ["142.250.190.71", "142.250.190.78", "142.250.191.206"]}
```