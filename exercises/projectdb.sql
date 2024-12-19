--This is the player table

CREATE TABLE IF NOT EXISTS users (
                                     user_id INT CONSTRAINT pk_user_id PRIMARY KEY,
                                     username VARCHAR(255) NOT NULL,
    gender VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    birthdate DATE NOT NULL
    );

DROP TABLE IF EXISTS leaderboard;
CREATE TABLE IF NOT EXISTS leaderboard (
                                           score_id INT CONSTRAINT pk_score_id PRIMARY KEY,
                                           user_id INT CONSTRAINT fk_user_id REFERENCES users(user_id),
    score INT,
    gamesWon INT,
    gamesLost INT,
    gamesPlayed INT
    );

CREATE TABLE IF NOT EXISTS game_sessions (
                                             game_session_id INT CONSTRAINT pk_game_session_id PRIMARY KEY ,
                                             user_id INT CONSTRAINT fk_user_id REFERENCES users(user_id),
    duration INT NOT NULL,
    time_stamp TIMESTAMP NOT NULL
    );

CREATE TABLE IF NOT EXISTS words (
                                     word_id INT CONSTRAINT pk_word_id PRIMARY KEY,
                                     word_to_guess VARCHAR(255) NOT NULL
    );

--Load a file of the words to guess
CREATE TABLE IF NOT EXISTS attempts (
                                        attempt_id INT CONSTRAINT pk_attempt_id PRIMARY KEY,
                                        game_session_id INT CONSTRAINT fk_game_session_id REFERENCES game_sessions(game_session_id),
    attempt_num INT NOT NULL
    );