#Домашнее задание к занятию "7.4. Средства командной работы над инфраструктурой."

###Задача 2. Написать серверный конфиг для атлантиса.

server.yaml

    repos:
      - id: github.com/NaymushinEvgeniy/atlantis-example
        apply_requirements: [approved]
        allowed_workflows: [default]
        allowed_overrides: [workflow]
    workflows:
      default:
        plan:
          steps:
          - plan:
              extra_args: ["-lock", "false"]