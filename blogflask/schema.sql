DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS post;
DROP TABLE IF EXISTS tag;
DROP TABLE IF EXISTS comment;


CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
); 

CREATE TABLE post (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    photo BLOB NOT NULL,
    author_id IINTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES user (id)
);

CREATE TABLE tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL
);

CREATE TABLE post_tag (
    post_id INTEGER REFERENCES post (id),
    tag_id INTEGER REFERENCES tag (id)
);

CREATE TABLE comment (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    message TEXT NOT NULL,
    owner_id INTEGER NOT NULL,
    post_id INTEGER NOT NULL,
    created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES user (id),
    FOREIGN KEY (post_id) REFERENCES post (post_id)
);