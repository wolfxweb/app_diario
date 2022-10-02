
CREATE TABLE anotacoes (id INTEGER PRIMARY KEY, anotacao JSON, titulo TEXT , humor TEXT , data_hora DATE_TIME DEFAULT CURRENT_TIMESTAMP );

CREATE TABLE recuperacao_senha (id INTEGER PRIMARY KEY, email TEXT, status TEXT , code TEXT, senha TEXT);

