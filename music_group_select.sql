# количество исполнителей в каждом жанре
SELECT name, COUNT(artist_id) FROM genre_to_artist
JOIN genre ON genre_to_artist.genre_id = genre.id
GROUP BY name;

# количество треков, вошедших в альбомы 2007-2010 годы
SELECT COUNT(track.name) FROM track
JOIN album ON album.id = track.album_id
WHERE year_of_release BETWEEN 2007 AND 2010;

# средняя продолжительность треков по каждому альбому
SELECT album.name, AVG(track.duration) FROM track
JOIN album ON album.id = track.album_id
GROUP BY album.name;

# все исполнители, которые не выпустили альбомы в 2008 году
SELECT name FROM artist
WHERE id NOT IN (SELECT artist_id FROM album_to_artist
	JOIN album ON album_to_artist.album_id = album.id
	WHERE year_of_release = 2008);

# названия сборников, в которых присутствует конкретный исполнитель (выберите сами)
SELECT DISTINCT collection.name FROM collection
JOIN track_to_collection ON collection.id = track_to_collection.collection_id
JOIN track ON track_to_collection.track_id = track.id
JOIN album ON track.album_id = album.id
JOIN album_to_artist ON track.album_id = album_to_artist.album_id
JOIN artist ON album_to_artist.artist_id = artist.id
WHERE artist.name = 'Metallica';

# название альбомов, в которых присутствуют исполнители более 1 жанра
SELECT album.name, artist.name FROM album
JOIN album_to_artist ON album.id = album_to_artist.album_id
JOIN artist ON album_to_artist.artist_id = artist.id
JOIN genre_to_artist ON artist.id = genre_to_artist.artist_id
JOIN genre ON genre_to_artist.genre_id = genre.id
GROUP BY album.name
HAVING COUNT(genre.name) > 1;

# наименование треков, которые не входят в сборники
SELECT name FROM track
LEFT JOIN track_to_collection ON track.id = track_to_collection.track_id
WHERE collection_id IS NULL;

# исполнителя(-ей), написавшего самый короткий по продолжительности трек
SELECT artist.name FROM artist
JOIN album_to_artist ON album_to_artist.artist_id = artist.id
JOIN album ON album_to_artist.album_id = album.id
JOIN track ON album.id = track.album_id
WHERE duration = (SELECT MIN(duration) FROM track);

# название альбомов, содержащих наименьшее количество треков
SELECT album.name FROM album
JOIN track ON track.album_id = album.id
GROUP BY album.name
HAVING COUNT(track.id) = (SELECT MIN(COUNT) FROM (SELECT COUNT(id) FROM track
	GROUP BY album_id) AS Foo);