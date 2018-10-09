-- DEPENDENCY: I refer to metabase2.DataSetVariables2, a table containing a di,ei,ai. If you do not have Metabase, 
-- use this (un-comment) and change metabase2 to scratch in the last foreign key of the last table. 
/*
create table scratch."DataSetVariables2"(
dataset_id integer,
entity_id integer,
attribute_id integer,
constraint fake_dsvars2_pk primary key (dataset_id, entity_id, attribute_id)
);*/

-- Suggestion for database tables to hold semantic annotation terms for dataTable columns, aka attributes. 
-- Partly generalized, partly specific to Metabase 
-- (just in referencing the DataSetVariables2 table)

create table scratch.semantic_annotation_vocabularies(
vocab_id character varying primary key,
vocab_label text,
vocab_domain text,
vocab_notes text);

-- label is for humans to read. Maybe it is not necessary since the acronyms may be well known?
-- domain is the science domain: ecology, geology, oceanography, geography,... or even subsets of those
-- notes might be "seldom used". Or how stable/persistent the URIs will be? 
-- should I add a column here for how the URI is constructed?  Or put that in notes if it is descriptive, not a formula. Do they all follow the same formula? 

create table scratch.semantic_annotation_terms_dictionary(
vocab_id character varying,
term_id integer,
constraint semantic_annotation_terms_dictionary_pk primary key (vocab_id, term_id),
constraint semantic_annotation_terms_dictionary_fk foreign key (vocab_id) references scratch.semantic_annotation_vocabularies (vocab_id) match simple 
on update cascade on delete no action
); 

-- I considered adding another column of free text to define the term but decided it is better (more maintainable) to refer to definitions via the URI.
-- I also considered adding a URI column here but decided it is cleaner to instead describe how those are formed in the vocabularies table. 

create table scratch.semantic_annotation_xref_attribute(
dataset_id integer,
entity_id integer,
attribute_id integer,
vocab_id character varying,
term_id integer,
constraint semantic_annotation_xref_attribute_pk primary key (dataset_id, entity_id, attribute_id, vocab_id, term_id),
constraint semantic_annotation_xref_attribute_fk_term foreign key (vocab_id, term_id) references scratch.semantic_annotation_terms_dictionary (vocab_id, term_id) match simple
on update cascade on delete no action,
constraint semantic_annotation_xref_attribute_fk_att foreign key (dataset_id, entity_id, attribute_id) references metabase2."DataSetVariables2" ("DataSetID", "EntitySortOrder", "ColumnPosition") match simple
on update cascade on delete no action
);*/