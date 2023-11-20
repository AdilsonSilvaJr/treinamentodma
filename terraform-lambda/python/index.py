import pandas as pd
import pyarrow as pa
import pyarrow.parquet as pq
import io
import boto3
from datetime import datetime


def lambda_handler(event, context):

    # Start Lambda
    print("Start Lambda: " + datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
    # Get the current timestamp for the bucket path
    bucket_path = datetime.now().strftime("year=%Y/month=%m/day=%d/time=%H%M%S")

    # Get the S3 bucket and key from the event
    bucket = event['detail']['bucket']['name']
    key = event['detail']['object']['key']

    # Read CSV from S3
    s3 = boto3.client('s3')
    response = s3.get_object(Bucket=bucket, Key=key)
    csv_content = response['Body'].read().decode('utf-8')
    df = pd.read_csv(io.StringIO(csv_content))
    print(df)

    # Transform data (modify as needed)
    # For example, you can add a new column or perform other transformations

    # Write Parquet to S3 with the file name and path
    parquet_output = io.BytesIO()
    parquet_key = f"transactions/{bucket_path}/transactions.parquet"
    print(" " + parquet_key)
    pq.write_table(pa.Table.from_pandas(df), parquet_output)
    parquet_output.seek(0)

    output_bucket = "treinamentodma-077169358277-silver"
    s3.put_object(Body=parquet_output, Bucket=output_bucket, Key=parquet_key)

    # Final Lambda
    print("Final Lambda: " + datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

    return {
        'statusCode': 200,
        'body': f'CSV to Parquet conversion successful. Parquet file: {parquet_key}'
    }
