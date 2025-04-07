-- Create the database if it does not already exist
CREATE DATABASE IF NOT EXISTS testing;

-- Switch to the 'testing' database
USE testing;

-- Grant specific privileges (alter, create, execute routines) on the 'moneymaker' database to 'emadbuser'
GRANT ALTER ROUTINE, CREATE ROUTINE, EXECUTE ON testing.* TO 'testdbuser'@'%';

-- Apply the privilege changes
FLUSH PRIVILEGES;
