CREATE TABLE genre(
	id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(40) NOT NULL
);

CREATE TABLE artist(
	id SERIAL PRIMARY KEY,
	name VARCHAR(40) NOT NULL
);

CREATE TABLE genre_to_artist(
	genre_id INTEGER REFERENCES genre(id),
	artist_id INTEGER REFERENCES artist(id),
	CONSTRAINT artist_in_genre PRIMARY KEY(genre_id, artist_id)
);

CREATE TABLE album(
	id SERIAL PRIMARY KEY, 
	name VARCHAR(40) NOT NULL, 
	year_of_release INTEGER CHECK (year_of_release >= 1500)
);

CREATE TABLE album_to_artist(
	artist_id INTEGER REFERENCES artist(id),
	album_id INTEGER REFERENCES album(id),
	CONSTRAINT artist_in_album PRIMARY KEY(album_id, artist_id)
);

CREATE TABLE track(
	id SERIAL PRIMARY KEY, 
	name VARCHAR(40) NOT NULL,
	album_id INTEGER REFERENCES album(id),
	duration TIME NOT NULL
);

CREATE TABLE collection(
	id SERIAL PRIMARY KEY, 
	name VARCHAR(40) NOT NULL,
	year_of_release INTEGER CHECK (year_of_release >= 1500)
);

CREATE TABLE track_to_collection(
	collection_id INTEGER REFERENCES collection(id),
	track_id INTEGER REFERENCES track(id),
	CONSTRAINT track_in_collection PRIMARY KEY(collection_id, track_id)
);