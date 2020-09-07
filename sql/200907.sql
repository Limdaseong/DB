DROP TABLE t_user;

CREATE TABLE t_user(
	i_user INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, -- UNSIGNED는 양수만 저장
	user_id varchar(30) NOT NULL UNIQUE,
	user_pw varchar(70) NOT NULL,
	salt VARCHAR(30) NOT NULL,
	nm	     varchar(5) NOT NULL,
	profile_img VARCHAR(50),
	r_dt DATETIME DEFAULT NOW(),
	m_dt DATETIME DEFAULT NOW()
);

INSERT INTO t_user
(user_id, user_pw, nm)
VALUES
('dfdfdf2', 'sdddfdf2', 'asdfasdf');
