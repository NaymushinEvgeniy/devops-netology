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

command = "nslookup "
url = sys.argv[1]
answers = os.popen(command + url)
answers = answers.read().split("\n")

f = open('bd.txt', 'r')

old_ips = f.readlines()

f.close()

f = open('bd.txt', 'a+')

for answer in answers:
    answer.replace("\t", "")
    if answer.find("Address") != -1 and answer.find("127.0.0") == -1:
        if (answer + '\n') in old_ips:
            print('Ip адрес ресурса ' + url + (' ') + answer + ' прежний, можно работать')
        else:
            print('ERROR Внимание! IP адрес ресурса ' + url + ' изменился! В БД добвален новый адрес: ' + answer)
            f.write(answer + '\n')
f.close()
```

Вывод скрипта при запуске при тестировании:
```python
Ip адрес ресурса google.com Address: 74.125.205.100 прежний, можно работать
Ip адрес ресурса google.com Address: 74.125.205.102 прежний, можно работать
Ip адрес ресурса google.com Address: 74.125.205.101 прежний, можно работать
Ip адрес ресурса google.com Address: 74.125.205.139 прежний, можно работать
Ip адрес ресурса google.com Address: 74.125.205.113 прежний, можно работать
Ip адрес ресурса google.com Address: 74.125.205.138 прежний, можно работать
ERROR Внимание! IP адрес ресурса google.com изменился! В БД добвален новый адрес: Address: 2a00:1450:4010:c05::66
ERROR Внимание! IP адрес ресурса google.com изменился! В БД добвален новый адрес: Address: 2a00:1450:4010:c05::8a
ERROR Внимание! IP адрес ресурса google.com изменился! В БД добвален новый адрес: Address: 2a00:1450:4010:c05::8b
ERROR Внимание! IP адрес ресурса google.com изменился! В БД добвален новый адрес: Address: 2a00:1450:4010:c05:
```