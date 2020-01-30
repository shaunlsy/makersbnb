CREATE TABLE users
(
  user_id SERIAL PRIMARY KEY,
  username VARCHAR,
  email VARCHAR,
  password VARCHAR
);

CREATE TABLE listings
(
  listing_id SERIAL PRIMARY KEY,
  list_name VARCHAR,
  user_id_fk INTEGER REFERENCES users(user_id),
  short_description VARCHAR,
  price_per_night INTEGER
);

CREATE TABLE bookings
(
  booking_id SERIAL PRIMARY KEY,
  listing_id_fk INTEGER REFERENCES listings(listing_id),
  user_id_fk INTEGER REFERENCES users(user_id),
  start_date DATE,
  end_date DATE,
  confirmation BOOLEAN
);


CREATE TABLE messages
(
  message_id SERIAL PRIMARY KEY,
  receiver_id_fk INTEGER REFERENCES users(user_id),
  messenger_id_fk INTEGER REFERENCES users(user_id),
  message VARCHAR,
  time_inserted TIMESTAMP DEFAULT current_timestamp
)