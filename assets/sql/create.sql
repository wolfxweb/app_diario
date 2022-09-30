
CREATE TABLE anotacoes (id INTEGER PRIMARY KEY, anotacao JSON, titulo TEXT , humor TEXT , data_hora DATE_TIME DEFAULT CURRENT_TIMESTAMP );

CREATE TABLE email (id INTEGER PRIMARY KEY, email TEXT, status bollean , code TEXT);

