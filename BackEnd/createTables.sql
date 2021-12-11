create table if not exists users
(
    id       char(36)     not null primary key,
    email    varchar(50)  not null,
    login    varchar(50)  not null,
    password varchar(255) not null
);

create unique index if not exists "users_email_uindex"
    on users (email);

create unique index if not exists users_login_uindex
    on users (login);
create table if not exists posts
(
    id         integer  not null
        constraint posts_pk
            primary key autoincrement,
    user_id    char(36) not null
        references users,
    content    text     not null,
    created_at timestamp         default CURRENT_TIMESTAMP not null,
    subject    text     not null default '',
    parent_id  integer null
        constraint posts_posts_id_fk
            references posts (id)
);
create index if not exists posts_parent_id_index
    on posts (parent_id);
create table if not exists categories
(
    id   integer     not null
        constraint categories_pk
            primary key autoincrement,
    name varchar(50) not null
);
create unique index if not exists categories_name_uindex
    on categories (name);
create table if not exists "posts_categories"
(
    post_id     integer not null
        constraint "posts_categories_posts_id_fk"
            references posts,
    category_id integer not null
        constraint "posts_categories_categories_id_fk"
            references categories,
    constraint "posts_categories_pk"
        primary key (post_id, category_id)
);
create table if not exists likes_dislikes
(
    post_id integer  not null
        constraint likes_dislikes_posts_id_fk
            references posts,
    user_id char(36) not null
        constraint likes_dislikes_users_id_fk
            references users,
    mark    boolean,
    constraint likes_dislikes_pk
        primary key (post_id, user_id)
);
create table if not exists sessions
(
    session_key varchar(255) not null
        constraint sessions_pk
            primary key,
    user_id     char(36)     not null
        constraint sessions_users_id_fk
            references users
            on delete cascade,
    expired_at  time         not null
);

create unique index if not exists sessions_session_id_uindex
    on sessions (session_key);

create unique index if not exists sessions_user_id_uindex
    on sessions (user_id);

-- insert into categories (name) values ('Books'), ('Films'), ('Games'), ('Other');


