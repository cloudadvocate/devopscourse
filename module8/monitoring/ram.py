import psutil
import os 

def ram_usage_psutils():
    memory = psutil.virtual_memory()
    print('RAM memory % used:', memory[2])
    print('RAM Used (GB):', memory[3]/1000000000)
    

ram_usage_psutils()