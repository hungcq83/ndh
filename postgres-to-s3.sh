#!/bin/bash

# Set AWS region to ap-southeast-2 (Sydney)
aws configure set region ap-southeast-2

# Install psql12 client
yes | sudo amazon-linux-extras install postgresql12
mkdir output

# Pull table configs from S3
aws s3 cp s3://hungcq40-postgres-data/table_config.txt .

# Retrieve DB username & password
export DB_USER=$(aws ssm get-parameters --names "/db/prod/username" --with-decryption --query "Parameters[0].Value" | tr -d '"')
export DB_PASSWORD=$(aws ssm get-parameters --names "/db/prod/password" --with-decryption --query "Parameters[0].Value" | tr -d '"')

# Read tables from config file
while read p; do
  echo "Exporting table $p"
  sed "s/TABLE_NAME/$p/g" query_script.sql > tmp.sql
  psql postgresql://$DB_USER:$DB_PASSWORD@postgres.cgofck3bbjnu.ap-southeast-2.rds.amazonaws.com:5432/postgres -f tmp.sql -o output/$p.json -t
  echo "Exported $p"
done <table_config.txt

# Upload exported json files to S3
aws s3 cp output/ s3://hungcq40-postgres-data/ --recursive
echo 'Done copying files to s3'
