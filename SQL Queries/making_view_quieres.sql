-- Queries are commented so that they won't show errors
-- This is a list of all queries ran to create all views for my use case


--TOP 10 Exporter Ports in 2019 Vs 2020
--run this select statement to get the answer!
/*
SELECT *
FROM (
    SELECT 
        s.port_lading_id,
        p.port_of_lading,
        COUNT(*) AS shipment_count,
        2019 AS shipment_year,
        ROW_NUMBER() OVER (PARTITION BY 2019 ORDER BY COUNT(*) DESC) AS rn
    FROM shipments_2019.dbo.shipments s
    JOIN shipments_2019.dbo.port_of_lading p
        ON s.port_lading_id = p.port_lading_id
    GROUP BY s.port_lading_id, p.port_of_lading

    UNION ALL

    SELECT 
        s.port_lading_id,
        p.port_of_lading,
        COUNT(*) AS shipment_count,
        2020 AS shipment_year,
        ROW_NUMBER() OVER (PARTITION BY 2020 ORDER BY COUNT(*) DESC) AS rn
    FROM shipments_2020.dbo.shipments s
    JOIN shipments_2020.dbo.port_of_lading p
        ON s.port_lading_id = p.port_lading_id
    GROUP BY s.port_lading_id, p.port_of_lading
) t
WHERE rn <= 10
ORDER BY shipment_year, rn;


CREATE VIEW TopPorts AS
SELECT *
FROM (
    SELECT 
        s.port_lading_id,
        p.port_of_lading,
        COUNT(*) AS shipment_count,
        2019 AS shipment_year,
        ROW_NUMBER() OVER (PARTITION BY 2019 ORDER BY COUNT(*) DESC) AS rn
    FROM shipments_2019.dbo.shipments s
    JOIN shipments_2019.dbo.port_of_lading p
        ON s.port_lading_id = p.port_lading_id
    GROUP BY s.port_lading_id, p.port_of_lading

    UNION ALL

    SELECT 
        s.port_lading_id,
        p.port_of_lading,
        COUNT(*) AS shipment_count,
        2020 AS shipment_year,
        ROW_NUMBER() OVER (PARTITION BY 2020 ORDER BY COUNT(*) DESC) AS rn
    FROM shipments_2020.dbo.shipments s
    JOIN shipments_2020.dbo.port_of_lading p
        ON s.port_lading_id = p.port_lading_id
    GROUP BY s.port_lading_id, p.port_of_lading
) t
WHERE rn <= 10;





CREATE VIEW TopImporters AS
SELECT *
FROM (
    SELECT 
        s.port_unlading_id,
        p.port_of_unlading,
        COUNT(*) AS shipment_count,
        2019 AS shipment_year,
        ROW_NUMBER() OVER (PARTITION BY 2019 ORDER BY COUNT(*) DESC) AS rn
    FROM shipments_2019.dbo.shipments s
    JOIN shipments_2019.dbo.port_of_unlading p
        ON s.port_unlading_id = p.port_unlading_id
    GROUP BY s.port_unlading_id, p.port_of_unlading

    UNION ALL

    SELECT 
        s.port_unlading_id,
        p.port_of_unlading,
        COUNT(*) AS shipment_count,
        2020 AS shipment_year,
        ROW_NUMBER() OVER (PARTITION BY 2020 ORDER BY COUNT(*) DESC) AS rn
    FROM shipments_2020.dbo.shipments s
    JOIN shipments_2020.dbo.port_of_unlading p
        ON s.port_unlading_id = p.port_unlading_id
    GROUP BY s.port_unlading_id, p.port_of_unlading
) t
WHERE rn <= 10;



-- Views for checking the estimated arrival time vs the actual arrival time


CREATE VIEW arrival_date_diffs_2020 AS 
SELECT 
    s.identifier,
    a.arrival_date,
    e.estimated_arrival_date,
    DATEDIFF(DAY, e.estimated_arrival_date, a.arrival_date) AS days_difference
FROM shipments_2020.dbo.shipments s
JOIN shipments_2020.dbo.arrival_date a
    ON s.arrival_date_id = a.arrival_date_id
JOIN shipments_2020.dbo.estimated_arrival_date e
    ON s.estimated_arrival_id = e.estimated_arrival_id;
GO

CREATE VIEW ManifestSummaryByYear AS
SELECT
    shipment_year,
    COUNT_BIG(*) AS total_shipments,
    SUM(CAST(m.manifest_quantity AS BIGINT)) AS total_containers,
    AVG(CAST(m.manifest_quantity AS FLOAT)) AS avg_containers_per_shipment
FROM (
    SELECT 
        2019 AS shipment_year,
        s.manifest_quantity_id
    FROM shipments_2019.dbo.shipments s

    UNION ALL

    SELECT 
        2020 AS shipment_year,
        s.manifest_quantity_id
    FROM shipments_2020.dbo.shipments s
) y
JOIN shipments_2019.dbo.manifest_quantities m
    ON y.manifest_quantity_id = m.manifest_quantity_id
GROUP BY shipment_year;


CREATE VIEW ManifestYoYChange AS
SELECT
    p.port_of_lading,

    SUM(
        CASE 
            WHEN shipment_year = 2019 
            THEN CAST(m.manifest_quantity AS BIGINT)
            ELSE 0
        END
    ) AS containers_2019,

    SUM(
        CASE 
            WHEN shipment_year = 2020 
            THEN CAST(m.manifest_quantity AS BIGINT)
            ELSE 0
        END
    ) AS containers_2020,

    SUM(
        CASE 
            WHEN shipment_year = 2020 
            THEN CAST(m.manifest_quantity AS BIGINT)
            ELSE 0
        END
    )
    -
    SUM(
        CASE 
            WHEN shipment_year = 2019 
            THEN CAST(m.manifest_quantity AS BIGINT)
            ELSE 0
        END
    ) AS container_change

FROM (
    SELECT 2019 AS shipment_year, port_lading_id, manifest_quantity_id
    FROM shipments_2019.dbo.shipments

    UNION ALL

    SELECT 2020 AS shipment_year, port_lading_id, manifest_quantity_id
    FROM shipments_2020.dbo.shipments
) y
JOIN shipments_2019.dbo.manifest_quantities m
    ON y.manifest_quantity_id = m.manifest_quantity_id
JOIN shipments_2019.dbo.port_of_lading p
    ON y.port_lading_id = p.port_lading_id
GROUP BY p.port_of_lading;



CREATE VIEW TopPortsByContainers AS
SELECT *
FROM (
    SELECT
        shipment_year,
        port_of_lading,
        total_containers,
        ROW_NUMBER() OVER (
            PARTITION BY shipment_year
            ORDER BY total_containers DESC
        ) AS rn
    FROM (
        SELECT
            shipment_year,
            p.port_of_lading,
            SUM(CAST(m.manifest_quantity AS BIGINT)) AS total_containers
        FROM (
            SELECT 2019 AS shipment_year, port_lading_id, manifest_quantity_id
            FROM shipments_2019.dbo.shipments

            UNION ALL

            SELECT 2020 AS shipment_year, port_lading_id, manifest_quantity_id
            FROM shipments_2020.dbo.shipments
        ) y
        JOIN shipments_2019.dbo.manifest_quantities m
            ON y.manifest_quantity_id = m.manifest_quantity_id
        JOIN shipments_2019.dbo.port_of_lading p
            ON y.port_lading_id = p.port_lading_id
        GROUP BY shipment_year, p.port_of_lading
    ) s
) t
WHERE rn <= 10;


CREATE VIEW EstimatedArrivalAccuracyByYear AS
SELECT
    shipment_year,

    COUNT_BIG(*) AS total_shipments,


    AVG(CAST(DATEDIFF(
        DAY,
        e.estimated_arrival_date,
        a.arrival_date
    ) AS FLOAT)) AS avg_signed_error_days,

    AVG(CAST(ABS(DATEDIFF(
        DAY,
        e.estimated_arrival_date,
        a.arrival_date
    )) AS FLOAT)) AS avg_absolute_error_days,

    SUM(CASE WHEN a.arrival_date > e.estimated_arrival_date THEN 1 ELSE 0 END) AS late_shipments,
    SUM(CASE WHEN a.arrival_date < e.estimated_arrival_date THEN 1 ELSE 0 END) AS early_shipments,
    SUM(CASE WHEN a.arrival_date = e.estimated_arrival_date THEN 1 ELSE 0 END) AS on_time_shipments

FROM (
    SELECT 
        2019 AS shipment_year,
        arrival_date_id,
        estimated_arrival_id
    FROM shipments_2019.dbo.shipments

    UNION ALL

    SELECT 
        2020 AS shipment_year,
        arrival_date_id,
        estimated_arrival_id
    FROM shipments_2020.dbo.shipments
) y
JOIN shipments_2019.dbo.arrival_date a
    ON y.arrival_date_id = a.arrival_date_id
JOIN shipments_2019.dbo.estimated_arrival_date e
    ON y.estimated_arrival_id = e.estimated_arrival_id
GROUP BY shipment_year;
*/