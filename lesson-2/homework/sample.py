import csv

data = [
    [1, 'Alice'],
    [2, 'Bob'],
    [3, 'Charlie'],
    [4, 'David'],
    [5, 'Eve']
]

with open('worker_data.csv', 'w', newline='') as file:
    writer = csv.writer(file)
    writer.writerows(data)

print("CSV file created!")