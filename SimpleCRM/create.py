import json
import logging
import boto3

dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    # data = json.loads(event['body'])
    # if 'id' not in data:
    #     logging.error("Validation Failed")
    #     raise Exception("Couldn't create the todo item.")

    table = dynamodb.Table('SimpleCRM')
    
    # all_customers = table.scan()
    # if event['id'] in all_customers:
    #     raise Exception("Customer ID exists.")
    # else:
    response = table.put_item(
        Item={
            'id': event['id'],
            'firstName': event['firstName'],
            'lastName': event['lastName'],
            'Address': event['Address']
        }
    )

    return {
        'statusCode': response['ResponseMetadata']['HTTPStatusCode'],
        'body': 'Record ' + event['id'] + ' added.'
    }