-- GENERACIÓN DE GRÁFICOS

-- DASHBOARD DE MÚSICA
-- Histórico de Publicaciones
SELECT EXTRACT(YEAR FROM s.released_at) AS "Año de Lanzamiento",
	COUNT(s.id) AS "Canciones" 
FROM songs s
GROUP BY EXTRACT(YEAR FROM s.released_at)
ORDER BY EXTRACT(YEAR FROM s.released_at);

-- Minutos Reproducidos
SELECT ROUND(SUM(mh.listen_duration_sec/60), 2) AS "Minutos" 
FROM media_history mh;

-- Prom Canciones por Lista
SELECT ROUND(COUNT(pc.id_song) / COUNT(DISTINCT pc.id_list)) AS "Promedio" 
FROM playlists_content pc;

-- Reproducciones por Género
SELECT g.genre_name AS "Género", 
	SUM(s.views) AS "Reproducciones"
FROM songs s
JOIN artists a ON a.id = s.id_artist
JOIN genres g ON g.id = a.id_genre
GROUP BY g.genre_name
ORDER BY SUM(s.views) DESC;

-- Canciones Escuchadas
SELECT COUNT(DISTINCT mh.id_song) AS "Escuchadas", 
	COUNT(DISTINCT s.id) AS "Totales" 
FROM media_history mh
RIGHT JOIN songs s ON s.id = mh.id_song;

-- Top 10 Artistas más Escuchados Mensualmente
SELECT a.artist_name AS "Artista", 
	a.monthly_listeners AS "Oyentes"
FROM artists a
ORDER BY a.monthly_listeners DESC
LIMIT 10;

-- TOP 10 Canciones más escuchadas
SELECT s.song_name AS "Canción", 
	COUNT(mh.id_song) AS "Reproducciones"
FROM media_history mh
JOIN songs s ON s.id = mh.id_song
GROUP BY mh.id_song
ORDER BY COUNT(mh.id_song) DESC
LIMIT 10;

-- DASHBOARD DE USUARIOS
-- Histórico de Registros
SELECT EXTRACT(YEAR FROM u.registered_at) AS "Año de Registro",
	COUNT(u.id) "Usuarios"
FROM users u
GROUP BY EXTRACT(YEAR FROM u.registered_at);

-- Usuarios Activos
SELECT COUNT(DISTINCT mh.id_user) AS "Activos"
FROM media_history mh;

-- Usuarios Premium
SELECT COUNT(DISTINCT pu.id_user) AS "Premium", 
	COUNT(DISTINCT u.id) AS "Totales"
FROM premium_users pu
RIGHT JOIN users u ON u.id = pu.id_user;

-- Géneros
SELECT g.gender_name AS "Género", 
	COUNT(u.id) AS "Usuarios",
    ROUND(COUNT(u.id) / (SELECT COUNT(id) FROM users) * 100) AS "%"
FROM users u
JOIN gender g ON g.id = u.id_gender
GROUP BY g.gender_name;

-- Membresías
SELECT pm.membership AS "Membresía",
	COUNT(DISTINCT pu.id_user) AS "Usuarios",
    ROUND(COUNT(pu.id_user) / (SELECT COUNT(id) FROM premium_users) * 100) AS "%"
FROM premium_users pu
JOIN premium_membership pm ON pm.id = pu.id_membership
GROUP BY pm.membership;

-- Usuarios por País
SELECT u.country AS "País",
	COUNT(u.id) AS "Usuarios"
FROM users u
GROUP BY u.country;

-- DASHBOARD DE NOTIFICACIONES
-- Histórico por Envío
SELECT EXTRACT(YEAR FROM sent_at) AS "Fecha de Envío",
	COUNT(n.id) AS "Notificaciones"
FROM notifications n
GROUP BY EXTRACT(YEAR FROM sent_at);

-- Usuarios Notificados
SELECT COUNT(DISTINCT n.id_user) AS "Usuarios"
FROM notifications n;

-- Promedio por Usuario
SELECT ROUND(COUNT(n.id) / COUNT(DISTINCT n.id_user)) AS "Promedio"
FROM notifications n;

-- Notificaciones con Interacción
SELECT COUNT(n.id) AS "Con Interacción",
	(SELECT COUNT(id) FROM notifications) AS "Total"
FROM notifications n
WHERE n.notif_status = 'Leído';

-- Notificaciones por Tipo
SELECT nt.notif_type AS "Template",
	COUNT(n.id) AS "Notificaciones",
    ROUND(COUNT(n.id) / (SELECT COUNT(id) FROM notifications) * 100) AS "%"
FROM notifications n
JOIN notification_template nt ON nt.id = n.id_template
GROUP BY nt.notif_type;

-- Preferencias por Canal
SELECT nc.notif_channel AS "Canal",
    COUNT(np.id) AS "Usuarios",
    ROUND(COUNT(np.id) / (SELECT COUNT(id) FROM notification_preferences) * 100) AS "%"
FROM notification_channels nc
JOIN notification_preferences np ON nc.id = np.id_channel
GROUP BY nc.notif_channel;

-- Preferencias de Usuarios
SELECT
    SUM(IF(debt_enabled = 1, 1, 0)) AS "Deuda",
    SUM(IF(media_enabled = 1, 1, 0)) AS "Música",
    SUM(IF(events_enabled = 1, 1, 0)) AS "Eventos",
    SUM(IF(friends_enabled = 1, 1, 0)) AS "Amistades",
    SUM(IF(offers_enabled = 1, 1, 0)) AS "Ofertas"
FROM notification_preferences;
