# Домашнее задание по лекции "Операционные системы (лекция 1)"
1.
см Screenshot_dz3.4

2. 
CPU:
node_cpu_seconds_total{cpu="0",mode="user"} - Время выполнения процессов в редиме пользователя
node_cpu_seconds_total{cpu="0",mode="system"} - Время выполнения просессов в режиме ядра
node_cpu_seconds_total{cpu="0",mode="iowait"} - Время ожидания подсистемы ввода вывода

Memory:
node_memory_MemAvailable_bytes - Память с буфером и кешем
node_memory_MemFree_bytes - Память без учета кешей и буферов
node_memory_SwapFree_bytes - Доступная память в swap-е
node_memory_Buffers_bytes - объем буфера 
node_memory_Cached_bytes - объем кэша

Disk
node_disk_io_now - время выполнения операций I/O
node_disk_reads_completed_total - успешные операции чтения
node_disk_writes_completed_total - успешные операции записи
node_filesystem_avail_bytes - доступно места в файловой системе

Network:
node_network_receive_bytes_total - получено байт
node_network_transmit_bytes_total - передано байт
node_network_up - состояние интерфейса

3.
см Screenshot_dz3.4_3

4.
Да,
dmesg | grep -i virtual

5.
fs.nr_open - hard лимит на максимальное количество дескрипторов файлов
По умолчанию - 1024*1024 = 1048576
 soft лимит (по умолчанию 1024) не даст достичь такого числа

6.
см Screenshot_dz3.4_6

7. 
:(){ :|: };: - так называемая fork-бомба - анонимная функция, бесконечно создающая рекурентно свои же копии, потребляя все доступные ресурсы
Согласно dmesg ее исполнение прервыается ядром посредством механизма cgroup (fork rejected by pids controller)
Ограничить число процессов можно посредством инструмента лимитов: ulimit.