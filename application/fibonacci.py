import json
import sys
import datetime
sys.setrecursionlimit(2**31-1)

def lambda_handler(event, context):
    data = eval(event['body'])
    number = int(data['number'])
    result = fibonacci(number)
    data = dict()
    data['result'] = str(result)
    data['time'] = str(datetime.datetime.now())
    return {
        'statusCode': 200,
        'body': json.dumps(data)
    }

fibonacci_array = [0, 1]
def fibonacci(n):
    if n < 0:
        return("Insert positive numbers")
    elif n <= len(fibonacci_array):
        return fibonacci_array[n-1]
    else:
        temp_array = fibonacci(n-1)+fibonacci(n-2)
        fibonacci_array.append(temp_array)
        return temp_array
