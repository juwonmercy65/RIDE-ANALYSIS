# 📊 RideShare Business Intelligence Project: From Raw Data to 200% Growth Insights

## Project Overview
This project is a detailed **Data Analysis and Business Intelligence (BI) workflow** performed on a simulated ride-sharing platform's operational data. The primary goal was to process four interconnected datasets, perform rigorous data cleaning, and execute **8 core business questions** using **Advanced SQL (PostgreSQL)** to deliver actionable strategic recommendations.

**Key Outcome:** Uncovered a massive **200.9% Year-over-Year (YoY) Revenue Growth** alongside a critical, hidden **19.27% operational cancellation leak** in a major city.

## 💾 Data Sources
The analysis was conducted on four core datasets (tables) that describe the platform's operations:

1.  **`RIDES`**: Contains ride details (status, distance, fare, city, dates).
2.  **`DRIVERS`**: Contains driver information (name, signup date, city, rating).
3.  **`RIDERS`**: Contains rider information (name, signup date, city).
4.  **`PAYMENTS`**: Contains payment transaction details (method, amount).

## 🧹 Data Cleaning and Preparation Process

Data quality was ensured through a two-stage cleaning process (initial Excel preparation followed by final validation in Postgres):

### Stage 1: Initial Cleanup (across all datasets)
* **Standardization**: Standardized city names and ride status in the `RIDES` table.
* **Invalid Data Removal**: Removed invalid (negative or zero) fares from `RIDES` and eliminated invalid/negative amounts from `PAYMENTS`.
* **Consistency**: Corrected payment method inconsistencies in `PAYMENTS`.
* **Structure**: Separated all timestamp columns (in `RIDES`, `PAYMENTS`, `DRIVERS`, and `RIDERS`) into distinct date and time columns for easier query execution.

### Stage 2: Postgres Validation (Final Layer)
* ]**Case Consistency**: Updated all city names across tables to ensure uniform case consistency (e.g., 'calgary' -> 'Calgary').
* **Integrity Checks**: Deleted records in the `RIDES` table where the fare or distance was zero.
* **Constraint Enforcement**: Restricted the `driver_rating` column in the `DRIVERS` table to valid values between **1.0 and 5.0**.
* **Financial Validation**: Removed records with zero or negative payment amounts from the `PAYMENTS` table.

## 📈 Key Performance Indicators (KPIs) & Findings

The following 8 business questions were answered using complex SQL queries involving Joins, CTEs, Window Functions (e.g., `LAG()`, `ROW_NUMBER()`), and conditional aggregations.

| # | KPI / Business Question | Key SQL Technique Used | Primary Finding |
|---|---|---|---|
| **1** | Find the top 10 longest rides by distance, driver, and payment.  | `INNER JOIN`, `ORDER BY LIMIT` | The top 10 ranged from 30 km down to 29.99 km, with the two longest (30 km) paid by **Voucher**. |
| **2** | How many riders signed up in 2021 still took rides in 2024?  | `EXTRACT(YEAR)`, `COUNT(DISTINCT)` | **2,051** riders remained active in 2024. |
| **3** | Compare quarterly revenue and identify the quarter with the biggest YoY growth.  | `LAG()` Window Function, `CTE` | **Q2 2022** had the biggest YoY growth at a substantial **200.9%**. |
| **4** | Calculate average monthly rides for each driver and find the top 5 most consistent.  | Conditional `COUNT(DISTINCT)` for "Active Months" | The highest consistency was **Driver\_627** at **1.69** average rides per active month. |
| **5** | Calculate the cancellation rate per city and identify the highest city.  | Conditional Aggregation (`SUM(CASE WHEN...)`), `NULLIF` | **Chicago** had the highest cancellation rate at **19.27%**. |
| **6** | Identify riders with >10 rides who never paid with cash.  | `HAVING` clause with Conditional Aggregation (`SUM(CASE WHEN method = 'Cash'`) | **17 riders** met this criteria, indicating a segment reliant solely on digital payments. |
| **7** | Find the top 3 drivers in each city by total revenue earned.  | `ROW_NUMBER()` Window Function with `PARTITION BY city` | Successfully ranked drivers; e.g., **Driver\_1176** was the top revenue earner in Boston. |
| **8** | Identify the top 10 drivers qualified for a bonus (≥30 rides, ≥4.5 rating, <5% cancellation).  | Filtered `WHERE` clause on calculated metrics (`completed_rides`, `avg_rating`, `cancellation_rate`) | Only two drivers, **Driver\_1005** and **Driver\_1181**, met all three rigorous conditions. |

