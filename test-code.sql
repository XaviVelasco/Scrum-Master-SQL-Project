/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
-- 2. How many days has each customer visited the restaurant?
-- 3. What was the first item from the menu purchased by each customer?
-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
-- 5. Which item was the most popular for each customer?
-- 6. Which item was purchased first by the customer after they became a member?
-- 7. Which item was purchased just before the customer became a member?
-- 8. What is the total items and amount spent for each member before they became a member?
-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

-- Select table Query:

--Members Table
SELECT
  	*
FROM dannys_diner.dbo.members;


-- Menu table
SELECT
  	*
FROM dannys_diner.dbo.menu;


--Sales table
SELECT
  	*
FROM dannys_diner.dbo.sales;


-- 1. What is the total amount each customer spent at the restaurant?

SELECT 
    s.customer_id, 
	SUM(m.price) AS total_amount_spent
FROM dannys_diner.dbo.sales s
JOIN dannys_diner.dbo.menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;



-- 2. How many days has each customer visited the restaurant?

SELECT 
    customer_id, 
	COUNT(DISTINCT order_date) AS total_days_visited
FROM dannys_diner.dbo.sales 
GROUP BY customer_id
ORDER BY customer_id;


-- 3. What was the first item from the menu purchased by each customer?

WITH customer_first_purchase AS (
  SELECT 
      s.customer_id, m.product_name,
	  MIN(s.order_date) AS first_purchase_date
  FROM dannys_diner.dbo.sales s
  JOIN dannys_diner.dbo.menu m
  ON s.product_id = m.product_id
  GROUP BY s.customer_id, m.product_name
  ORDER BY first_purchase_date
)
SELECT 
    c.customer_id, 
	c.product_name
FROM customer_first_purchase c
WHERE c.first_purchase_date = (
  SELECT MIN(first_purchase_date)
  FROM customer_first_purchase
  WHERE customer_id = c.customer_id
)
ORDER BY c.customer_id;
SELECT c.customer_id, m.product_name
FROM (
  SELECT customer_id, MIN(order_date) AS first_order_date
  FROM dannys_diner.dbo.sales
  GROUP BY customer_id
) AS c
JOIN dannys_diner.dbo.sales AS s ON c.customer_id = s.customer_id AND c.first_order_date = s.order_date
JOIN dannys_diner.dbo.menu AS m ON s.product_id = m.product_id
ORDER BY c.customer_id;



-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT 
    M.product_id,
	product_name,
	price,
	COUNT(S.product_id) AS total_purchases
FROM dannys_diner.dbo.menu AS M
INNER JOIN dannys_diner.dbo.sales AS S
ON M.product_id= S.product_id
GROUP BY M.product_id, product_name, price
ORDER BY total_purchases DESC
;



-- 5. Which item was the most popular for each customer?

WITH popular_items AS (
  SELECT 
      customer_id, 
	  product_id, 
	  COUNT(*) AS order_count,
         ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) AS rn
  FROM dannys_diner.dbo.sales
  GROUP BY customer_id, product_id
)
SELECT 
    p.customer_id, 
	m.product_name AS most_popular_item
FROM popular_items p
JOIN dannys_diner.dbo.menu m 
ON p.product_id = m.product_id
WHERE p.rn = 1
ORDER BY p.customer_id;



-- 6. Which item  was purchased first by the customer after they became a member?

SELECT 
    m.customer_id, 
	m.join_date, 
	MIN(s.order_date) AS first_purchase_date, 
	u.product_name AS first_purchase_item
FROM dannys_diner.dbo.members m
JOIN dannys_diner.dbo.sales s ON m.customer_id = s.customer_id
JOIN dannys_diner.dbo.menu u ON s.product_id = u.product_id
WHERE s.order_date > m.join_date
GROUP BY m.customer_id, m.join_date, u.product_name
ORDER BY m.customer_id;



-- 7. Which item was purchased just before the customer became a member?

