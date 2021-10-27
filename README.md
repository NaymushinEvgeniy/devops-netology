# devops-netology
Learn Devops

First modify

Добавлены в .gitignore файлы:
1) **/.terraform/* - директория с именем .terraform любой вложености относительно корневой и все что внутри нее
2) *.tfstate и *.tfstate.* - файлы с указанными расширениями включая с расширенными (tfstate.*)
3) файл (лог) с именем crash.log
4) файлы с расширенем *.tfvars
5) файлы override.tf и override.tf, и их модификациии с префиксами любой длины (*_override.tf и *_override.tf.json)
6) файлы .terraformrc и terraform.rc