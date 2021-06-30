tunnel-web-80:
	ssh -L 80:localhost:80 vagrant@localhost -p 2200 -i web/.vagrant/machines/default/virtualbox/private_key

tunnel-web-443:
	ssh -L 443:localhost:443 vagrant@localhost -p 2200 -i web/.vagrant/machines/default/virtualbox/private_key

ssh-web:
	(cd web && vagrant ssh)

ssh-db:
	(cd db && vagrant ssh)
