# A DATA TRANSFORMATION-VISUALIZATION PROJECT
> Hi, this is my final project for my DE course, where I'll be convert raw data into a more accessible format for extracting insights.

## Table of Contents
* [Project Goal](#project-goal)
* [Task](#task)
* [Technologies Used](#technologies-used)
* [How I Did It](#how-i-did-it)
* [Data Report](#data-report)
* [Improvements](#improvements)

## Project Goal
- "In this project, we'll use dbt (Data Build Tool) and SQL on Google BigQuery for data transformation. Our goal is to convert raw data into a more accessible format for extracting insights. dbt, an open-source tool, will help us effectively transform data in our warehouses."
- "We'll use SQL for data management and Google BigQuery, a fully-managed, serverless data warehouse, for super-fast SQL queries."

## Technologies Used
- dbt
- Google BigQuery
- Visual Studio Code for query statements
- Looker Studio for visualization

## Task
- Collect raw data about a jewelry business.
- Data Ingestion.
- Transform data to dimensional model in Bigquery.
- Visualize the data.

## How I Did It
- Research the raw data.
- Create a virtual machine on Google Cloud compute engine, where I'll be storing raw data on Mongodb.
- Crawl missing data from the business website (product_names, location, ect.)
- Load data into GCS and Bigquery using Cloud Function.
- Transform data using dbt.
> ![database](https://github.com/user-attachments/assets/ac8b7afe-0c75-400e-b4c7-46ceb7cdabff)
> Or you can view the model [here](https://drawsql.app/teams/uit-22/diagrams/glamia-data-mart) to see more description.

- Load transformed data from Bigquery into Looker Studio for visualization. 

## Data Report
![overview](https://github.com/user-attachments/assets/3bfab6ef-04ba-44b8-9a9e-d4a8f0c210dd)
![product](https://github.com/user-attachments/assets/0be2bce9-ea42-44f9-bace-3eca1bae29c0)
![location](https://github.com/user-attachments/assets/35689159-28cb-441d-bdb4-5464460d8433)

> Or click [here](https://lookerstudio.google.com/reporting/ca98663e-7cc9-4440-a152-a6def267a76d) to view the report.

## Improvements
> My code is still not fully optimal yet, any feedback would be very helpful!
> Thank you!
