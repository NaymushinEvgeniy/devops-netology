# Домашнее задание к занятию "7.4. Средства командной работы над инфраструктурой."

### Задача 2. Написать серверный конфиг для атлантиса.

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

atlantis.yaml

    version: 3
    workflows: {stage,prod}
    projects:
    - dir: .
      workspace: stage
      autoplan:
        when_modified: ["*.tf"]
    - dir: .
      workspace: prod
      autoplan:
        when_modified: ["*.tf"]

### Задача 3. Знакомство с каталогом модулей.

Cсылка на созданный блок конфигураций:
https://github.com/NaymushinEvgeniy/devops-netology/tree/main/terraform