#!/bin/bash
set -xe

dnf update -y

dnf install -y amazon-ssm-agent
systemctl enable --now amazon-ssm-agent

dnf install -y amazon-cloudwatch-agent

cat <<EOF > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
{
  "metrics": {
    "append_dimensions": {
      "InstanceId": "\${aws:InstanceId}"
    },
    "metrics_collected": {
      "mem": {
        "measurement": [
          "mem_used_percent"
        ]
      },
      "disk": {
        "measurement": [
          "used_percent"
        ],
        "resources": [
          "/"
        ]
      }
    }
  }
}
EOF

dnf install -y docker
systemctl enable --now docker
usermod -aG docker ec2-user

docker pull bjisu/gfs-backend:latest
docker rm -f backend || true
docker run -d \
  --name backend \
  -p 8080:8080 \
  --restart always \
  bjisu/gfs-backend:latest
