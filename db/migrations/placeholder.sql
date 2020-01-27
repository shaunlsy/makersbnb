CREATE TABLE users(user_id SERIAL PRIMARY KEY, username VARCHAR);

CREATE TABLE listings(listing_id SERIAL PRIMARY KEY, list_name VARCHAR, user_id_fk INTEGER REFERENCES users(user_id));
