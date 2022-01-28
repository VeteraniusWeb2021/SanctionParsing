 create table sanctions.person_caption
 (person_id varchar,
 caption_id varchar,
 primary key (person_id,caption_id),
 foreign key (person_id) references sanctions.person(general_id),
 foreign key (caption_id) references sanctions.entities(id)
 );
 
insert into sanctions.person_caption values 
('NK-2QtbU49vp9LkfKRjd8WQni','addr-04a17d22124400ad9222dd03a9c8175ae1815669'),
('NK-2QtbU49vp9LkfKRjd8WQni','addr-05fa58176c94fea95eda5b89e2a6296da9e4eebf'),
('addr-007fdb0e3654fc794a3f4e347f5b68882dbf3df5','addr-06498413e23bd8d4119519f68f303aef376785eb'),
('addr-007fdb0e3654fc794a3f4e347f5b68882dbf3df5','addr-068f144b51f04dc969702315a48947ce55b5c8cd');

select p.*,e.caption ,e.first_seen ,e.referents ,e.schema ,e.target from sanctions.person p
join sanctions.person_caption pc on pc.person_id = p.general_id 
join sanctions.entities e on e.id = pc.caption_id ;

select p.caption ,p.first_seen ,p.general_id ,p.country ,array_agg(e.caption) ,array_agg(e.first_seen)from sanctions.person p
join sanctions.person_caption pc on pc.person_id = p.general_id 
join sanctions.entities e on e.id = pc.caption_id 
group by p.caption ,p.first_seen ,p.general_id ,p.country ;

select row_to_json(t) from  (select p.caption ,p.first_seen ,p.general_id ,p.country, (array_agg(e.caption) ,array_agg(e.first_seen) ) as properties
from sanctions.person p
join sanctions.person_caption pc on pc.person_id = p.general_id 
join sanctions.entities e on e.id = pc.caption_id 
group by p.caption ,p.first_seen ,p.general_id ,p.country ) as t;

copy (select row_to_json(t) from  (select p.caption ,p.first_seen ,p.general_id ,p.country ,(array_agg(e.caption) ,array_agg(e.first_seen) ) as properties
from sanctions.person p
join sanctions.person_caption pc on pc.person_id = p.general_id 
join sanctions.entities e on e.id = pc.caption_id 
group by p.caption ,p.first_seen ,p.general_id ,p.country ) as t) 
to 'D:\Downloads\veteranius\veteranius-vcs\vcs\SanctionParsing\SanctionParsing\dba\test\ok_json.json';


select p.general_id ,unnest (p.country) from sanctions.person p ;





