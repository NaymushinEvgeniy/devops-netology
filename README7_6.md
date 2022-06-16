#Домашнее задание к занятию "7.6. Написание собственных провайдеров для Terraform."

###Задача 1.

1. Найдите, где перечислены все доступные resource и data_source, приложите ссылку на эти строки в коде на гитхабе

Указанные ресурсы импортируются в модуль main.go в виде 
        
        import (
        "github.com/hashicorp/terraform-provider-aws/internal/provider"
        )

Переходим по этому модулю:

https://github.com/hashicorp/terraform-provider-aws/blob/main/internal/provider/provider.go

Далее смотрим строку 423 где добавляется Map всех типов resource и data_source:

        DataSourcesMap: map[string]*schema.Resource{...}

2. Для создания очереди сообщений SQS используется ресурс aws_sqs_queue у которого есть параметр name.

- С каким другим параметром конфликтует name? Приложите строчку кода, в которой это указано:

        82 "name": {
            ...
            ConflictsWith: []string{"name_prefix"},

  https://github.com/hashicorp/terraform-provider-aws/blob/1b898de12d612ab76eeab0580b29252b004d6392/internal/service/sqs/queue.go#L169
 
- Какая максимальная длина имени?

    127 символов

        58: ValidateFunc: validation.StringLenBetween(1, 127),

  https://github.com/hashicorp/terraform-provider-aws/blob/1b898de12d612ab76eeab0580b29252b004d6392/internal/service/connect/queue.go#L20

- Какому регулярному выражению должно подчиняться имя?

        name = create.NameWithSuffix(d.Get("name").(string), d.Get("name_prefix").(string), FIFOQueueNameSuffix)

  https://github.com/hashicorp/terraform-provider-aws/blob/1b898de12d612ab76eeab0580b29252b004d6392/internal/service/sqs/queue.go#L169