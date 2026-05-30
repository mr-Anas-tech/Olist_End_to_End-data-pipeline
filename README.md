# Olist_End_to_end-data-pipeline
olist e-commerce    data_analyst+analytics_engineering    project
# Olist E-Commerce End-to-End Cloud Data Engineering & Analytics Pipeline

An enterprise-grade, cloud-native data pipeline engineered to ingest, transform, govern, and analyze large-scale e-commerce 
transactional operations. This project transitions raw relational data sources into an optimized Modern Data Stack (MDS) built around **Google BigQuery**, **dbt Cloud**, and automated pipelines.

---

## 🏗️ Architecture & Technology Stack
* **Language:** Python (Pandas, Google Cloud Client Libraries)
* **Cloud Data Warehouse:** Google BigQuery
* **Data Transformation Layer:** dbt Cloud (Data Build Tool)
* **Data Governance & Testing:** dbt Core Test Assertions & Schema Validations
* **BI Connectivity:** Power BI Desktop ( Import via BigQuery Native Connector)

---

## 🛠️ Pipeline Implementation & Engineering Phases

### 1. Cloud Data Ingestion (Python to Google BigQuery)
* **Secure Authentication:** Developed a robust programmatic ingestion script utilizing Python and Google Cloud Service Account JSON keys to bypass manual uploads and ensure secure API handshakes.
* **Storage Ingestion Layer:** Processed and streamed raw relational datasets into target landing staging tables inside **Google BigQuery**, serving as our immutable single source of truth (Raw Layer).

* <img width="1080" height="675" alt="Screenshot 2026-05-30 084142" src="https://github.com/user-attachments/assets/cc6cb3a3-183d-485c-9638-db91170388c3" />
<img width="1333" height="773" alt="Screenshot 2026-05-30 084118" src="https://github.com/user-attachments/assets/d55e67aa-74c3-4638-9eda-7fde5f09820d" />
<img width="866" height="634" alt="Screenshot 2026-05-30 084055" src="https://github.com/user-attachments/assets/99b75197-d973-45e9-8410-2ef48ccf03a2" />


### 2. Analytical dbt Data Modeling (The Multi-Layer Core)
Using dbt Cloud, the warehouse was structured into a decoupled, highly modular multi-layer architecture to enforce performance, scalability, and structural clarity:

* **Source Layer (`src_...`):** Modeled baseline configuration layers mapping directly onto BigQuery tables, decoupling raw structures from downstream dependencies.
* **Staging Layer (`stg_...`):** Performed primary data cleansing, explicitly renamed business attributes for global accessibility, sanitized anomalies, and cast raw string datatypes into optimized Date/Timestamp structures.
* **Intermediate Layer (`int_...`):** Engineered advanced, complex business logic joins and grain aggregations. A core model developed here was `int_order_reviews_sentiments`, which aggregates star-ratings and processes dynamic conditional rules at a strict single `order_id` grain.
* **Marts Layer (`dim_...` / `fct_...`):** Built the final consumer-facing analytical models. Standardized production-ready Dimension tables (e.g., Customers, Products) and Fact tables (e.g., Orders, Reviews) optimized for sub-second query execution.

### 3. Data Governance, Quality Testing & Documentation
To ensure high data integrity before reports generation, strict automated governance models were embedded within the dbt compile runtime:
* **Schema Constraints:** Implemented `unique` and `not_null` automated dbt assertions across primary keys (such as `order_id` and `customer_id`) to mitigate risk of row duplication or orphan joins.
* **Business Logic Validation:** Configured `accepted_values` validation arrays on engineered attributes like `review_sentiment` to guarantee data uniformity ('Positive', 'Neutral', 'Negative') throughout pipeline changes.
* **In-Line Documentation:** Documented the structural properties, ownership parameters, and definitions of individual attributes inside centralized `schema.yml` configuration manifests, auto-compiling data lineage models.

### 4. Downstream BI Engine Integration
* **BigQuery Connector Integration:** Connected the finalized consumer-facing Marts layer seamlessly into Power BI via the native Google BigQuery Data Connector. 
* **Optimized Dimensional Architecture:** The schema design maps data at optimized grains to facilitate dynamic, sub-second cross-filtering across metrics without requiring heavy memory usage on the reporting client side.
* **Insights  And  Data  Story:
* Executive  Insights:

​1. Sales & Revenue Story
​The Golden Months: The business year starts strong, maintaining over $1.0M in monthly revenue. Sales climb steadily through the spring, peaking in May at $1.5M. After a slight drop in June, sales spike again in August.  
​The September Crash: Right after the August peak, the business experiences a massive crash. In September and October, revenue plunges to its lowest points of the year.  
​The Winter Recovery: November sees a strong recovery, bringing revenue back up to the $1.0M mark before finishing the year with a slight dip in December.  

​The City Champions: São Paulo is the undisputed king of this business, generating a massive $1.93M in revenue alone. The next closest competitor is Rio de Janeiro at $1.0M. Other cities like Belo Horizonte, Brasília, and Curitiba are small fish compared to São Paulo's massive market size.  
​Top Products: Revenue is spread evenly among five major categories. Health & Beauty is the top earner at $1.26M, closely followed by Watches/Gifts, Bed/Bath/Table, Sports/Leisure, and Computers/Accessories. 

  
​2. Logistics & Delivery Story
​Operational Baseline: On average, packages are delivered in 12 days, which is safely below the promised delivery buffer of 23 days. This operational efficiency helps the business maintain a low overall late delivery rate of just under 7%.
​The Seasonality of Speed: Delivery speeds change with sales volume. In February and March, average delivery times peak at nearly 16 days. During the slower month of August, delivery efficiency is at its best, dropping down to around 9 days.
​The Shipping Bottlenecks: São Paulo handles the most packages, but it has a healthy delivery system. The real problems are in states like Alagoas and Maranhão, where up to 20% of orders arrive late.


​3. Customer Satisfaction Story
​Strong Foundation: The store has an incredible base of customer satisfaction, boasting 76K Positive Reviews driving a strong 5/5 Overall Rating Score.
​The Operational Danger Zone: There is a major warning sign with an operational bottleneck of 15K Negative Reviews that requires immediate attention.
​Product Pain Points: When filtering by customer complaints, Bed/Bath/Table and Health & Beauty pop up with the highest count of negative feedback. Because these are the highest-selling categories, they are also causing the most customer friction.
<img width="1294" height="753" alt="Screenshot 2026-05-30 084536" src="https://github.com/user-attachments/assets/44393089-80b5-4d17-bcf5-6c4d2269a198" />
<img width="1247" height="729" alt="Screenshot 2026-05-30 084512" src="https://github.com/user-attachments/assets/abd7f819-610c-4325-a44a-f9746f37419e" />
<img width="1112" height="675" alt="Screenshot 2026-05-30 084457" src="https://github.com/user-attachments/assets/77612f83-6ac9-4fec-8d95-d404b42ab3a5" />




**************************************   Dashoard Link :

https://drive.google.com/file/d/1-zbIDhSKpA0D8xzyANfQcEjErilHP-Tv/view?usp=sharing

