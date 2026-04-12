-- ============================================================
-- PROJECT 1: Catastrophe Risk Modeling & Loss Estimation
-- SQL Queries for Actuarial Risk Analysis
-- Target: Munich Re, Swiss Re, General Re
-- ============================================================


-- ── QUERY 1: Top 10 Deadliest Countries ─────────────────────
-- Business Use: Identifies highest-risk geographies for
-- reinsurance underwriting decisions and treaty pricing

SELECT country_name,
       ROUND(SUM(deaths), 0)               AS total_deaths,
       ROUND(AVG(deaths), 1)               AS avg_deaths_per_year,
       ROUND(SUM(economic_damage_usd), 2)  AS total_damage_usd
FROM   disasters
WHERE  deaths > 0
GROUP  BY country_name
ORDER  BY total_deaths DESC
LIMIT  10;


-- ── QUERY 2: Annual Global Disaster Trend ───────────────────
-- Business Use: Shows if disaster frequency/severity is
-- increasing over time — drives premium trend loading

SELECT year,
       ROUND(SUM(deaths), 0)               AS global_deaths,
       ROUND(SUM(economic_damage_usd), 2)  AS global_damage_usd,
       COUNT(DISTINCT country_code)         AS countries_affected
FROM   disasters
WHERE  deaths > 0
GROUP  BY year
ORDER  BY year;


-- ── QUERY 3: Decade-by-Decade Loss Comparison ───────────────
-- Business Use: Actuaries use decade trends to detect
-- long-term loss inflation for reinsurance treaty pricing

SELECT CASE
           WHEN year BETWEEN 1970 AND 1979 THEN '1970s'
           WHEN year BETWEEN 1980 AND 1989 THEN '1980s'
           WHEN year BETWEEN 1990 AND 1999 THEN '1990s'
           WHEN year BETWEEN 2000 AND 2009 THEN '2000s'
           ELSE '2010s'
       END                                         AS decade,
       ROUND(SUM(deaths), 0)                       AS total_deaths,
       ROUND(AVG(deaths), 1)                       AS avg_annual_deaths,
       ROUND(SUM(economic_damage_usd) / 1e9, 2)    AS total_damage_billion_usd
FROM   disasters
GROUP  BY decade
ORDER  BY decade;


-- ── QUERY 4: Country Risk Tiering ───────────────────────────
-- Business Use: Risk tiers drive reinsurance premium loading.
-- EXTREME RISK countries require higher treaty attachment points

SELECT country_name,
       COUNT(CASE WHEN deaths > 0 THEN 1 END)      AS disaster_years,
       ROUND(MAX(deaths), 0)                        AS worst_year_deaths,
       ROUND(AVG(CASE WHEN deaths > 0
                      THEN deaths END), 0)           AS avg_loss_when_hit,
       CASE
           WHEN AVG(deaths) > 5000 THEN 'EXTREME RISK'
           WHEN AVG(deaths) > 1000 THEN 'HIGH RISK'
           WHEN AVG(deaths) > 100  THEN 'MEDIUM RISK'
           ELSE 'LOW RISK'
       END                                           AS risk_tier
FROM   disasters
GROUP  BY country_name
HAVING disaster_years > 5
ORDER  BY avg_loss_when_hit DESC;


-- ── QUERY 5: Worst Single-Year Catastrophes ─────────────────
-- Business Use: Stress testing — identifies tail events
-- used for 1-in-100 and 1-in-200 year scenario analysis

SELECT country_name,
       year,
       deaths,
       ROUND(economic_damage_usd / 1e9, 2)   AS damage_billion_usd,
       RANK() OVER (ORDER BY deaths DESC)     AS death_rank
FROM   disasters
ORDER  BY deaths DESC
LIMIT  15;


-- ── QUERY 6: Geographic Concentration Risk ──────────────────
-- Business Use: Reinsurers must manage portfolio concentration.
-- High concentration in one region = correlated loss risk

SELECT country_name,
       ROUND(SUM(deaths) * 100.0 /
             (SELECT SUM(deaths) FROM disasters), 2)  AS pct_of_global_deaths,
       ROUND(SUM(economic_damage_usd) * 100.0 /
             (SELECT SUM(economic_damage_usd)
              FROM disasters), 2)                      AS pct_of_global_damage
FROM   disasters
GROUP  BY country_name
ORDER  BY pct_of_global_deaths DESC
LIMIT  10;
