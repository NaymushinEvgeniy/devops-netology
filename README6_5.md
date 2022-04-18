# Домашнее задание к занятию "6.5. Elasticsearch"

### Задача 1

Текст Dockerfile манифеста:

        FROM centos
        
        WORKDIR /etc/yum.repos.d/
        RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
        WORKDIR /opt/elc
        RUN yum install java-11-openjdk -y &&\
            yum install perl-Digest-SHA -y
        
        COPY elasticsearch-8.1.2-linux-x86_64.tar.gz .
        RUN tar -xzf elasticsearch-8.1.2-linux-x86_64.tar.gz
        WORKDIR elasticsearch-8.1.2
        
        ENV JAVA_HOME /opt/elc/elasticsearch-8.1.2/jdk/
        ENV PATH=/usr/lib:/usr/lib/jvm/jre-11/bin:/opt/elc/elasticsearch-8.1.2/bin:$PATH
        
        COPY login.txt .
        RUN groupadd elasticsearch && useradd -g elasticsearch elasticsearch && cat login.txt | chpasswd
        RUN chown -R elasticsearch:elasticsearch /opt/elc/elasticsearch-8.1.2
        RUN mkdir /var/lib/logs &&\
            chown elasticsearch:elasticsearch /var/lib/logs &&\
            mkdir /var/lib/data &&\
            chown elasticsearch:elasticsearch /var/lib/data
        COPY elasticsearch.yml ./config/elasticsearch.yml
        RUN chown elasticsearch:elasticsearch ./config/elasticsearch.yml
        USER elasticsearch
        CMD "elasticsearch"
        EXPOSE 9200 9300

Ответ elasticsearch на запрос пути / в json виде:

        [root@docker-ctl elc]# curl --cacert cert -u elastic -X GET 'https://127.0.0.1:9200'
        Enter host password for user 'elastic':
        {
          "name" : "netology_test",
          "cluster_name" : "elasticsearch",
          "cluster_uuid" : "hE4g0K-xQnmdFZzODVgZqA",
          "version" : {
            "number" : "8.1.2",
            "build_flavor" : "default",
            "build_type" : "tar",
            "build_hash" : "31df9689e80bad366ac20176aa7f2371ea5eb4c1",
            "build_date" : "2022-03-29T21:18:59.991429448Z",
            "build_snapshot" : false,
            "lucene_version" : "9.0.0",
            "minimum_wire_compatibility_version" : "7.17.0",
            "minimum_index_compatibility_version" : "7.0.0"
          },
          "tagline" : "You Know, for Search"
        }

### Задача 2

Получите список индексов и их статусов, используя API и приведите в ответе на задание.

        curl -X GET https://127.0.0.1:9200/ind-1,ind-2,ind-3
        
        {
            "ind-1": {
                "aliases": {},
                "mappings": {},
                "settings": {
                    "index": {
                        "routing": {
                            "allocation": {
                                "include": {
                                    "_tier_preference": "data_content"
                                }
                            }
                        },
                        "number_of_shards": "1",
                        "provided_name": "ind-1",
                        "creation_date": "1650289677069",
                        "number_of_replicas": "0",
                        "uuid": "YdDljVX1Q0iXvyo8qlEQ2g",
                        "version": {
                            "created": "8010299"
                        }
                    }
                }
            },
            "ind-2": {
                "aliases": {},
                "mappings": {},
                "settings": {
                    "index": {
                        "routing": {
                            "allocation": {
                                "include": {
                                    "_tier_preference": "data_content"
                                }
                            }
                        },
                        "number_of_shards": "2",
                        "provided_name": "ind-2",
                        "creation_date": "1650289742033",
                        "number_of_replicas": "1",
                        "uuid": "a06zW9QUTAegx8ZfHGZi4A",
                        "version": {
                            "created": "8010299"
                        }
                    }
                }
            },
            "ind-3": {
                "aliases": {},
                "mappings": {},
                "settings": {
                    "index": {
                        "routing": {
                            "allocation": {
                                "include": {
                                    "_tier_preference": "data_content"
                                }
                            }
                        },
                        "number_of_shards": "4",
                        "provided_name": "ind-3",
                        "creation_date": "1650289768232",
                        "number_of_replicas": "2",
                        "uuid": "XOhovTAhTdGzSGPRK7nmNw",
                        "version": {
                            "created": "8010299"
                        }
                    }
                }
            }
        }

Получите состояние кластера elasticsearch, используя API.

        {
            "cluster_name": "elasticsearch",
            "status": "yellow",
            "timed_out": false,
            "number_of_nodes": 1,
            "number_of_data_nodes": 1,
            "active_primary_shards": 9,
            "active_shards": 9,
            "relocating_shards": 0,
            "initializing_shards": 0,
            "unassigned_shards": 10,
            "delayed_unassigned_shards": 0,
            "number_of_pending_tasks": 0,
            "number_of_in_flight_fetch": 0,
            "task_max_waiting_in_queue_millis": 0,
            "active_shards_percent_as_number": 47.368421052631575
        }

Кластер находится в состояние yelow поскольку мы имеем только одну ноду