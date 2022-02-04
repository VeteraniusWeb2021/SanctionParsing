 create table public.person_caption
 (person_id varchar,
 caption_id varchar,
 primary key (person_id,caption_id),
 foreign key (person_id) references public.person(general_id),
 foreign key (caption_id) references public.entities(id)
 );
 
insert into public.person_caption values 
('NK-2QtbU49vp9LkfKRjd8WQni','NK-2CHqNtWeErMHi5i8RPCqC7'),
('NK-2QtbU49vp9LkfKRjd8WQni','NK-2ZUrGJDocRY3AQBHSbpKg5');

('addr-007fdb0e3654fc794a3f4e347f5b68882dbf3df5','addr-06498413e23bd8d4119519f68f303aef376785eb'),
('addr-007fdb0e3654fc794a3f4e347f5b68882dbf3df5','addr-068f144b51f04dc969702315a48947ce55b5c8cd');

select p.*,e.caption ,e.first_seen ,e.referents ,e.schema ,e.target from public.person p
join public.person_caption pc on pc.person_id = p.general_id 
join public.entities e on e.id = pc.caption_id ;

select p.caption ,p.first_seen ,p.general_id ,p.country ,array_agg(e.caption) ,array_agg(e.first_seen)from public.person p
join public.person_caption pc on pc.person_id = p.general_id 
join public.entities e on e.id = pc.caption_id 
group by p.caption ,p.first_seen ,p.general_id ,p.country ;

select row_to_json(t) from  (select p.caption ,p.first_seen ,p.general_id ,p.country, (array_agg(e.caption) ,array_agg(e.first_seen) ) as properties
from public.person p
join public.person_caption pc on pc.person_id = p.general_id 
join public.entities e on e.id = pc.caption_id 
group by p.caption ,p.first_seen ,p.general_id ,p.country ) as t;

copy (select row_to_json(t) from  (select p.caption ,p.first_seen ,p.general_id ,p.country ,(array_agg(e.caption) ,array_agg(e.first_seen) ) as properties
from public.person p
join public.person_caption pc on pc.person_id = p.general_id 
join public.entities e on e.id = pc.caption_id 
group by p.caption ,p.first_seen ,p.general_id ,p.country ) as t) 
to 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\test\ok_json.json';


create table public.test_entities_referents
(entities varchar,
referents varchar,
primary key(entities,referents));

insert into public.test_entities_referents (select p.id ,unnest (p.referents) from sanctions.entities p) on conflict do nothing;

select *, from public.test_entities_referents t ;

select p.general_id ,unnest (p.referents) from sanctions.entities p ;



