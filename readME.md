# About this project

ETL Pipeline project that cleans US Customs & Border Patrol data from the years 2019 to 2020 with the purpose on comparing and contrasting both years based on COVID. The csv data is not included in the project directory as the magnitute of the files will make github have an egg :egg:

An additional dataset was used for the coordinates of the cities the ports reside in. You can find the data set here: [Dataset Link](https://www.kaggle.com/datasets/juanmah/world-cities?resource=download)

# Directory
- **poc_work:**
    You can find proof of concept related work inside this folder. As well as sample data and the ERD Diagram for the SQL database.

- **ETL Notebooks:**
    These notebooks is where the ETL pipeline took place. To understand the pipeline, traverse the documents as so:
    - **main_file.ipynb**: Reads in raw csv files, performs rudamentary cleaning and saves them as parquets for size purposes
    - **readying_data.ipynb**: Process of creating the lookup tables and transferring the header.csv information into these lookup tables. Header table data is reduced to ids that match up based on the lookup table ids. Further cleaning is done here and files are almost SQL ready.
    - **final_cleaning.ipynb**: Any values in the lookup tables that are out of place are removed. Similarly to this, the rows with these junk values are also removed to achieve the silver layer in the medallion architecture
    - These files represent a way to automate the cleaning steps shown, all that needs to be done is change some parameters and you can produce the same output.
    - **port_coordinates.ipynb**: Additional notebook that cleans an external dataset for the coordinates of most of the ports in the data. 

- **SQL Queries:**
    These SQL files show the process of the 'L' in an ETL pipeline
    - **creating_tables.sql**: Creating lookup tables and main shipments table, specifying foreign keys and their relation
    - **bulk_inserting_data.sql**: Inserting data into their appropriate tables, these tables were checked after to make sure all data entered successfully.
    - **creating_indexes.sql**: For faster searching, after the data was entered, indexes were made for shorter query times.
    - **making_view_queries.sql**: For our use case, 8 views were made so that there could be a variety in the amount of data being displayed. You can check out the code for the views made in this file!

- **Use Case Files:**
    - **using_db.ipynb**: Connects to the sql server db and uses most of the views created to create some data visualization. You can check out samples of the views inside the notebook as all of the view's data was outputted for validation.

- Additional files include the heatmap used in the presentation, and some csvs containing information for some views as a way to reuse them in pandas, as well as the color map for available colors in matplotlib.


<img src="https://i.imgur.com/KMiITkF.jpg" alt="Life as a DE (Just Kidding :D)" width="200"/>
Life as a DE (Just Kidding :D)
