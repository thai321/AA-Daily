DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  parent_id INTEGER,
  user_id INTEGER NOT NULL,
  title TEXT NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (parent_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  likes INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
  users (fname, lname)
VALUES
  ('Cory', 'Kane'),
  ('Thai', 'Nguyen');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('How does SQL work?', 'I want to know how SQL works', (SELECT id FROM users WHERE users.fname = 'Cory')),
  ('How does Rails work?', 'I want to know how Rails works', (SELECT id FROM users WHERE users.fname = 'Thai'));

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  ((SELECT id FROM questions WHERE body LIKE '%Rails%') ,(SELECT id FROM users WHERE users.fname = 'Cory')),
  ((SELECT id FROM questions WHERE body LIKE '%SQL%') ,(SELECT id FROM users WHERE users.fname = 'Thai'));


INSERT INTO
  replies(title, body , parent_id, question_id, user_id)
VALUES
  ('SQL',
    'This is how SQL works',
    NULL,
    (SELECT id FROM questions WHERE body LIKE '%SQL%'),
    (SELECT id FROM users WHERE users.fname = 'Thai')
  ),

  ('Rails',
    'This is how Rails works',
    NULL,
    (SELECT id FROM questions WHERE body LIKE '%Rails%'),
    (SELECT id FROM users WHERE users.fname = 'Cory')
  );


INSERT INTO
  replies(title, body , parent_id, question_id, user_id)
VALUES
  ('Rails',
    'That was a great explanation',
    (SELECT id FROM replies WHERE body LIKE '%Rails%'),
    (SELECT id FROM questions WHERE body LIKE '%Rails%'),
    (SELECT id FROM users WHERE users.fname = 'Thai')
  );


INSERT INTO
  question_likes(likes, user_id, question_id)
VALUES
  (1, (SELECT id FROM users WHERE users.fname = 'Cory'), (SELECT id FROM questions WHERE body LIKE '%Rails%')),
  (2, (SELECT id FROM users WHERE users.fname = 'Thai'), (SELECT id FROM questions WHERE body LIKE '%SQL%'));
