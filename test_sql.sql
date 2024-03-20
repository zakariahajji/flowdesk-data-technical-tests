
"""
an SQL query that joins the `Trades` and `Indexes` tables.

based on the closest `timestamps` for each trade.

for each `trade`: 

you should find the corresponding `index value` with the closest `timestamp`, 

taking into account the `currency pair`,`exchange`, and `exchange type`. 

"""


WITH trade_index_pairs AS (
    SELECT
        trades.transaction_id,
        trades.currency_1,
        trades.currency_2,
        trades.exchange,
        trades.exchange_type,
        trades.executed_at,
        indexes.updated_at,
        indexes.value AS index_value,
        ABS(EXTRACT(EPOCH FROM (trades.executed_at - indexes.updated_at))) AS time_difference -- Assumes Postgres
    FROM
        trades
    INNER JOIN indexes ON trades.currency_1 = indexes.currency_1
        AND trades.currency_2 = indexes.currency_2
        AND trades.exchange = indexes.exchange
        AND trades.exchange_type = indexes.exchange_type
), ranked_pairs AS (
    SELECT
        trade_index_pairs.transaction_id,
        trade_index_pairs.currency_1,
        trade_index_pairs.currency_2,
        trade_index_pairs.exchange,
        trade_index_pairs.exchange_type,
        trade_index_pairs.executed_at,
        trade_index_pairs.updated_at,
        trade_index_pairs.index_value,
        trade_index_pairs.time_difference,
        ROW_NUMBER() OVER(PARTITION BY trade_index_pairs.transaction_id ORDER BY trade_index_pairs.time_difference ASC) AS rank
    FROM
        trade_index_pairs
)
SELECT
    transaction_id,
    currency_1,
    currency_2,
    exchange,
    exchange_type,
    executed_at,
    updated_at,
    index_value,
    rank
FROM
    ranked_pairs; -- Remove the ;
-- WHERE
--    rank = 1;

-- Remove all comments before running query if you want rank 1 transactions 