� ����� sanctions ���� �������
fn_delete_all_data_from_tables-������� ������ �� ���� ������. �� ������ � ������ �� ��������� ������;
fn_new_fill_head_tables-���������� ������ ��������;
fn_one_fill_add_tables-���������� ��������������� ������;

��������� ������� � ������ ��� �������� ���� � ����:
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

���� � ����� ����������� ��� �������, �� �� ����� ������� �� ��������������� �������.


���� � ������ � ������� C:\Essence_files\�������� �����
��� ������� ���� �� ����� filled.dump.

fn_get_page - �������� � ��������� ���������� ����� �� �������� � ����� ��������.
	      ������ ��������� � ���� �������.
fn_get_page_json - ��������� �� ��, �� ��������� � ���� json.