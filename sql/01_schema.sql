-- ============================================================
-- PROJETO: Football Analytics & SQL Performance Engine
-- ETAPA 01: Criação do Schema Relacional (Fato & Dimensões)
-- ============================================================

-- Habilita a checagem de Chaves Estrangeiras no SQLite
PRAGMA foreign_keys = ON;

-- Limpeza preventiva de tabelas existentes (Ordem invertida por dependência)
DROP TABLE IF EXISTS estatisticas_jogador;
DROP TABLE IF EXISTS partidas;
DROP TABLE IF EXISTS jogadores;

-- ============================================================
-- 1. TABELA DIMENSÃO: JOGADORES (Atributos cadastrais do atleta)
-- ============================================================
CREATE TABLE jogadores (
    jogador_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR(100) NOT NULL,
    posicao VARCHAR(30) NOT NULL,
    idade INTEGER NOT NULL,
    pe_preferencial VARCHAR(10) CHECK (pe_preferencial IN ('Direito', 'Esquerdo', 'Ambidestro')),
    valor_mercado_eur DECIMAL(12, 2)
);

-- ============================================================
-- 2. TABELA DIMENSÃO: PARTIDAS (Contexto do confronto)
-- ============================================================
CREATE TABLE partidas (
    partida_id INTEGER PRIMARY KEY AUTOINCREMENT,
    data_partida DATE NOT NULL,
    adversario VARCHAR(100) NOT NULL,
    mando_campo VARCHAR(10) CHECK (mando_campo IN ('Mandante', 'Visitante')),
    gols_pro INTEGER NOT NULL DEFAULT 0,
    gols_contra INTEGER NOT NULL DEFAULT 0,
    resultado VARCHAR(10) CHECK (resultado IN ('Vitoria', 'Empate', 'Derrota'))
);

-- ============================================================
-- 3. TABELA FATO: ESTATISTICAS_JOGADOR (Métricas de desempenho)
-- ============================================================
CREATE TABLE estatisticas_jogador (
    estatistica_id INTEGER PRIMARY KEY AUTOINCREMENT,
    jogador_id INTEGER NOT NULL,
    partida_id INTEGER NOT NULL,
    minutos_jogados INTEGER NOT NULL CHECK (minutos_jogados >= 0 AND minutos_jogados <= 120),
    finalizacoes INTEGER NOT NULL DEFAULT 0,
    finalizacoes_no_alvo INTEGER NOT NULL DEFAULT 0,
    xg DECIMAL(4, 2) NOT NULL DEFAULT 0.00, -- Expected Goals
    passes_certos INTEGER NOT NULL DEFAULT 0,
    passes_tentados INTEGER NOT NULL DEFAULT 0,
    desarmes INTEGER NOT NULL DEFAULT 0,
    cartao_amarelo INTEGER NOT NULL DEFAULT 0 CHECK (cartao_amarelo IN (0, 1)),
    cartao_vermelho INTEGER NOT NULL DEFAULT 0 CHECK (cartao_vermelho IN (0, 1)),
    
    -- Definição das Chaves Estrangeiras (Relacionamento com as Dimensões)
    FOREIGN KEY (jogador_id) REFERENCES jogadores(jogador_id) ON DELETE CASCADE,
    FOREIGN KEY (partida_id) REFERENCES partidas(partida_id) ON DELETE CASCADE
);