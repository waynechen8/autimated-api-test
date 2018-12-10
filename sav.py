def save():
    l1 = [str(args[i]) for i in range(1,12)]
    l2 = [str(args[0]) + ",," + ','.join(l1)+ "," + str(args[13]) + '\n']
    with open("/home/jmeter/NCHC_Swagger/WL-A01/OOO/id-q.csv", "a") as f:
        for i in l2:
            f.write(i)

save()
with open("/home/jmeter/NCHC_Swagger/WL-A01/OOO/id.csv", "r") as f:
    con = f.readlines()

snap = con[-10:]
ss = [con[i].split(",") for i in range(len(con))]