1. Find the top 10 longest rides (by distance), including driver name, rider name, pickup/dropoff cities, and payment method.

Output: 

<img width="721" height="362" alt="image" src="https://github.com/user-attachments/assets/84141131-5a26-4aba-a3e0-1bbf2a52adbc" />


2. How many riders who signed up in 2021 still took rides in 2024?

Output:

<img width="579" height="343" alt="image" src="https://github.com/user-attachments/assets/00773ac8-7ec8-43d6-8cd8-65d61e3151aa" />
 

3. Compare quarterly revenue between 2021, 2022, 2023, and 2024. Which quarter had the biggest YoY growth?

Output: 

<img width="691" height="427" alt="image" src="https://github.com/user-attachments/assets/7b7cf239-752c-4cab-ae76-11fb423315c3" />



4. For each driver, calculate their average monthly rides since signup. Who are the top 5 drivers with the highest consistency (most rides per active month)?

Output: 

<img width="475" height="194" alt="image" src="https://github.com/user-attachments/assets/1348252f-8ac7-46e8-9aeb-bd4247422528" />
 


5. Calculate the cancellation rate per city and identify which city had the highest cancellation rate?

Output:

<img width="692" height="295" alt="image" src="https://github.com/user-attachments/assets/0839f111-e575-42fa-9b60-ba60c0443275" />
 


6. Identify riders who have taken more than 10 rides but never paid with cash.

Output:

<img width="789" height="541" alt="image" src="https://github.com/user-attachments/assets/c07e0bd1-0438-43b7-86ca-d15ab45d7f4d" />

7. Find the top 3 drivers in each city by total revenue earned between June 2021 and Dec 2024. If a driver has multiple cities, count revenue where they picked up passengers in that city. 

Output: 

<img width="435" height="748" alt="image" src="https://github.com/user-attachments/assets/8b5db30a-3fd7-45a6-89fa-8c17d7b6a362" />


8. Management wants to know the top 10 drivers that are qualified to receive bonuses using the criteria below;
at least 30 rides completed,
an average rating ≥ 4.5, and
a cancellation rate under 5%.

Output:

<img width="611" height="141" alt="image" src="https://github.com/user-attachments/assets/d85ceeaf-372e-4bd9-9562-8e79df6acbc9" />


 
## 🛠️ Technology and Tools

* **Database**: PostgreSQL
* **Language**: SQL
* **Environment**: PGAdmin/DBeaver (for execution)

## SUMMARY
An analysis of the hng-ride data reveals several key performance and operational insights: The top 5 drivers with the highest consistency (average rides per active month) are Driver_627 (1.69), followed by Driver_1232 (1.67), Driver_431 (1.67), Driver_1207 (1.67), and Driver_104 (1.63). Financial performance saw a massive surge in Q2 2022, which registered the biggest Year-over-Year growth at a substantial 200.9%. However, operational efficiency is challenged by a high cancellation rate in Chicago at 19.27%. In terms of driver incentives, only Driver_1005 and Driver_1181 meet all three criteria for a bonus: ≥30 completed rides, ≥ 4.5 average rating, and a cancellation rate <5%. The platform's reach is highlighted by the top 10 longest rides (ranging from 29.99 km to 30 km), with the two absolute longest rides covering extreme distances like Calgary to Los Angeles, and Ottawa to Vancouver, all while long-distance journeys utilize diverse payment methods including voucher, cash, and card, and the platform retains a strong user base, with 2,051 riders who signed up in 2021 remaining active in 2024. Finally, 17 riders were identified as having taken more than 10 rides but never paid with cash.


## RECOMMENDATIONS
It is recommended that management investigate the specific causes of the high cancellations in Chicago to implement targeted operational improvements, while simultaneously leveraging the Driver Consistency metric (led by Driver_627 at 1.69) to identify and potentially mentor other drivers, and ensure all qualified high-performing drivers like Driver_1005 and Driver_1181 are recognized and incentivized to maintain service quality.
