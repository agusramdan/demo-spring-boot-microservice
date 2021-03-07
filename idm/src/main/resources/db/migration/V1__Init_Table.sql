CREATE TABLE roles
(
    authority    VARCHAR(50) NOT NULL PRIMARY KEY,
    description  VARCHAR(100) NOT NULL
) ENGINE = InnoDb;

CREATE TABLE users
(
    username   VARCHAR(50)  NOT NULL PRIMARY KEY,
    password   VARCHAR(255) NOT NULL,
    enabled                 BOOLEAN DEFAULT TRUE,
    email      VARCHAR(255) NOT NULL UNIQUE

) ENGINE = InnoDb;
-- auth
create table authorities
(
    username  varchar(50) not null,
    authority varchar(50) not null,
    foreign key (username) references users (username),
    unique index authorities_idx (username, authority)
) engine = innodb;

-- groups , group_members , group_authorities
-- select g.id, g.group_name, ga.authority from groups g, group_members gm, group_authorities ga where gm.username = ? and g.id = ga.group_id and g.id = gm.group_id

-- spring session
create table spring_session (
	primary_id char(36) not null,
	session_id char(36) not null,
	creation_time bigint not null,
	last_access_time bigint not null,
	max_inactive_interval int not null,
	expiry_time bigint not null,
	principal_name varchar(100),
	constraint spring_session_pk primary key (primary_id)
) engine=innodb row_format=dynamic;

create unique index spring_session_ix1 on spring_session (session_id);
create index spring_session_ix2 on spring_session (expiry_time);
create index spring_session_ix3 on spring_session (principal_name);

create table spring_session_attributes (
	session_primary_id char(36) not null,
	attribute_name varchar(200) not null,
	attribute_bytes blob not null,
	constraint spring_session_attributes_pk primary key (session_primary_id, attribute_name),
	constraint spring_session_attributes_fk foreign key (session_primary_id) references spring_session(primary_id) on delete cascade
) engine=innodb row_format=dynamic;

---

create table revinfo (
    rev       BIGINT(50) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    revtstmp  BIGINT(50),
    username  VARCHAR(50)
);

---

INSERT INTO roles
(authority, description)
VALUES
('ROLE_ADMIN'  ,'Administrator'),
('ROLE_USER'   ,'User'),
('ROLE_SERVICE','Service'),
('ROLE_MONITOR','Monitor')
;

INSERT INTO users
(enabled,username     ,email                       ,password )
VALUES
(true  ,'service-eureka','service-eureka@gmail.com','{noop}rahasia'),
(true  ,'service-admin' ,'service-admin@gmail.com' ,'{noop}rahasia'),

(true  ,'system'        ,'system@gmail.com'        ,'{noop}rahasia'),
(true  ,'support'       ,'support@gmail.com'       ,'{noop}rahasia'),
(true  ,'agus.ramdan'   ,'agus.ramdan@gmail.com'   ,'{noop}rahasia')
;


INSERT INTO authorities
(authority     ,username)
VALUES
('ROLE_SERVICE','service-eureka'),
('ROLE_MONITOR','service-eureka'),
('ROLE_SERVICE','service-admin'),

('ROLE_ADMIN'  ,'system'     ),
('ROLE_ADMIN'  ,'support'    ),
('ROLE_ADMIN'  ,'agus.ramdan')

;


