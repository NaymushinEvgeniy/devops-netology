# Домашнее задание к занятию "4.2. Использование Python для решения типовых DevOps задач"

### Обязательная задача 1.
Есть скрипт:
```python
#!/usr/bin/env python3
a = 1
b = '2'
c = a + b
```

#### Вопросы:
Вопрос | Ответ
--- |-------|
Какое значение будет присвоено переменной c? | 'c' is not defined - нельзя складывать явно указанные разнотипные переменные
Как получить для переменной c значение 12? | Явно указать тип для значения переменной a = '1', или взять значение функции a=str(a)
Как получить для переменной c значение 3? | Явно указать тип для значения переменной b = 2, или взять значение функции b=int(b)

### Обязательная задача 2.
Мы устроились на работу в компанию, где раньше уже был DevOps Engineer. Он написал скрипт, позволяющий узнать, какие файлы модифицированы в репозитории, относительно локальных изменений. Этим скриптом недовольно начальство, потому что в его выводе есть не все изменённые файлы, а также непонятен полный путь к директории, где они находятся. Как можно доработать скрипт ниже, чтобы он исполнял требования вашего руководителя?

```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(prepare_result)
        break
```

Скрипт:
```python
#!/usr/bin/env python3

import os

bash_command = ["cd ~/netology/sysadm-homeworks", "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
home_path = os.getcwd()
is_change = False
for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        path = bash_command[0].replace('"', '')
        print(home_path + path.replace('cd ~', '') + '/' + prepare_result)
```

Вывод скрипта при запуске и тестировании:
```python
/root/netology/sysadm-homeworks/one.txt
/root/netology/sysadm-homeworks/tree.txt
/root/netology/sysadm-homeworks/two.txt
```

### Обязательная задача 3
Доработать скрипт выше так, чтобы он мог проверять не только локальный репозиторий в текущей директории, а также умел воспринимать путь к репозиторию, который мы передаём как входной параметр. Мы точно знаем, что начальство коварное и будет проверять работу этого скрипта в директориях, которые не являются локальными репозиториями.  

Скрипт:
```python
#!/usr/bin/env python3

import os
from sys import argv

path = argv
home_path = os.getcwd()

if len(path) == 1:
    print("Не задан путь к реопзиторию!")
    exit()

bash_command = ["cd " + home_path + path[1], "git status"]
result_os = os.popen(' && '.join(bash_command)).read()
is_change = False

for result in result_os.split('\n'):
    if result.find('modified') != -1:
        prepare_result = result.replace('\tmodified:   ', '')
        print(home_path + path[1] + '/' + prepare_result)
```

### Обязательная задача 4
Наша команда разрабатывает несколько веб-сервисов, доступных по http. Мы точно знаем, что на их стенде нет никакой балансировки, кластеризации, за DNS прячется конкретный IP сервера, где установлен сервис. Проблема в том, что отдел, занимающийся нашей инфраструктурой очень часто меняет нам сервера, поэтому IP меняются примерно раз в неделю, при этом сервисы сохраняют за собой DNS имена. Это бы совсем никого не беспокоило, если бы несколько раз сервера не уезжали в такой сегмент сети нашей компании, который недоступен для разработчиков. Мы хотим написать скрипт, который опрашивает веб-сервисы, получает их IP, выводит информацию в стандартный вывод в виде: <URL сервиса> - <его IP>. Также, должна быть реализована возможность проверки текущего IP сервиса c его IP из предыдущей проверки. Если проверка будет провалена - оповестить об этом в стандартный вывод сообщением: [ERROR] <URL сервиса> IP mismatch: <старый IP> <Новый IP>. Будем считать, что наша разработка реализовала сервисы: drive.google.com, mail.google.com, google.com.

```python
#!/usr/bin/env python3

import os
import sys
import socket

url = sys.argv[1]
ip = socket.gethostbyname(url)
entry= 0

print("Текущий IP проверки сервиса " + url + " - " + ip)


with open('bdn.txt', 'r+') as f:
    data = f.readlines()
    old_ips = ""

    if len(data) == 0:
        print("БД пустая, пишем")
        f.write(url + " - " + ip + "\n")
        exit()

    for d in data:
        find = d.find(ip)
        entry += 1
        old_ips += d

        if find != -1:
            print("Доступность сервиса " + url + " с ip " + ip + " прежняя")
            break
        elif entry == len(data): # or entry== 0:
            print("Такого адреса нет в бд, записываю")
            print("[ERROR] " + url + " IP mismatch: " + ip + "\nСтарые IP: \n" + old_ips)
            f.write(url + " - " + ip + "\n")
        else:
            continue

```

Вывод скрипта при запуске при тестировании:
Если адрес изменился:
```python
Текущий IP проверки сервиса google.com - 172.217.5.14
Такого адреса нет в бд, записываю
[ERROR] google.com IP mismatch: 172.217.5.14
Старые IP: 
google.com - 142.250.191.206
google.com - 142.250.190.46
google.com - 142.250.190.78
google.com - 142.250.190.142
```


Если адрес не менялся:
```python
Текущий IP проверки сервиса google.com - 172.217.5.14
Доступность сервиса google.com с ip 172.217.5.14 прежняя
```