-- ============================================================
-- PROJETO: Football Analytics & SQL Performance Engine
-- ETAPA 03: Consultas Analíticas e Window Functions
-- ============================================================

-- ------------------------------------------------------------
-- CONSULTA 1: Desempenho Geral e Eficiência de xG por Atleta
-- Conceitos: INNER JOIN, GROUP BY, SUM, ROUND
-- Pergunta: Quem são os maiores finalizadores e qual o xG acumulado?
-- ------------------------------------------------------------
SELECT 
    j.nome AS jogador,
    j.posicao,
    COUNT(e.partida_id) AS jogos_disputados,
    SUM(e.finalizacoes) AS total_finalizacoes,
    SUM(e.finalizacoes_no_alvo) AS finalizacoes_no_alvo,
    ROUND(SUM(e.xg), 2) AS total_xg
FROM jogadores j
INNER JOIN estatisticas_jogador e ON j.jogador_id = e.jogador_id
GROUP BY j.jogador_id, j.nome, j.posicao
ORDER BY total_xg DESC;


-- ------------------------------------------------------------
-- CONSULTA 2: Métricas Normalizadas por 90 Minutos (Per 90 Metrics)
-- Conceitos: Expressões Matemáticas, CAST, HAVING
-- Pergunta: Qual a média de passes certos e desarmes a cada 90 min jogados?
-- ------------------------------------------------------------
SELECT 
    j.nome AS jogador,
    SUM(e.minutos_jogados) AS total_minutos,
    ROUND(CAST(SUM(e.passes_certos) AS FLOAT) / SUM(e.minutos_jogados) * 90, 2) AS passes_certos_p90,
    ROUND(CAST(SUM(e.desarmes) AS FLOAT) / SUM(e.minutos_jogados) * 90, 2) AS desarmes_p90
FROM jogadores j
INNER JOIN estatisticas_jogador e ON j.jogador_id = e.jogador_id
GROUP BY j.jogador_id, j.nome
HAVING total_minutos >= 90
ORDER BY desarmes_p90 DESC;


-- ------------------------------------------------------------
-- CONSULTA 3: Ranking de Volume de Finalizações por Partida (Window Function)
-- Conceitos: DENSE_RANK() OVER (PARTITION BY ... ORDER BY ...)
-- Pergunta: Quem foram os jogadores que mais finalizaram em CADA partida?
-- ------------------------------------------------------------
SELECT 
    p.adversario,
    p.mando_campo,
    j.nome AS jogador,
    e.finalizacoes,
    e.xg,
    DENSE_RANK() OVER (
        PARTITION BY e.partida_id 
        ORDER BY e.finalizacoes DESC, e.xg DESC
    ) AS rank_finalizadora_na_partida
FROM estatisticas_jogador e
INNER JOIN jogadores j ON e.jogador_id = j.jogador_id
INNER JOIN partidas p ON e.partida_id = p.partida_id
ORDER BY e.partida_id, rank_finalizadora_na_partida;


-- ------------------------------------------------------------
-- CONSULTA 4: Comparativo de Performance Individual vs Média do Elenco
-- Conceitos: AVG() OVER (), Subqueries/Analítica Avançada
-- Pergunta: Como o xG de um jogador se compara à média do time naquela partida?
-- ------------------------------------------------------------
SELECT 
    p.adversario,
    j.nome AS jogador,
    e.xg AS xg_jogador,
    ROUND(AVG(e.xg) OVER(PARTITION BY e.partida_id), 2) AS xg_medio_time_na_partida,
    ROUND(e.xg - AVG(e.xg) OVER(PARTITION BY e.partida_id), 2) AS diferenca_vs_media
FROM estatisticas_jogador e
INNER JOIN jogadores j ON e.jogador_id = j.jogador_id
INNER JOIN partidas p ON e.partida_id = p.partida_id
ORDER BY p.partida_id, e.xg DESC;