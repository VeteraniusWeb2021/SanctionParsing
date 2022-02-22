В схеме sanctions есть функции
fn_delete_all_data_from_tables-удалить данные со всех таблиц. Из кантри и топикс не удаляются записи;
fn_new_fill_head_tables-заполнение таблиц основных;
fn_one_fill_add_tables-заполнение вспомогательных таблиц;

Выполнить скрипты в файлах для создания базы с нуля:
select public.create_schema_sanctions();
select sanctions.fn_one_new_fill_head_tables();
select sanctions.fn_one_fill_add_tables();
get_person
get_organization
get_company
get_vessel
get_airplane
fn_get_by_id_json
fn_get_pages

Если в схеме отсутствуют эти функции, то их нужно создать из соответсвующего скрипта.


Путь к файлам с данными C:\Essence_files\название файла
Или создать базу из дампа filled.dump.

fn_get_page - получает в аргументы количество строк на странице и номер страницы.
	      Выдает результат в виде таблицы.
fn_get_page_json - аргументы те же, но результат в виде json.