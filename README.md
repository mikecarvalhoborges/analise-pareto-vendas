# analise-pareto-vendas
Análise de Pareto | Faturamento por Cliente

Objetivo: 
Identificar quais clientes concentram a maior parte da receita, aplicando o princípio de Pareto (80/20).

Tecnologias utilizadas:
- Google BigQuery (SQL);
- Window Functions (SQL): SUM() e OVER();
- Google Sheets (visualização);
- GitHub (documentação do projeto).

Metodologia:
- Cálculo do faturamento por cliente;
- Ordenação decrescente por receita;
- Cálculo do faturamento acumulado;
- Cálculo do percentual acumulado;
- Construção do gráfico de Pareto.

Resultado:
O gráfico evidencia que aproximadamente 80% da receita está concentrada nos principais clientes, indicando alta concentração de faturamento.

Insights:
- Forte dependência de poucos clientes;
- Possível risco de concentração;
- Oportunidade de diversificação da base.

Query principal:
  ```
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
```
