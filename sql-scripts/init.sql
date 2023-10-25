CREATE TABLE trades (
    transaction_id INT,
    exchange VARCHAR,
    exchange_type VARCHAR,
    account_id INT,
    client_id INT,
    currency_1 VARCHAR,
    currency_2 VARCHAR,
    from_address VARCHAR,
    to_address VARCHAR,
    executed_at TIMESTAMP,
    size FLOAT,
    price FLOAT
);
CREATE TABLE indexes (
    currency_1 VARCHAR,
    currency_2 VARCHAR,
    value FLOAT,
    updated_at TIMESTAMP,
    exchange VARCHAR,
    exchange_type VARCHAR
);
INSERT INTO trades (
        transaction_id,
        exchange,
        exchange_type,
        account_id,
        client_id,
        currency_1,
        currency_2,
        from_address,
        to_address,
        executed_at,
        size,
        price
    )
VALUES (
        1,
        'Binance',
        'Spot',
        101,
        1001,
        'BTC',
        'USDT',
        'Address1',
        'Address2',
        TIMESTAMP '2023-01-01 09:00:00 UTC',
        0.5,
        40000.0
    ),
    (
        2,
        'Binance',
        'Spot',
        102,
        1002,
        'ETH',
        'BTC',
        'Address3',
        'Address4',
        TIMESTAMP '2023-01-02 10:30:00 UTC',
        2.0,
        2500.0
    ),
    (
        3,
        'Kraken',
        'Spot',
        103,
        1003,
        'BTC',
        'USDT',
        'Address5',
        'Address6',
        TIMESTAMP '2023-01-03 14:15:00 UTC',
        1.0,
        41000.0
    ),
    (
        4,
        'Kraken',
        'Spot',
        104,
        1004,
        'ETH',
        'BTC',
        'Address7',
        'Address8',
        TIMESTAMP '2023-01-04 11:45:00 UTC',
        3.0,
        2400.0
    ),
    (
        5,
        'Coinbase',
        'Spot',
        105,
        1005,
        'BTC',
        'USD',
        'Address9',
        'Address10',
        TIMESTAMP '2023-01-05 08:30:00 UTC',
        0.7,
        39000.0
    ),
    (
        6,
        'Coinbase',
        'Spot',
        106,
        1006,
        'ETH',
        'USD',
        'Address11',
        'Address12',
        TIMESTAMP '2023-01-06 16:20:00 UTC',
        1.5,
        2300.0
    ),
    (
        7,
        'Binance',
        'Futures',
        107,
        1007,
        'BTC',
        'USDT',
        'Address13',
        'Address14',
        TIMESTAMP '2023-01-07 12:00:00 UTC',
        1.2,
        40500.0
    ),
    (
        8,
        'Binance',
        'Futures',
        108,
        1008,
        'ETH',
        'BTC',
        'Address15',
        'Address16',
        TIMESTAMP '2023-01-08 10:45:00 UTC',
        4.0,
        2600.0
    ),
    (
        9,
        'Kraken',
        'Futures',
        109,
        1009,
        'BTC',
        'USDT',
        'Address17',
        'Address18',
        TIMESTAMP '2023-01-09 14:00:00 UTC',
        2.2,
        41200.0
    ),
    (
        10,
        'Kraken',
        'Futures',
        110,
        1010,
        'ETH',
        'BTC',
        'Address19',
        'Address20',
        TIMESTAMP '2023-01-10 09:30:00 UTC',
        0.8,
        2450.0
    ),
    (
        11,
        'Coinbase',
        'Futures',
        111,
        1011,
        'BTC',
        'USD',
        'Address21',
        'Address22',
        TIMESTAMP '2023-01-11 13:45:00 UTC',
        1.8,
        38800.0
    ),
    (
        12,
        'Coinbase',
        'Futures',
        112,
        1012,
        'ETH',
        'USD',
        'Address23',
        'Address24',
        TIMESTAMP '2023-01-12 15:10:00 UTC',
        2.5,
        2250.0
    ),
    (
        13,
        'Binance',
        'Spot',
        113,
        1013,
        'BTC',
        'USDT',
        'Address25',
        'Address26',
        TIMESTAMP '2023-01-13 09:15:00 UTC',
        0.3,
        40300.0
    ),
    (
        14,
        'Binance',
        'Spot',
        114,
        1014,
        'ETH',
        'BTC',
        'Address27',
        'Address28',
        TIMESTAMP '2023-01-14 17:05:00 UTC',
        1.2,
        2550.0
    ),
    (
        15,
        'Kraken',
        'Spot',
        115,
        1015,
        'BTC',
        'USDT',
        'Address29',
        'Address30',
        TIMESTAMP '2023-01-15 12:30:00 UTC',
        0.6,
        40900.0
    );
INSERT INTO indexes (
        currency_1,
        currency_2,
        value,
        updated_at,
        exchange,
        exchange_type
    )
VALUES (
        'BTC',
        'USDT',
        40000.0,
        TIMESTAMP '2023-01-01 09:05:00 UTC',
        'Binance',
        'Spot'
    ),
    (
        'ETH',
        'BTC',
        2500.0,
        TIMESTAMP '2023-01-02 10:40:00 UTC',
        'Binance',
        'Spot'
    ),
    (
        'BTC',
        'USDT',
        41000.0,
        TIMESTAMP '2023-01-03 14:20:00 UTC',
        'Kraken',
        'Spot'
    ),
    (
        'ETH',
        'BTC',
        2400.0,
        TIMESTAMP '2023-01-04 11:50:00 UTC',
        'Kraken',
        'Spot'
    ),
    (
        'BTC',
        'USD',
        39000.0,
        TIMESTAMP '2023-01-05 08:35:00 UTC',
        'Coinbase',
        'Spot'
    ),
    (
        'ETH',
        'USD',
        2300.0,
        TIMESTAMP '2023-01-06 16:25:00 UTC',
        'Coinbase',
        'Spot'
    ),
    (
        'BTC',
        'USDT',
        40500.0,
        TIMESTAMP '2023-01-07 12:05:00 UTC',
        'Binance',
        'Futures'
    ),
    (
        'ETH',
        'BTC',
        2600.0,
        TIMESTAMP '2023-01-08 10:50:00 UTC',
        'Binance',
        'Futures'
    ),
    (
        'BTC',
        'USDT',
        41200.0,
        TIMESTAMP '2023-01-09 14:05:00 UTC',
        'Kraken',
        'Futures'
    ),
    (
        'ETH',
        'BTC',
        2450.0,
        TIMESTAMP '2023-01-10 09:35:00 UTC',
        'Kraken',
        'Futures'
    ),
    (
        'BTC',
        'USD',
        38800.0,
        TIMESTAMP '2023-01-11 13:50:00 UTC',
        'Coinbase',
        'Futures'
    ),
    (
        'ETH',
        'USD',
        2250.0,
        TIMESTAMP '2023-01-12 15:15:00 UTC',
        'Coinbase',
        'Futures'
    ),
    (
        'BTC',
        'USDT',
        40300.0,
        TIMESTAMP '2023-01-13 09:20:00 UTC',
        'Binance',
        'Spot'
    ),
    (
        'ETH',
        'BTC',
        2550.0,
        TIMESTAMP '2023-01-14 17:10:00 UTC',
        'Binance',
        'Spot'
    ),
    (
        'BTC',
        'USDT',
        40900.0,
        TIMESTAMP '2023-01-15 12:35:00 UTC',
        'Kraken',
        'Spot'
    );
