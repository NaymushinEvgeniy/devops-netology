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

#!/usr/bin/env python3

#import os
import sys
import socket
import json
import yaml
from yaml.loader import SafeLoader

urls = ["google.com", "drive.google.com", "mail.google.com"]
main_list = [] # Список готовых объектов в формате URL -> Список готовых адресов
json_data = { "elements" : main_list } # "Обертка" JSON-файла
yaml_data = { "elements" : main_list }

# Вспомогательная функция поиска в списке IP-адресов
def find_in_json (set_ip, list_json):
    if set_ip not in list_json:
        list_json.append(set_ip)

# Работа скрипта

# Проверяем наличие БД, если ее нет - создаем
with open("bd.json", "r+") as f:
    content = f.readlines()
    if len(content) == 0:
        for url in urls:
            ips = [] # Список IP-адресов Хоста
            data = {} # Словарь для JSON-структуры объекта
            ip = socket.gethostbyname(url)
            ips.append(ip)
            data["url"] = url
            data["ip"] = ips
            main_list.append(data) # Заполнение информации по объекту
        json.dump(json_data, f)
        
with open("bd.yaml", "r+") as f:
    content = f.readlines()
    if len(content) == 0:
        for url in urls:
            ips = [] # Список IP-адресов Хоста
            data = {} # Словарь для JSON-структуры объекта
            ip = socket.gethostbyname(url)
            ips.append(ip)
            data["url"] = url
            data["ip"] = ips
            main_list.append(data) # Заполнение информации по объекту
        yaml.dump(yaml_data, f)

# Считываем данные из текущей БД, проверяем на наличие IP-адресов для хоста,
# формируем обновленную структуру для JSON
with open("bd.json", "r") as f:
    content = json.load(f)
    content = content["elements"] # Вытаскиваем данные из обертки
    for i in content:
        ip = socket.gethostbyname(i["url"])
        list_json = i["ip"]
        find_in_json(ip, list_json)
    n_content = {} # Словарь под обновленные данные
    n_content["elements"] = content # Кладем обновленные данные обратно в обертку

# формируем обновленную структуру для YAML
with open("bd.yaml", "r") as f:
    content = yaml.load(f, Loader=yaml.SafeLoader)
    content = content["elements"] # Вытаскиваем данные из обертки
    for i in content:
        ip = socket.gethostbyname(i["url"])
        list_json = i["ip"]
        find_in_json(ip, list_json)
    n_content = {} # Словарь под обновленные данные
    n_content["elements"] = content # Кладем обновленные данные обратно в обертку

# Записываем в БД все изменения
with open('bd.json', 'w') as f:
    json.dump(n_content, f)

with open('bd.yaml', 'w') as f:
    yaml.dump(n_content, f)

```
Вывод скрипта при запуске при тестировании:

```python
Текущий проверяемый IP 172.217.5.14 для URL-a google.com
Текущий проверяемый IP 172.217.4.46 для URL-a drive.google.com
Текущий проверяемый IP 142.250.191.101 для URL-a mail.google.com
```

json-файл(ы), который(е) записал ваш скрипт:
```json
{
  "elements":
  [
    {
      "ip": [
        "142.250.190.46", 
        "142.250.191.206", 
        "172.217.5.14"], 
      "url": "google.com"
    }, 
    {
      "ip": [
        "142.251.32.14",
        "142.250.190.14",
        "142.250.191.142",
        "172.217.4.46"], 
      "url": "drive.google.com"}, 
    {
      "ip": [
        "142.250.191.101", 
        "142.250.190.101", 
        "142.250.190.5"], 
      "url": "mail.google.com"
    }
  ]
}
```
yml-файл(ы), который(е) записал ваш скрипт:
```yaml
elements:
- ip:
  - 142.250.190.46
  - 142.250.191.206
  - 172.217.5.14
  url: google.com
- ip:
  - 142.251.32.14
  - 142.250.190.14
  - 142.250.191.142
  - 172.217.4.46
  url: drive.google.com
- ip:
  - 142.250.191.101
  - 142.250.190.101
  - 142.250.190.5
  url: mail.google.com
```