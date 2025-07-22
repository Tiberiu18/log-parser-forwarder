apply_terraform:
	terraform init
	terraform apply -var-file=./terraform/projectAWS/modules/environments/dev/main.tfvars


generate_inventory:
	EC2_IP=$(terraform output -raw instance_public_ip)
	USERNAME=$(terraform output -raw ec

	cat > inventory.ini << EOF
	[ec2]
	ec2 ansible_host=$EC2_IP ansible_user=
EOF

ansible_config:
	ansible-playbook -i ansible/inventory.ini deploy.yml

k8s_deploy:
	kubectl apply -f k8s/bare

pipeline: apply_terraform ansible_config k8s_deploy