SELECT 
    m.customer_id, 
	m.join_date, 
	MAX(s.order_date) AS last_purchase_date,
	u.product_name AS last_purchase_item
FROM dannys_diner.dbo.members m
JOIN dannys_diner.dbo.sales s 
ON m.customer_id = s.customer_id
JOIN dannys_diner.dbo.menu u 
ON s.product_id = u.product_id
WHERE s.order_date < m.join_date
GROUP BY m.customer_id, m.join_date, u.product_name
ORDER BY m.customer_id;


-- 8. What is the total items and amount spent for each member before they became a member?

SELECT 
     m.customer_id, 
	 m.join_date,
     COUNT(s.product_id) AS total_items,
     SUM(u.price) AS total_amount_spent
FROM dannys_diner.dbo.members m
JOIN dannys_diner.dbo.sales s 
ON m.customer_id = s.customer_id
JOIN dannys_diner.dbo.menu u 
ON s.product_id = u.product_id
WHERE s.order_date < m.join_date
GROUP BY m.customer_id, m.join_date
ORDER BY m.customer_id;


-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

SELECT 
     s.customer_id, 
SUM(
  CASE
    WHEN m.product_name = 'sushi' THEN 20 * m.price
    ELSE 10 * m.price
  END
) AS total_points
FROM dannys_diner.dbo.sales s
JOIN dannys_diner.dbo.menu m 
ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
 
WITH customer_points AS (
  SELECT s.customer_id, s.order_date, u.product_name,
         CASE
           WHEN u.product_name = 'sushi' THEN
             CASE
               WHEN s.order_date <= DATEADD(DAY, 6, m.join_date) THEN 20 * u.price
               ELSE 10 * u.price
             END
           ELSE
             CASE
               WHEN s.order_date <= DATEADD(DAY, 6, m.join_date) THEN 20 * u.price
               ELSE 10 * u.price
             END
         END AS points
  FROM dannys_diner.dbo.sales s
  JOIN dannys_diner.dbo.menu u ON s.product_id = u.product_id
  JOIN dannys_diner.dbo.members m ON s.customer_id = m.customer_id
  WHERE s.order_date <= '2021-01-31' -- End of January
    AND (s.order_date >= m.join_date OR s.order_date <= DATEADD(DAY, 6, m.join_date))
)
SELECT customer_id, SUM(points) AS total_points
FROM customer_points
WHERE customer_id IN ('A', 'B')
GROUP BY customer_id
ORDER BY customer_id;
 
--------------------

/*INSTAGRAM CLONE DATABASE CREATION AND DATA INSERTION*/

CREATE DATABASE ig_clone;

/*Users*/
CREATE TABLE users (
    id INT AUTO_INCREMENT UNIQUE PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW ()
);
-- ----------------------------------------------------------------------------------------------------

/*Photos*/
CREATE TABLE photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(355) NOT NULL,
    user_id INT NOT NULL,
    created_dat TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (user_id)
        REFERENCES users (id)
);
-- ----------------------------------------------------------------------------------------------------

/*Comments*/
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (user_id)
        REFERENCES users (id),
    FOREIGN KEY (photo_id)
        REFERENCES photos (id)
);
-- ----------------------------------------------------------------------------------------------------

/*Likes*/
CREATE TABLE likes (
    user_id INT NOT NULL,
    photo_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (user_id)
        REFERENCES users (id),
    FOREIGN KEY (photo_id)
        REFERENCES photos (id),
    PRIMARY KEY (user_id , photo_id)
);
-- ----------------------------------------------------------------------------------------------------

/*Follows*/
CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW (),
    FOREIGN KEY (follower_id)
        REFERENCES users (id),
    FOREIGN KEY (followee_id)
        REFERENCES users (id),
    PRIMARY KEY (follower_id , followee_id)
);
-- ----------------------------------------------------------------------------------------------------

