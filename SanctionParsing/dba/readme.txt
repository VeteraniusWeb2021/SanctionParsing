Воссоздать базу из дампа filled.dump или 
выполнить скрипты в файлах для создания базы с нуля:

create_sanctions.sql - 		создание таблиц
fn_new_fill_head_tables.sql-    заполнение основных таблиц
fn_one_fill_add_tables.sql-     заполнение дополнитльных таблиц
get_person.sql-			создание функций
get_organizations.sql-		создание функций
get_company.sql-		создание функций
get_vessel.sql-			создание функций
get_airplane.sql-		создание функций
fn_get_by_id_json.sql-		создание функций
fn_get_pages.sql-		создание функций

После заполнения и создания функций они будут доступны в базе.

Путь к файлам с данными C:\Essence_files\название файла

В схеме sanctions есть функции
fn_delete_all_data_from_tables()-удалить данные со всех таблиц. Из кантри и топикс не удаляются записи;
fn_new_fill_head_tables()-заполнение таблиц основных;
fn_one_fill_add_tables()-заполнение вспомогательных таблиц;
fn_get_page(q int,n int) - получает в аргументы количество строк на странице и номер страницы.
	      Выдает результат в виде таблицы.
fn_get_page_json(q int,n int) - аргументы те же, но результат в виде json.
fn_get_by_id_json(id_int int)-  аргументом служит номер записи в базе данных.