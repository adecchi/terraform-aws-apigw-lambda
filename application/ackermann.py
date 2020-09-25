import json
import sys
import datetime
sys.setrecursionlimit(2**31-1)

def lambda_handler(event, context):
    data = eval(event['body'])
    n = int(data['n'])
    m = int(data['m'])
    result = ackermann(m,n)
    data = dict()
    data['result'] = str(result)
    data['time'] = str(datetime.datetime.now())
    return {
        'statusCode': 200,
        'body': json.dumps(data)
    }

def ackermann(m, n):
    if m == 0:
        return n + 1
    if n == 0:
        return ackermann(m - 1, 1)
    n2 = ackermann(m, n - 1)
    return ackermann(m - 1, n2)