/*Tags*/
CREATE TABLE tags (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW ()
);
-- ----------------------------------------------------------------------------------------------------

/*Photo_Tags*/
CREATE TABLE photo_tags (
    photo_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (photo_id)
        REFERENCES photos (id),
    FOREIGN KEY (tag_id)
        REFERENCES tags (id),
    PRIMARY KEY (photo_id , tag_id)
);
-- ----------------------------------------------------------------------------------------------------

/*Inserting Data into ig_clone database*/

INSERT INTO
	users (username,
	created_at)
VALUES ('Kenton_Kirlin',
'2017-02-16 18:22:10.846'),
('Andre_Purdy85',
'2017-04-02 17:11:21.417'),
('Harley_Lind18',
'2017-02-21 11:12:32.574'),
('Arely_Bogan63',
'2016-08-13 01:28:43.085'),
('Aniya_Hackett',
'2016-12-07 01:04:39.298'),
('Travon.Waters',
'2017-04-30 13:26:14.496'),
('Kasandra_Homenick',
'2016-12-12 06:50:07.996'),
('Tabitha_Schamberger11',
'2016-08-20 02:19:45.512'),
('Gus93',
'2016-06-24 19:36:30.978'),
('Presley_McClure',
'2016-08-07 16:25:48.561'),
('Justina.Gaylord27',
'2017-05-04 16:32:15.577'),
('Dereck65',
'2017-01-19 01:34:14.296'),
('Alexandro35',
'2017-03-29 17:09:02.344'),
('Jaclyn81',
'2017-02-06 23:29:16.394'),
('Billy52',
'2016-10-05 14:10:20.453'),
('Annalise.McKenzie16',
'2016-08-02 21:32:45.646'),
('Norbert_Carroll35',
'2017-02-06 22:05:43.425'),
('Odessa2',
'2016-10-21 18:16:56.390'),
('Hailee26',
'2017-04-29 18:53:39.650'),
('Delpha.Kihn',
'2016-08-31 02:42:30.288'),
('Rocio33',
'2017-01-23 11:51:15.467'),
('Kenneth64',
'2016-12-27 09:48:17.380'),
('Eveline95',
'2017-01-23 23:14:18.569'),
('Maxwell.Halvorson',
'2017-04-18 02:32:43.597'),
('Tierra.Trantow',
'2016-10-03 12:49:20.774'),
('Josianne.Friesen',
'2016-06-07 12:47:00.703'),
('Darwin29',
'2017-03-18 03:10:07.047'),
('Dario77',
'2016-08-18 07:15:02.823'),
('Jaime53',
'2016-09-11 18:51:56.965'),
('Kaley9',
'2016-09-23 21:24:20.222'),
('Aiyana_Hoeger',
'2016-09-29 20:28:12.457'),
('Irwin.Larson',
'2016-08-26 19:36:22.199'),
('Yvette.Gottlieb91',
'2016-11-14 12:32:01.405'),
('Pearl7',
'2016-07-08 21:42:00.982'),
('Lennie_Hartmann40',
'2017-03-30 03:25:21.937'),
('Ollie_Ledner37',
'2016-08-04 15:42:20.322'),
('Yazmin_Mills95',
'2016-07-27 00:56:44.310'),
('Jordyn.Jacobson2',
'2016-05-14 07:56:25.835'),
('Kelsi26',
'2016-06-08 17:48:08.478'),
('Rafael.Hickle2',
'2016-05-19 09:51:25.779'),
('Mckenna17',
'2016-07-17 17:25:44.855'),
('Maya.Farrell',
'2016-12-11 18:04:45.344'),
('Janet.Armstrong',
'2016-10-06 07:57:44.491'),
('Seth46',
'2016-07-07 11:40:26.557'),
('David.Osinski47',
'2017-02-05 21:23:37.392'),
('Malinda_Streich',
'2016-07-09 21:37:07.610'),
('Harrison.Beatty50',
'2016-09-02 03:48:38.340'),
('Granville_Kutch',
'2016-06-26 03:10:22.202'),
('Morgan.Kassulke',
'2016-10-30 12:42:31.387'),
('Gerard79',
'2016-08-23 19:47:44.102'),
('Mariano_Koch3',
'2017-04-17 14:14:45.662'),
('Zack_Kemmer93',
'2017-01-01 05:58:22.276'),
('Linnea59',
'2017-02-07 07:49:33.830'),
('Duane60',
'2016-12-21 04:43:37.761'),
('Meggie_Doyle',
'2017-04-04 12:17:33.931'),
('Peter.Stehr0',
'2016-08-22 18:05:42.167'),
('Julien_Schmidt',
'2017-02-02 23:12:48.451'),
('Aurelie71',
'2016-05-31 06:20:56.909'),
('Cesar93',
'2016-10-18 16:42:43.220'),
('Sam52',
'2017-03-30 22:03:45.159'),
('Jayson65',
'2016-10-14 19:10:52.564'),
('Ressie_Stanton46',
'2016-12-20 15:09:08.721'),
('Elenor88',
'2016-05-08 01:30:40.677'),
('Florence99',
'2016-10-06 23:08:30.626'),
('Adelle96',
'2016-10-01 00:37:57.429'),
('Mike.Auer39',
'2016-07-01 17:36:14.714'),
('Emilio_Bernier52',
'2016-05-06 13:04:29.960'),
('Franco_Keebler64',
'2016-11-13 20:09:26.855'),
('Karley_Bosco',
'2016-06-24 23:38:52.138'),
('Erick5',
'2017-04-05 23:44:47.060'),
('Nia_Haag',
'2016-05-14 15:38:50.230'),
('Kathryn80',
'2016-10-11 09:01:56.764'),
('Jaylan.Lakin',
'2016-06-10 23:58:52.210'),
('Hulda.Macejkovic',
'2017-01-25 17:17:27.717'),
('Leslie67',
'2016-09-21 05:14:01.207'),
('Janelle.Nikolaus81',
'2016-07-21 09:26:09.466'),
('Donald.Fritsch',
'2017-01-07 10:05:41.165'),
('Colten.Harris76',
'2016-10-10 02:38:52.941'),
('Katarina.Dibbert',
'2016-11-03 13:14:10.647'),
('Darby_Herzog',
'2016-05-06 00:14:21.191'),
('Esther.Zulauf61',
'2017-01-14 17:02:33.511'),
('Aracely.Johnston98',
'2016-07-25 18:49:09.996'),
('Bartholome.Bernhard',
'2016-11-06 02:31:23.463'),
('Alysa22',
'2017-01-01 17:44:42.980'),
('Milford_Gleichner42',
'2017-04-30 07:50:51.280'),
('Delfina_VonRueden68',
'2017-03-21 12:02:14.358'),
('Rick29',
'2017-02-24 11:25:08.160'),
('Clint27',
'2016-06-02 21:40:09.555'),
('Jessyca_West',
'2016-09-14 23:47:04.780'),
('Esmeralda.Mraz57',
'2017-03-03 11:52:27.469'),
('Bethany20',
'2016-06-03 23:31:53.322'),
('Frederik_Rice',
'2016-07-06 21:56:28.654'),
('Willie_Leuschke',
'2017-02-15 01:40:53.310'),
('Damon35',
'2016-10-31 14:44:27.239'),
('Nicole71',
'2016-05-09 17:30:22.371'),
('Keenan.Schamberger60',
'2016-08-28 14:57:28.221'),
('Tomas.Beatty93',
'2017-02-11 11:38:55.026'),
('Imani_Nicolas17',
'2017-01-31 22:59:34.108'),
('Alek_Watsica',
'2016-12-10 07:43:58.083'),
('Javonte83',
'2017-03-27 22:06:37.433');
