���������� ���� �� ����� filled.dump ��� 
��������� ������� � ������ ��� �������� ���� � ����:

create_sanctions.sql - 		�������� ������
fn_new_fill_head_tables.sql-    ���������� �������� ������
fn_one_fill_add_tables.sql-     ���������� ������������� ������
get_person.sql-			�������� �������
get_organizations.sql-		�������� �������
get_company.sql-		�������� �������
get_vessel.sql-			�������� �������
get_airplane.sql-		�������� �������
fn_get_by_id_json.sql-		�������� �������
fn_get_pages.sql-		�������� �������

����� ���������� � �������� ������� ��� ����� �������� � ����.

���� � ������ � ������� C:\Essence_files\�������� �����

� ����� sanctions ���� �������
fn_delete_all_data_from_tables()-������� ������ �� ���� ������. �� ������ � ������ �� ��������� ������;
fn_new_fill_head_tables()-���������� ������ ��������;
fn_one_fill_add_tables()-���������� ��������������� ������;
fn_get_page(q int,n int) - �������� � ��������� ���������� ����� �� �������� � ����� ��������.
	      ������ ��������� � ���� �������.
fn_get_page_json(q int,n int) - ��������� �� ��, �� ��������� � ���� json.
fn_get_by_id_json(id_int int)-  ���������� ������ ����� ������ � ���� ������.