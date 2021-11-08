import json
import boto3

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('SimpleCRM')
    
    response = table.delete_item(
        Key={
            'id': event['id']
        })
    return {
        'statusCode': 200,
        'body': json.dumps(event['id'] + ' has been deleted.')
    }
