from operator import itemgetter
with open("/home/jmeter/NCHC_Swagger/WL-A01/OOO/config/WL-A01-ooo_env.csv", "r") as f:
    env = f.readlines()

w = [env[i].split(",") for i in range(len(env))]
key = [w[i][3]+'\n' for i in range(1,len(env))]

with open("/home/jmeter/NCHC_Swagger/WL-A01/OOO/config/id.csv", "r") as f:
    origin = f.readlines()

ss = [origin[i].split(",") for i in range(len(origin))]
networkid = [ss[0][2]] + [int(ss[i][2]) for i in range(1,len(origin))]

# if number of thread is n, then find the last n networkids
reverse = networkid[::-1]
set_networkid = set([int(ss[i][2]) for i in range(1,len(origin))])
o = [origin[i] for i in [len(networkid)-1-reverse.index(i) for i in set_networkid]]

# make order of api-keys in id.csv the same as those in env.csv
gg = [i.split(',') for i in o]
key_in_id = [gg[i][15] for i in range(len(o))]
form = dict(zip(key_in_id, range(len(key_in_id))))
Y = [form[i] for i in key]
o = [o[i] for i in Y]
o.insert(0, origin[0])

with open("/home/jmeter/NCHC_Swagger/WL-A01/OOO/config/id1.csv", "w") as f:
    for line in o:
        f.write(line)
