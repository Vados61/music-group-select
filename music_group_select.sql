SELECT genre.name, COUNT(genre_to_artist.artist_id) FROM genre_to_artist
JOIN genre ON genre_to_artist.genre_id = genre.id
GROUP BY genre.name;

SELECT COUNT(name) FROM track
WHERE album_id IN (SELECT id FROM album
	WHERE year_of_release BETWEEN 2007 AND 2010);

SELECT album.name, AVG(track.duration) FROM track
JOIN album ON album.id = track.album_id
GROUP BY album.name;

SELECT name FROM artist
WHERE id IN (SELECT album_to_artist.artist_id FROM album
	JOIN album_to_artist ON album.id = album_to_artist.album_id
	WHERE year_of_release != 2008
	GROUP BY album_to_artist.artist_id);

SELECT DISTINCT collection.name FROM collection
JOIN track_to_collection ON collection.id = track_to_collection.collection_id
WHERE track_to_collection.track_id IN (SELECT id FROM track
	WHERE album_id IN (SELECT album_id FROM album_to_artist
		WHERE artist_id = (SELECT id FROM artist
			WHERE name LIKE 'Гуф')));

SELECT album.name FROM album
JOIN album_to_artist ON album.id = album_to_artist.album_id
WHERE album_to_artist.artist_id IN (SELECT artist_id FROM genre_to_artist
	GROUP BY artist_id
	HAVING COUNT(genre_id) > 1)
GROUP BY album.name;

SELECT name FROM track
WHERE id NOT IN (SELECT track_id FROM track_to_collection
	GROUP BY track_id);

SELECT artist.name FROM album_to_artist
JOIN artist ON album_to_artist.artist_id = artist.id
WHERE album_id IN (SELECT album_id FROM track
	WHERE duration = (SELECT MIN(duration) FROM track));

SELECT album.name FROM track
JOIN album ON track.album_id = album.id
GROUP BY album.name
HAVING COUNT(track.id) = (SELECT MIN(count) FROM (SELECT album_id, COUNT(id) FROM track
		GROUP BY album_id) AS foo);