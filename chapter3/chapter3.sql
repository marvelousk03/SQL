CREATE TABLE char_data_types (
    varchar_column varchar(10),
    char_column char(10),
    text_column text
);

INSERT INTO char_data_types
VALUES
    ('abc', 'abc', 'abc'),
    ('defghi', 'defghi', 'defghi');

COPY char_data_types TO 'C:\Bootcamp\sql\mycode\chapter3\typetest.txt'
WITH (FORMAT CSV, HEADER, DELIMITER '|');


INSERT INTO char_data_types
VALUES
	('1234567890', '1234567890', 'this is a text' )
