print ("INSERT INTO student(first,last) VALUES ")
for i in range(420):
    print("('Jean",i+42,"','Dupont'), ('Jeanne",i+42,"','Dupont'),")
print("('Martin','Janin');")

import random

print ("INSERT INTO grade VALUES ")
for i in range(420):
    for j in range(4242):
        print("(",i+46,",",j+46,",",random.randint(0,10),"),")
print("(45,45,0);")