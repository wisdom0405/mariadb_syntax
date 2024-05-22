create table author(
    id int auto_increment,
    name varchar(255),
    email varchar(255) not null,
    created_time datetime default current_timestamp,
    primary key(id),  
    UNIQUE (email)
);

describe author; -- author 테이블 확인

create table post(
    id int primary key auto_increment,
    title varchar(255) not null,
    contents varchar(255)
);

create table author_address(
    id int primary key auto_increment,
    city varchar(255),
    street(255),
    author_id int not null,-- mandatory 조건 충족
    UNIQUE(author_id)  -- 1:1 관계 충족
    foreign key(author_id) REFERENCES author(id) on delete cascade -- 삭제되면 참조 같이 삭제됨
);

CREATE TABLE author_post(
    id int auto_increment primary key,
    author_id int not null,
    post_id int not null,
    foreign key(author_id) REFERENCES author(id),
    foreign key(post_id) REFERENCES post(id)
);
