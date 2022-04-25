
DROP SCHEMA IF EXISTS taskadmin CASCADE;
DROP ROLE IF EXISTS taskuser_role;
DROP ROLE IF EXISTS taskuser;


CREATE SCHEMA taskadmin AUTHORIZATION taskadmin;

-- -----------------------------------------------------
-- Table task_agile.user
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.user ;

CREATE TABLE IF NOT EXISTS taskadmin.user (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  email_address VARCHAR(128) NOT NULL,
  username VARCHAR(64) NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT email_address_uidx UNIQUE (email_address ),
  CONSTRAINT username_uidx UNIQUE (username ));


-- -----------------------------------------------------
-- Table taskadmin.team
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.team ;

CREATE TABLE IF NOT EXISTS taskadmin.team (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(128) NOT NULL,
  user_id INTEGER NOT NULL,
  archived INTEGER NOT NULL DEFAULT 0,
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_team_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table taskadmin.board
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.board ;

CREATE TABLE IF NOT EXISTS taskadmin.board (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(128) NOT NULL,
  description VARCHAR(256) NOT NULL,
  user_id INTEGER NOT NULL,
  team_id INTEGER NOT NULL,
  archived INTEGER NOT NULL DEFAULT 0,
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_board_team_team_id
    FOREIGN KEY (team_id)
    REFERENCES taskadmin.team (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_board_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table taskadmin.board_member
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.board_member ;

CREATE TABLE IF NOT EXISTS taskadmin.board_member (
  board_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, board_id),
  CONSTRAINT fk_board_member_board_board_id
    FOREIGN KEY (board_id)
    REFERENCES taskadmin.board (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_board_member_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table taskadmin.card_list
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.card_list ;

CREATE TABLE IF NOT EXISTS taskadmin.card_list (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  board_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  name VARCHAR(128) NOT NULL,
  position NUMERIC(11) NOT NULL,
  archived INTEGER NOT NULL DEFAULT 0,
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_card_list_board_board_id
    FOREIGN KEY (board_id)
    REFERENCES taskadmin.board (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_card_list_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table taskadmin.card
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.card ;

CREATE TABLE IF NOT EXISTS taskadmin.card (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  card_list_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  position NUMERIC(11) NOT NULL,
  archived INTEGER NOT NULL,
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_card_card_list_card_list_id
    FOREIGN KEY (card_list_id)
    REFERENCES taskadmin.card_list (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_card_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table taskadmin.assignment
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.assignment ;

CREATE TABLE IF NOT EXISTS taskadmin.assignment (
  card_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  PRIMARY KEY (card_id, user_id),
  CONSTRAINT fk_assignment_card_card_id
    FOREIGN KEY (card_id)
    REFERENCES taskadmin.card (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_assignment_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table taskadmin.attachment
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.attachment ;

CREATE TABLE IF NOT EXISTS taskadmin.attachment (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  card_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  file_path VARCHAR(255) NOT NULL,
  file_type NUMERIC(11) NOT NULL,
  archived INTEGER NOT NULL DEFAULT 0,
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_attachment_card_card_id
    FOREIGN KEY (card_id)
    REFERENCES taskadmin.card (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_attachment_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table taskadmin.activity
-- -----------------------------------------------------
DROP TABLE IF EXISTS taskadmin.activity ;

CREATE TABLE IF NOT EXISTS taskadmin.activity (
  id INTEGER GENERATED BY DEFAULT AS IDENTITY,
  user_id INTEGER NOT NULL,
  card_id INTEGER NULL,
  board_id INTEGER NOT NULL,
  type INTEGER NOT NULL DEFAULT 0,
  detail JSON NOT NULL,
  created_date TIMESTAMP NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_activity_user_user_id
    FOREIGN KEY (user_id)
    REFERENCES taskadmin.user (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_activity_board_board_id
    FOREIGN KEY (board_id)
    REFERENCES taskadmin.board (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_activity_card_card_id
    FOREIGN KEY (card_id)
    REFERENCES taskadmin.card (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;

--------------------------


ALTER TABLE taskadmin.user OWNER TO taskadmin;
ALTER TABLE taskadmin.team OWNER TO taskadmin;
ALTER TABLE taskadmin.board OWNER TO taskadmin;
ALTER TABLE taskadmin.board_member OWNER TO taskadmin;
ALTER TABLE taskadmin.card_list OWNER TO taskadmin;
ALTER TABLE taskadmin.card OWNER TO taskadmin;
ALTER TABLE taskadmin.assignment OWNER TO taskadmin;
ALTER TABLE taskadmin.attachment OWNER TO taskadmin;
ALTER TABLE taskadmin.activity OWNER TO taskadmin;




CREATE ROLE taskuser_role INHERIT;
ALTER ROLE taskuser_role SET search_path = 'taskadmin';
GRANT USAGE ON SCHEMA taskadmin TO taskuser_role;
--GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA taskadmin TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.user TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.team TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.board TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.board_member TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.card_list TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.card TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.assignment TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.attachment TO taskuser_role;
GRANT SELECT, UPDATE, INSERT ON taskadmin.activity TO taskuser_role;

CREATE ROLE taskuser PASSWORD 'taskuser' LOGIN INHERIT;
GRANT taskuser_role TO taskuser;
ALTER ROLE taskuser SET search_path = taskadmin,public;

