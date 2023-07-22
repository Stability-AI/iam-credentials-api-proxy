#!/bin/bash

git clone https://github.com/Stability-AI/iam-credentials-api-proxy /root/iam-credentials-api-proxy
cp /root/iam-credentials-api-proxy/ica.service /etc/systemd/system/ica.service
icahost=$(aws secretsmanager get-secret-value --secret-id "ICAproxyHostname" --query SecretString --output text --region "us-west-2")
sed -i "s|target_hostname|$icahost|g" /etc/systemd/system/ica.service
systemctl daemon-reload
systemctl enable ica.service
systemctl start ica.service
