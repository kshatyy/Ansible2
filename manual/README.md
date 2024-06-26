Описание playbook:

Этот playbook разбит на два основных блока задач:

Установка ClickHouse:

В этом разделе происходит установка ClickHouse на тех серверах, которые находятся в группе clickhouse. Мы выполняем задачи по загрузке пакета ClickHouse и его последующей установке через менеджер пакетов. Затем идут задачи по управлению службой ClickHouse, созданию базы данных и перезапуску службы при необходимости.

Установка Vector:

Этот раздел отвечает за установку Vector на серверах, определенных в группе vector. Мы выполняем задачи по загрузке пакета Vector, его установке и созданию необходимой директории. Затем мы распаковываем пакет в эту директорию. Для создания конфигурационного файла vector.toml мы используем шаблон из файла vector.j2. Наконец, мы запускаем Vector с указанием пути к конфигурационному файлу.

Использование тегов clickhouse и vector позволяет разделять задачи и запускать только нужные части playbook'а.
