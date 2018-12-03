def save():
    l1 = [str(args[i]) for i in range(1,12)]
    l2 = ["api-vmId1-WLA01, snapshot_id, volume_id, network_id, key_name, autoscaling_id, vm_ip, vm_status, server_id, vmId_origin, vmorigin_ip, vmorigin_status, serverorigin_id, image_id", "\n", str(args[0]) + ",," + ','.join(l1)+ "," + str(args[13])]
    with open("/home/jmeter/NCHC_Swagger/WL-A01/OOO/id-"+str(args[12])+".csv", "w") as f:
        for i in l2:
            f.write(i)

save()
