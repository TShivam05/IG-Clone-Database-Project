-- 2. We want to reward the user who has been around the longest, Find the 5 oldest users.
SELECT id, username, created_at
FROM users
ORDER BY created_at ASC
LIMIT 5;

-- 3. To target inactive users in an email ad campaign, find the users who have never posted a photo.
SELECT id, username
FROM users
WHERE id NOT IN (
    SELECT DISTINCT user_id
    FROM photos
);

-- 4.
SELECT photos.id, photos.image_url, users.username, COUNT(*) AS num_likes
FROM likes
INNER JOIN photos ON likes.photo_id = photos.id
INNER JOIN users ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY num_likes DESC
LIMIT 1;


-- 5. 
SELECT AVG(post_count) AS avg_posts_per_user
FROM (
    SELECT user_id, COUNT(*) AS post_count
    FROM photos
    GROUP BY user_id
) AS user_posts;


-- A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.

SELECT tags.tag_name, COUNT(*) AS tag_count
FROM photo_tags
INNER JOIN tags ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY tag_count DESC
LIMIT 5;


-- --7.To find out if there are bots, find users who have liked every single photo on the site.
select user_id , count(*) as no_of_liked_photos from likes 
group by user_id
having no_of_liked_photos = (select count(id) from photos);

 -- 8. Find the users who have created instagramid in may and select top 5 newest joinees from it?
  SELECT * FROM users
WHERE MONTH(created_at) = 5
ORDER BY created_at DESC
LIMIT 5;

/* Can you help me find the users whose name starts with c and ends with any number and have posted the photos 
as well as liked the photos? */
select distinct username from users U
left join photos P on P.user_id = U.id
left join likes L on L.user_id = U.id
where username regexp '^c.*[0-9]$';

SELECT u.*
FROM users u
WHERE u.username LIKE 'c%[0-9]' AND 
u.user_id IN (
  SELECT DISTINCT p.user_id
  FROM photos p
  INNER JOIN likes l ON p.photo_id = l.photo_id
  WHERE l.user_id = u.user_id
);


-- Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.

select * from users 
where num_photos between 3 and 5
order by num_photos desc
limit 30;


SELECT u.*
FROM users u
WHERE u.username LIKE 'c%[0-9]' AND 
u.id IN (
  SELECT DISTINCT p.user_id
  FROM photos p
  INNER JOIN likes l ON p.id = l.photo_id
  WHERE l.user_id = u.id
);






