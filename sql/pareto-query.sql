WITH faturamento_cliente AS ( 
  SELECT 
    cliente, 
    SUM(quantidade * preco_unit) AS faturamento
FROM prefab-fabric-462023-n0.estudos_sql.vendas 
GROUP BY cliente
),

ranking AS (
  SELECT
    cliente,
    faturamento,
    SUM(faturamento) OVER() AS faturamento_total,
    SUM(faturamento) OVER(ORDER BY faturamento DESC) AS faturamento_acumulado
  FROM faturamento_cliente
)

SELECT
  cliente,
  faturamento,
  faturamento_acumulado,
  ROUND(
    (faturamento_acumulado / faturamento_total) * 100,2
    ) AS percentual_acumulado
FROM ranking
ORDER BY faturamento DESC;