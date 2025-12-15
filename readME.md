# About this project

ETL Pipeline project that cleans US Customs & Border Patrol data from the years 2019 to 2020 with the purpose on comparing and contrasting both years based on COVID. The csv data is not included in the project directory as the magnitute of the files will make github have an egg :egg:

# Directory
- **poc_work:**
    You can find proof of concept related work inside this folder. As well as sample data and the ERD Diagram for the SQL database.

- **ETL Notebooks:**
    These three notebooks is where the ETL pipeline took place. To undertand the pipeline, traverse the documents as so:
    - **main_file.ipynb**: Reads in raw csv files, performs rudamentary cleaning and saves them as parquets for size purposes
    - **readying_data.ipynb**: Process of creating the lookup tables and transferring the header.csv information into these lookup tables. Header table data is reduced to ids that match up based on the lookup table ids. Further cleaning is done here and files are almost SQL ready.
    - **final_cleaning.ipynb**: Any values in the lookup tables that are out of place are removed. Similarly to this, the rows with these junk values are also removed to achieve the silver layer in the medallion architecture
    - These files represent a way to automate the cleaning steps shown, all that needs to be done is change some parameters and you can produce the same output.

- **SQL Queries:**
    These three SQL files show the process of the 'L' in an ETL pipeline
    - **creating_tables.sql**: Creating lookup tables and main shipments table, specifying foreign keys and their relation
    - **bulk_inserting_data.sql**: Inserting data into their appropriate tables, these tables were checked after to make sure all data entered successfully.
    - **creating_indexes.sql**: For faster searching, after the data was entered, indexes were made for shorter query times.


MISSING:
    - Notebook that does something with the data for the usecase
    - At least 5 views that show meaningful aggregation