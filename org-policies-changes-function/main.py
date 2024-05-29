import base64
import os
import smtplib
import json
from email.mime.text import MIMEText


def send_email(subject: str, message_body: str) -> None:
    """
    Function for sending emails with a given subject and body.
    """
    # SMTP server details
    smtp_server = os.environ.get('SMTP_SERVER')
    smtp_port = int(os.environ.get('SMTP_PORT', 25))  # Default to port 25 if not provided
    # smtp_user = os.environ.get('SMTP_USER')
    # smtp_password = os.environ.get('SMTP_PASSWORD')
    
    from_email = os.environ.get('FROM_EMAIL')
    to_email = os.environ.get('GROUP_EMAIL')

    # Create the email content
    msg = MIMEText(message_body, 'html')
    msg['Subject'] = subject
    msg['From'] = from_email
    msg['To'] = to_email

    server = smtplib.SMTP(smtp_server, smtp_port)
    # server.starttls()  # Upgrade the connection to a secure encrypted SSL/TLS connection
    # server.login(smtp_user, smtp_password)
    server.sendmail(from_email, [to_email], msg.as_string())
    server.quit()


def get_topic_massage(event, context):
    """
    Triggered by a change in organization policy logged to Pub/Sub.
    """
    pubsub_message = base64.b64decode(event['data']).decode('utf-8')
    pubsub_message_dict = json.loads(pubsub_message)
    method = pubsub_message_dict["protoPayload"]["methodName"]
    user = pubsub_message_dict["protoPayload"]["authenticationInfo"]["principalEmail"]
    if method == "google.cloud.orgpolicy.v2.OrgPolicy.CreatePolicy":
        policy = pubsub_message_dict["protoPayload"]["request"]["policy"]["name"].split("/")[-1]
    else:
        policy = pubsub_message_dict["protoPayload"]["resourceName"].split("/")[-1]
    if method == "google.cloud.orgpolicy.v2.OrgPolicy.DeletePolicy":
        policy_value = { "enforce": True }
    elif method != "SetOrgPolicy":
        policy_value = pubsub_message_dict["protoPayload"]["response"]["spec"]["rules"][0]
    else:
        policy_value = pubsub_message_dict["protoPayload"]["response"]["booleanPolicy"]
        if policy_value == {}:
            policy_value = { "enforce": False }
    try:
        project_id = pubsub_message_dict["resource"]["labels"]["project_id"]
    except:
        pass
    
    if project_id:
        massage_body = f"""
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Organization Policy Changed</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
<div class="bg-gray-200 p-4">
  <div class="max-w-xl mx-auto bg-white shadow-lg rounded-lg overflow-hidden">
    <div class="bg-red-600 p-4 text-white text-lg font-bold">
      Alert: GCP Organization Policy Changed
    </div>
    <div class="p-4">
      <p class="text-gray-800">Dear GCPDevOps Team,</p>
      <p class="mt-3 text-gray-600">A change in the GCP organization policy was detected. Details:</p>
    </div>
    <div class="bg-gray-100 p-4 text-sm">
      <p>Method: {method}</p>
      <p>Project ID: {project_id}</p>
      <p>User: {user}</p>
      <p>Policy: {policy}</p>
      <p>Policy value: {policy_value}</p>
    </div>
  </div>
</div>
<script src="https://cdn.tailwindcss.com"></script>
</body>
</html>

"""
    else:
        massage_body = f"""
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Organization Policy Changed</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
<div class="bg-gray-200 p-4">
  <div class="max-w-xl mx-auto bg-white shadow-lg rounded-lg overflow-hidden">
    <div class="bg-red-600 p-4 text-white text-lg font-bold">
      Alert: GCP Organization Policy Changed
    </div>
    <div class="p-4">
      <p class="text-gray-800">Dear GCPDevOps Team,</p>
      <p class="mt-3 text-gray-600">A change in the GCP organization policy was detected. Details:</p>
    </div>
    <div class="bg-gray-100 p-4 text-sm">
      <p>Method: {method}</p>
      <p>User: {user}</p>
      <p>Policy: {policy}</p>
      <p>Policy value: {policy_value}</p>
    </div>
  </div>
</div>
<script src="https://cdn.tailwindcss.com"></script>
</body>
</html>

"""
    # print(massage_body)
    
    # Create the email subject and body
    subject = "Alert: GCP Organization Policy Changed"
    message_body = massage_body

    # Send the notification email
    send_email(subject, message_body)