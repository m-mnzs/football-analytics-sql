import sqlite3
import os

DB_PATH = "football_analytics.db"
SCHEMA_PATH = os.path.join("sql", "01_schema.sql")
INSERT_PATH = os.path.join("sql", "02_insert_data.sql")
QUERIES_PATH = os.path.join("sql", "03_queries.sql")

def execute_sql_script(cursor, script_path):
    """Lê e executa scripts DDL/DML sem retorno de linhas."""
    with open(script_path, "r", encoding="utf-8") as file:
        sql_script = file.read()
    cursor.executescript(sql_script)

def run_analytical_queries(cursor):
    """Lê o arquivo 03_queries.sql, separa as consultas e exibe no terminal."""
    with open(QUERIES_PATH, "r", encoding="utf-8") as file:
        raw_sql = file.read()

    # Separa as queries pelo ponto e vírgula
    queries = [q.strip() for q in raw_sql.split(";") if q.strip()]

    print("\n" + "=" * 70)
    print("RESULTADOS DAS CONSULTAS ANALÍTICAS (SQL)")
    print("=" * 70)

    titulos = [
        "1. Desempenho Geral e Eficiência de xG por Atleta",
        "2. Métricas Normalizadas por 90 Minutos (Per 90)",
        "3. Ranking de Volume de Finalizações por Partida (Window Function)",
        "4. Comparativo de Performance Individual vs Média do Elenco"
    ]

    for idx, query in enumerate(queries):
        if idx < len(titulos):
            print(f"\n {titulos[idx]}\n" + "-" * 50)
            cursor.execute(query)
            
            # Obtém os nomes das colunas da consulta
            columns = [description[0] for description in cursor.description]
            rows = cursor.fetchall()

            # Imprime os cabeçalhos
            header = " | ".join(f"{col:<20}" for col in columns)
            print(header)
            print("-" * len(header))

            # Imprime as linhas
            for row in rows:
                line = " | ".join(f"{str(val):<20}" for val in row)
                print(line)

def main():
    print("Inicializando o pipeline do Football Analytics...")
    
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    try:
        print("Criando tabelas (01_schema.sql)...")
        execute_sql_script(cursor, SCHEMA_PATH)
        
        print("Populando o banco com dados (02_insert_data.sql)...")
        execute_sql_script(cursor, INSERT_PATH)
        conn.commit()
        
        print("Banco pronto! Rodando análises do 03_queries.sql...")
        run_analytical_queries(cursor)
        
    except sqlite3.Error as e:
        print(f"Erro ao manipular o banco de dados: {e}")
        conn.rollback()
        
    finally:
        conn.close()

if __name__ == "__main__":
    main()