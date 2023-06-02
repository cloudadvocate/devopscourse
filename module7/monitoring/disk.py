import logging
import os
import sys

from psutil import disk_usage



def make_logger():
    log = logging.getLogger(__name__)
    log.setLevel(logging.INFO)
    formatter = logging.Formatter('%(filename)s - %(asctime)s - %(levelname)s - %(message)s')
    handler = logging.StreamHandler(sys.stdout)
    handler.setFormatter(formatter)
    log.addHandler(handler)
    return log

logger = make_logger()

def display_disk_usage(disk):
    disk = disk_usage(os.path.realpath(disk))
    print(disk)
    #double-asterisk (**) is defined as an Exponentiation Operator
    #// operator is to do integer division (i.e., quotient without remainder);
    logger.info((disk.total // (2 ** 30)))
    logger.info("Used disk space: %d GiB" % (disk.used // (2 ** 30)))
    logger.info("Free disk space: %d GiB" % (disk.free // (2 ** 30)))
    logger.info("Used disk percentage: %d" % disk.percent + '%')
    return disk.percent

def check_for_threshold(threshold, partition):
    disk_usage_percent = display_disk_usage(partition)
    if disk_usage_percent > threshold:
        logger.error("Disk usage exceeds threshold")
        
check_for_threshold(50, "/")