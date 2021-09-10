import json

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda Sept 10. Some updates now.. Just some randome words!')
    }
