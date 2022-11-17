/**
The schema of the Tables and indexes in the Databases.
**/

--Application Table

--create table Application(id serial, token varchar(255) unique, name varchar(255),chats_count Integer unsigned default 0);
--CREATE INDEX token_idx USING HASH ON Application(token);

--Chat Table

--create table Chat(id serial, number int, token varchar(255), messages_count int unsigned default 0,FOREIGN KEY(token) references Application(token));
--alter table Chat add unique (`number`, `token`);
--CREATE INDEX token_idx USING HASH ON Chat(token);
--CREATE INDEX number_idx USING HASH ON Chat(number);

--Message Table

--create table Message(id serial, chat_number int, number int, token varchar(255), FOREIGN KEY(token) references Application(token), FOREIGN KEY(chat_number) references Chat(number));
--alter table Message add unique (`number`, `token`, `chat_number`);
--CREATE INDEX token_idx USING HASH ON Message(token);
--CREATE INDEX chat_number_idx USING HASH ON Message(chat_number);
--CREATE INDEX number_idx USING HASH ON Message(number);

