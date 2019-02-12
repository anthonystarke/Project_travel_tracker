DROP TABLE bucket_lists;
DROP TABLE cities;
DROP TABLE countries;

CREATE TABLE countries(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE cities(
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255),
  country_id INT4 REFERENCES countries(id),
  photo_loc VARCHAR(255)
);

CREATE TABLE bucket_lists(
  id SERIAL8 PRIMARY KEY,
  visited BOOLEAN,
  city_id INT4 REFERENCES cities(id)
);
