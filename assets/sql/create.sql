
CREATE TABLE dados_basiscos(id INTEGER PRIMARY KEY, qtd TEXT,faturamento TEXT,gastos TEXT,custo_fixo Text, custo_varivel TEXT, margen TEXT, mes TEXT , gastos_insumos TEXT );
CREATE TABLE importancia_meses(id INTEGER PRIMARY KEY, jan NUMERIC,fev NUMERIC,mar NUMERIC,abr NUMERIC, mai NUMERIC, jun NUMERIC, jul NUMERIC, ago NUMERIC, setb NUMERIC,out NUMERIC, nov NUMERIC, dez NUMERIC, total NUMERIC);
CREATE TABLE calculadora_historico(id INTEGER PRIMARY KEY, produto TEXT,data TEXT,preco_atual TEXT,preco_sugerido Text, margem_desejada TEXT, margem_atual TEXT);