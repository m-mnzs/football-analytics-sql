-- ============================================================
-- PROJETO: Football Analytics & SQL Performance Engine
-- ETAPA 02: Povoamento das Tabelas (Data Insertion)
-- ============================================================

PRAGMA foreign_keys = ON;

-- 1. POVOANDO A DIMENSÃO JOGADORES
INSERT INTO jogadores (nome, posicao, idade, pe_preferencial, valor_mercado_eur) VALUES
('Gabriel Barbosa', 'Atacante', 28, 'Esquerdo', 15000000.00),
('Giorgian De Arrascaeta', 'Meio-Campista', 30, 'Direito', 16000000.00),
('Pedro Guilherme', 'Atacante', 27, 'Direito', 22000000.00),
('Erick Pulgar', 'Volante', 30, 'Direito', 6000000.00),
('Léo Ortiz', 'Zagueiro', 28, 'Direito', 9000000.00);

-- 2. POVOANDO A DIMENSÃO PARTIDAS
INSERT INTO partidas (data_partida, adversario, mando_campo, gols_pro, gols_contra, resultado) VALUES
('2024-08-01', 'Palmeiras', 'Mandante', 2, 0, 'Vitoria'),
('2024-08-04', 'São Paulo', 'Visitante', 0, 1, 'Derrota'),
('2024-08-11', 'Palmeiras', 'Visitante', 1, 1, 'Empate'),
('2024-08-15', 'Bolívar', 'Mandante', 2, 0, 'Vitoria');

-- 3. POVOANDO A TABELA FATO ESTATISTICAS_JOGADOR
-- Obs: jogador_id e partida_id correspondem aos IDs gerados nas tabelas acima

-- Partida 1: Vitória 2x0 Palmeiras (Mandante)
INSERT INTO estatisticas_jogador (jogador_id, partida_id, minutos_jogados, finalizacoes, finalizacoes_no_alvo, xg, passes_certos, passes_tentados, desarmes, cartao_amarelo, cartao_vermelho) VALUES
(1, 1, 75, 4, 2, 0.82, 18, 22, 0, 1, 0), -- Gabriel Barbosa (1 gol esperado alto)
(2, 1, 90, 2, 1, 0.35, 45, 52, 2, 0, 0), -- Arrascaeta
(3, 1, 15, 1, 1, 0.65, 4, 5, 0, 0, 0),   -- Pedro
(4, 1, 90, 0, 0, 0.05, 58, 62, 5, 1, 0), -- Pulgar
(5, 1, 90, 1, 0, 0.10, 62, 65, 3, 0, 0); -- Léo Ortiz

-- Partida 2: Derrota 0x1 São Paulo (Visitante)
INSERT INTO estatisticas_jogador (jogador_id, partida_id, minutos_jogados, finalizacoes, finalizacoes_no_alvo, xg, passes_certos, passes_tentados, desarmes, cartao_amarelo, cartao_vermelho) VALUES
(1, 2, 60, 1, 0, 0.12, 12, 18, 1, 0, 0), -- Gabriel Barbosa
(2, 2, 90, 3, 1, 0.28, 38, 48, 1, 0, 0), -- Arrascaeta
(3, 2, 30, 2, 1, 0.40, 6, 8, 0, 0, 0),   -- Pedro
(4, 2, 90, 1, 0, 0.08, 50, 56, 4, 1, 0), -- Pulgar
(5, 2, 90, 0, 0, 0.02, 55, 58, 2, 0, 0); -- Léo Ortiz

-- Partida 3: Empate 1x1 Palmeiras (Visitante)
INSERT INTO estatisticas_jogador (jogador_id, partida_id, minutos_jogados, finalizacoes, finalizacoes_no_alvo, xg, passes_certos, passes_tentados, desarmes, cartao_amarelo, cartao_vermelho) VALUES
(2, 3, 80, 2, 2, 0.55, 42, 50, 1, 0, 0), -- Arrascaeta
(3, 3, 90, 5, 3, 0.95, 15, 19, 0, 0, 0), -- Pedro
(4, 3, 90, 0, 0, 0.00, 61, 67, 6, 0, 0), -- Pulgar
(5, 3, 90, 1, 1, 0.15, 58, 60, 4, 1, 0); -- Léo Ortiz

-- Partida 4: Vitória 2x0 Bolívar (Mandante)
INSERT INTO estatisticas_jogador (jogador_id, partida_id, minutos_jogados, finalizacoes, finalizacoes_no_alvo, xg, passes_certos, passes_tentados, desarmes, cartao_amarelo, cartao_vermelho) VALUES
(1, 4, 90, 3, 2, 0.70, 22, 28, 1, 0, 0), -- Gabriel Barbosa
(2, 4, 85, 4, 2, 0.60, 51, 58, 2, 0, 0), -- Arrascaeta
(3, 4, 20, 1, 1, 0.30, 8, 10, 0, 0, 0),  -- Pedro
(4, 4, 90, 1, 0, 0.05, 65, 70, 3, 0, 0), -- Pulgar
(5, 4, 90, 0, 0, 0.00, 70, 72, 1, 0, 0); -- Léo Ortiz