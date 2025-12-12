USE ROLE accountadmin;
CREATE OR REPLACE DATABASE course_repo;
USE SCHEMA public;

-- Create credentials
CREATE OR REPLACE SECRET course_repo.public.github_pat
  TYPE = password
  USERNAME = 'asadali27232'
  PASSWORD = '';

SHOW SECRETS;

-- Create the API integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/asadali27232') -- URL to your GitHub profile
  ALLOWED_AUTHENTICATION_SECRETS = (course_repo.public.github_pat)
  ENABLED = TRUE;
  

-- Create the git repository object
CREATE OR REPLACE GIT REPOSITORY course_repo.public.advanced_data_engineering_snowflake
  API_INTEGRATION = git_api_integration -- Name of the API integration defined above
  ORIGIN = 'https://github.com/asadali27232/advanced-data-engineering-snowflake.git' -- Insert URL of forked repo
  GIT_CREDENTIALS = course_repo.public.github_pat;

-- List the git repositories
SHOW GIT REPOSITORIES;