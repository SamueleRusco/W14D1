
CREATE table IF NOT EXISTS clienti (
	numero_cliente SERIAL PRIMARY KEY,
	nome VARCHAR NOT NULL,
	cognome VARCHAR NOT NULL,
	data_nascita DATE NOT NULL,
	regione_residenza VARCHAR NOT NULL
	
);
CREATE TABLE IF NOT EXISTS fornitori(
numero_fornitore SERIAL PRIMARY KEY,
denominazione VARCHAR NOT NULL,
regione_residenza VARCHAR NOT NULL
);

CREATE TABLE IF NOT EXISTS fatture (
	numero_fattura SERIAL PRIMARY KEY,
	tipologia VARCHAR NOT NULL,
	importo DECIMAL NOT NULL,
	iva VARCHAR NOT NULL DEFAULT '20%', 
	id_cliente INT8 NOT NULL,
	data_fattura DATE NOT NULL,
	numero_fornitore	 INT8 NOT NULL,
	/*nome del vincolo (fatture_clienti_fk), foreign key (vincolo di chiave esterna), 
	proprietà della tabella fatture che voglio referenziare, references nome tabella (nome colonna)
	primo termine tra parentesi (nome di riferimento su tabella sul quale sto scrivendo), references -> tabella al quale voglio legarmi (nome colonna)*/
	CONSTRAINT fatture_clienti_FK FOREIGN KEY (id_cliente) REFERENCES clienti (numero_cliente), /*qua vado a creare il legame*/
	CONSTRAINT fatture_fornitori_FK FOREIGN KEY (numero_fornitore) REFERENCES clienti (numero_cliente)
);


CREATE TABLE IF NOT EXISTS prodotti (
	id_prodotto SERIAL PRIMARY KEY,
	descrizione VARCHAR NOT NULL,
	in_produzione BOOLEAN NOT NULL DEFAULT 'false',
	in_commercio BOOLEAN NOT NULL DEFAULT 'false',
	data_attivazione DATE,
	data_disattivazione DATE	
);

INSERT INTO clienti (nome, cognome, data_nascita, regione_residenza)
	VALUES  ('mario', 'rossi', '1967/12/01', 'marche'),
			('giacomo', 'verdi', '1979/08/05', 'toscana'),
			('antonio', 'gialli', '2001/01/21', 'emilia-romagna');
			
INSERT INTO fornitori (denominazione, regione_residenza)
	VALUES  ('EPICODE s.r.l.', 'Lazio'),
			('Ferrari S.P.A.', 'Emilia-romagna'),
			('Marelli', 'Lombardia');	
	
INSERT INTO fatture(tipologia, importo, iva, id_cliente, data_fattura, numero_fornitore)
	VALUES  ('a', 1950, '10%', 1, '2022/03/18', 2),
			('b', 2200,'22%', 2, '2021/05/22', 1),
			('c', 19500,'18%', 3, '2020/02/04', 3);

INSERT INTO prodotti(descrizione, in_produzione, in_commercio, data_attivazione, data_disattivazione)
	VALUES  ('giocattolo', 'true', 'true', '2005/05/03', '2018/02/01'),
	 		('veicolo', 'false', 'false', '2018/03/12', '2021/12/01'),
 			('televisore', 'false', 'true', '2020/07/03', '2022/03/27');
			
			/*EXTRACT FUNZIONA SOLO CON LE DATE*/
			SELECT * FROM clienti WHERE EXTRACT(YEAR FROM data_nascita) = 1979; 
			/*COUNT prende il numero di record presenti in tabella*/
			SELECT COUNT (*) FROM fatture WHERE iva = '22%';
			
			
			
			

