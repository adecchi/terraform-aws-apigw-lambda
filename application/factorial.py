import json
import sys
import datetime

def lambda_handler(event, context):
    data = eval(event['body'])
    n = int(data['n'])
    result = factorial(n)
    data = dict()
    data['result'] = str(result)
    data['time'] = str(datetime.datetime.now())
    return {
        'statusCode': 200,
        'body': json.dumps(data)
    }


def factorial(n):
    fact = 1
    for i in range(1,n+1): 
        fact = fact * i
    return (fact)
