import json
import boto3

def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))
    
    if "source" not in event:
        print("Event source is not available")
        return
    
    event_source = event["source"]
    event_details = event["detail"]
    
    if event_source != "aws.ec2":
        print("Event source is not AWS Ec2")
        return
    
    if "instance-id" not in event_details:
        print("Instance Id is not available in the event")
        return
    
    instance_id = event_details["instance-id"]
    
    instance_state = event_details["state"]
    
    if instance_state == "running":
        ec2 = boto3.resource('ec2')
        instances = ec2.instances.filter(Filters=[{'Name': 'instance-id', 'Values': [instance_id]}])
        for instance in instances:
            tags = instance.tags
            tagName = "application"
            tagValue = "devops"
            tagPresent = False
            for tag in tags:
                if tag["Key"] == tagName:
                    tagPresent = True
                    break
            if not tagPresent:
                print("Adding tag "+tagName)
                ec2.create_tags(Resources=[instance_id], Tags=[{'Key':tagName, 'Value':tagValue}])
                print("Added tag to instance "+instance_id)
            else:
                print("Tag "+tagName+" already available")
    else:
        print("Instance state change "+instance_state+" requires no actions")
        
    return "Added tag to instance"
