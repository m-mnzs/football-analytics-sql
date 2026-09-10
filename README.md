# Football Analytics & SQL Performance Engine

Este projeto implementa uma pipeline analítica e banco de dados relacional (3FN) focado na análise de desempenho tático de atletas de futebol, utilizando **SQL Nativo (DDL, DML, Window Functions)** e **Python (SQLite)**.

---

## Arquitetura do Banco de Dados (Star Schema)

A modelagem segue o padrão relacional em **Terceira Forma Normal (3FN)** com separação entre dimensões e fato:

* **`jogadores` (Dimensão):** Atributos cadastrais e de mercado do atleta.
* **`partidas` (Dimensão):** Contexto dos confrontos (mando de campo, adversário, placar).
* **`estatisticas_jogador` (Fato):** Métricas granuladas de desempenho por partida (minutos jogados, finalizações, $xG$, passes, desarmes, cartões).

---

## Tecnologias e Conceitos Aplicados

* **SQL Avançado:** `INNER JOIN`, `GROUP BY`, `HAVING`, expressões de normalização (*Per 90 Metrics*).
* **Window Functions:** `DENSE_RANK() OVER (PARTITION BY ...)` e `AVG() OVER ()` para ranking e comparativo individual vs. média do elenco.
* **Integridade de Dados:** Validações via `CHECK` constraints e Chaves Estrangeiras (`FOREIGN KEY`) ativas.
* **Automação Python:** Script `main.py` para execução sequencial de DDL/DML e formatação de saídas no terminal.

---

## Como Executar o Projeto

1. Clone o repositório:
   ```bash
   git clone [https://github.com/m-mnzs/football-analytics-sql.git](https://github.com/m-mnzs/football-analytics-sql.git)
   cd football-analytics-sql