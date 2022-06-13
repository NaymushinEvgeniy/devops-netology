# Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform."

### Задача 1 (вариант с AWS). Регистрация в aws и знакомство с основами.
В виде результата задания приложите вывод команды aws configure list.

        PS C:\Users\evgen> aws configure list
        Name                    Value             Type    Location
        ----                    -----             ----    --------
        profile                <not set>             None    None
        access_key     ****************PJ2F shared-credentials-file
        secret_key     ****************BRrm shared-credentials-file
        region             eu-central-1      config-file    ~/.aws/config

### Задача 2. Создание aws ec2  через терраформ.

		Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following      
		symbols:
		  + create

		Terraform will perform the following actions:

		# aws_instance.netology_ubuntu will be created
		+ resource "aws_instance" "netology_ubuntu" {
			+ ami                                  = "ami-0459211f1f588afbf"
			+ arn                                  = (known after apply)
			+ associate_public_ip_address          = (known after apply)
			+ availability_zone                    = (known after apply)
			+ cpu_core_count                       = (known after apply)
			+ cpu_threads_per_core                 = (known after apply)
			+ disable_api_termination              = (known after apply)
			+ ebs_optimized                        = (known after apply)
			+ get_password_data                    = false
			+ host_id                              = (known after apply)
			+ id                                   = (known after apply)
			+ instance_initiated_shutdown_behavior = (known after apply)
			+ instance_state                       = (known after apply)
			+ instance_type                        = "t3.micro"
			+ ipv6_address_count                   = (known after apply)
			+ ipv6_addresses                       = (known after apply)
			+ key_name                             = (known after apply)
			+ monitoring                           = (known after apply)
			+ outpost_arn                          = (known after apply)
			+ password_data                        = (known after apply)
			+ placement_group                      = (known after apply)
			+ placement_partition_number           = (known after apply)
			+ primary_network_interface_id         = (known after apply)
			+ private_dns                          = (known after apply)
			+ private_ip                           = (known after apply)
			+ public_dns                           = (known after apply)
			+ public_ip                            = (known after apply)
			+ secondary_private_ips                = (known after apply)
			+ security_groups                      = (known after apply)
			+ source_dest_check                    = true
			+ subnet_id                            = (known after apply)
			+ tags_all                             = (known after apply)
			+ tenancy                              = (known after apply)
			+ user_data                            = (known after apply)
			+ user_data_base64                     = (known after apply)
			+ vpc_security_group_ids               = (known after apply)

			+ capacity_reservation_specification {
				+ capacity_reservation_preference = (known after apply)

				+ capacity_reservation_target {
					+ capacity_reservation_id = (known after apply)
					  }
					  }

			+ ebs_block_device {
				+ delete_on_termination = (known after apply)
				+ device_name           = (known after apply)
				+ encrypted             = (known after apply)
				+ iops                  = (known after apply)
				+ kms_key_id            = (known after apply)
				+ snapshot_id           = (known after apply)
				+ tags                  = (known after apply)
				+ throughput            = (known after apply)
				+ volume_id             = (known after apply)
				+ volume_size           = (known after apply)
				+ volume_type           = (known after apply)
				  }

			+ enclave_options {
				+ enabled = (known after apply)
				  }

			+ ephemeral_block_device {
				+ device_name  = (known after apply)
				+ no_device    = (known after apply)
				+ virtual_name = (known after apply)
				  }

			+ metadata_options {
				+ http_endpoint               = (known after apply)
				+ http_put_response_hop_limit = (known after apply)
				+ http_tokens                 = (known after apply)
				+ instance_metadata_tags      = (known after apply)
				  }

			+ network_interface {
				+ delete_on_termination = (known after apply)
				+ device_index          = (known after apply)
				+ network_interface_id  = (known after apply)
				  }

			+ root_block_device {
				+ delete_on_termination = (known after apply)
				+ device_name           = (known after apply)
				+ encrypted             = (known after apply)
				+ iops                  = (known after apply)
				+ kms_key_id            = (known after apply)
				+ tags                  = (known after apply)
				+ throughput            = (known after apply)
				+ volume_id             = (known after apply)
				+ volume_size           = (known after apply)
				+ volume_type           = (known after apply)
				  }
				  }

		Plan: 1 to add, 0 to change, 0 to destroy.

		Changes to Outputs:
		+ account_id          = "117706182192"
			+ network_id          = (known after apply)
			+ private_ip_instance = (known after apply)
			+ region              = "eu-central-1"
			+ user_id             = "117706182192"

		Do you want to perform these actions?
		Terraform will perform the actions described above.
		Only 'yes' will be accepted to approve.

		Enter a value: yes

		aws_instance.netology_ubuntu: Creating...
		aws_instance.netology_ubuntu: Still creating... [10s elapsed]
		aws_instance.netology_ubuntu: Still creating... [20s elapsed]
		aws_instance.netology_ubuntu: Still creating... [30s elapsed]
		aws_instance.netology_ubuntu: Creation complete after 33s [id=i-0f62b8dbc29636814]

		Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

		Outputs:

		account_id = "117706182192"
		network_id = "subnet-04a604cc47f390aa7"
		private_ip_instance = "172.31.15.190"
		region = "eu-central-1"
		user_id = "117706182192"

Ответ на вопрос: при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami:

Свой ami образ можно создать при помощи инструмента packer

Ссылка на репозиторий с исходной конфигурацией терраформа:

https://github.com/NaymushinEvgeniy/devops-netology/tree/main/terraform

