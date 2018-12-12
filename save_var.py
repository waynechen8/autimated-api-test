def save():
    l1 = [str(args[i]) for i in range(16)]
    l2 = [','.join(l1)+ "\n"]
    with open("/home/jmeter/NCHC_Swagger/WL-A01/OOO/config/id.csv", "a") as f:
        for i in l2:
            f.write(i)

save()
