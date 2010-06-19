CREATE OR REPLACE VIEW items_people_extra_names AS 
(SELECT i.id AS item_id, p.id AS people_extra_name_id, alternative_name_400a 
	FROM items i, people_extra_names p WHERE p.person_id=i.person_id); 
