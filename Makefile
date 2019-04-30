build: get
	swag init
	go build

get:
	go get ./... 

build_prod: get
	swag init
	env GOOS=linux GOARCH=arm go build	

deploy: build_prod
	rsync -avzhe ssh justlog root@apollo.gempir.com:/home/justlog/
	ssh root@apollo.gempir.com systemctl restart justlog.service

provision: 
	ansible-playbook -i ansible/hosts ansible/playbook.yml --ask-vault-pass ${ARGS}