use shipments;


BULK INSERT dbo.arrival_date FROM "C:\data\cleaned_\2020\lookup_table_files\arrival_date_lookup.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
BULK INSERT dbo.estimated_arrival_date FROM "C:\data\cleaned_\2020\lookup_table_files\estimated_arrival_lookup.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
BULK INSERT dbo.manifest_quantities FROM "C:\data\cleaned_\2020\lookup_table_files\manifest_units_lookup.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
BULK INSERT dbo.port_of_lading FROM "C:\data\cleaned_\2020\lookup_table_files\port_of_lading_lookup.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0d0a', FIRSTROW=2, FIELDQUOTE = '"', CODEPAGE='65001');
BULK INSERT dbo.port_of_unlading FROM "C:\data\cleaned_\2020\lookup_table_files\port_of_unlading_lookup.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0d0a', FIRSTROW=2,  FIELDQUOTE='"', CODEPAGE='65001');
BULK INSERT dbo.[weight] FROM "C:\data\cleaned_\2020\lookup_table_files\weight_lookup.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
BULK INSERT dbo.weight_units FROM "C:\data\cleaned_\weight_unit_lookup.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
BULK INSERT dbo.shipments FROM "C:\data\cleaned_\2020\header_table_files\header_0.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
BULK INSERT dbo.shipments FROM "C:\data\cleaned_\2020\header_table_files\header_1.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
BULK INSERT dbo.shipments FROM "C:\data\cleaned_\2020\header_table_files\header_2.csv" WITH (FORMAT='CSV', ROWTERMINATOR = '0x0a', FIRSTROW=2);
