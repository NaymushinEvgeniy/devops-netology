# Домашнее задание к занятию "7.1. Инфраструктура как код"
### Задача 1. Выбор инструментов.
1. Для общего описания, с прицелом на развитие, будем использовать изменяемую инфраструктуру, описанную в Terraform,
а в качестве core-платформ для сервисов будем использовать элементы неизменяемой инфраструктуры - Packer образы
2. В рамках нового проекта в целях упрощения и экономии целесообразней не использовать центральный сервер для
управления инфраструктурой, опишем инфраструктуру на базе Ansible и будем хранить ее в SCM
3. При таком подходе агенты на серверах не требуются, достаточно настроить SSH авторизацию
4. Будут использованы как средства управления конфигураций (сборка и деплой проектов средствам Ansible и Teamcity, 
взаимодействие с Kubernetes), так и средства инициализации ресурсов (Terraform)

### Задача 2.

    terraform --version
    Terraform v1.1.6
    on windows_amd64

### Задача 3.

    C:\Users\evgen>terraform --version
    Terraform v1.2.2
    on windows_amd64

    C:\Users\evgen>terraform_old --version
    Terraform v1.1.6
    on windows_amd64

    Your version of Terraform is out of date! The latest version
    is 1.2.2. You can update by downloading from https://www.terraform.io/downloads.html



























