import pyodbc

conn = pyodbc.connect(
    'DRIVER={SQL SERVER};'
    'SERVER=WIN-IC9MOEJ3N7C\\SQLEXPRESS;'  
    'DATABASE=master;'                   
    'Trusted_Connection=yes;'
)

cursor = conn.cursor()
cursor.execute("SELECT image_data FROM photos WHERE id = 1")
row = cursor.fetchone()

if row and row[0]:
    with open("retrieved_image.jpg", "wb") as file:
        file.write(row[0])
    print("Image successfully saved as 'retrieved_image.jpg'")
else:
    print("No image found with that ID.")
