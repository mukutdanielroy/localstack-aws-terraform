import json
import logging
import boto3
from botocore.exceptions import ClientError
import os

def lambda_function(event, context):
    if event.get('httpMethod') == 'GET' and event.get('queryStringParameters'):
        file_name = str(event.get('queryStringParameters'))
        response = create_presigned_url(os.environ['BUCKET_NAME'], file_name)
        return {'statusCode' : 200, 'body' : json.dumps({'message' : 'ok', 'url' : response})}
    else:
        return {'statusCode' : 404, 'body' : json.dumps({'message' : 'The requested resource was not found. Query e.g. url?filename=test.txt'})}

def create_presigned_url(bucket_name, object_name, expiration=3600):
    s3_client = boto3.client('s3')
    try:
        response = s3_client.generate_presigned_url('put_object',
                                                    Params={'Bucket': bucket_name,
                                                            'Key': object_name},
                                                    ExpiresIn=expiration)
    except ClientError as e:
        logging.error(e)
        return "Problem in s3 object creation"
    return response