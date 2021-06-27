tunnel-web:
	ssh -L 8081:localhost:443 vagrant@localhost -p 2200 -i web/.vagrant/machines/default/virtualbox/private_key

tunnel-db:
	ssh -L 8081:localhost:443 vagrant@localhost -p 2222 -i db/.vagrant/machines/default/virtualbox/private_key

ssh-web:
	(cd web && vagrant ssh)

ssh-db:
	(cd db && vagrant ssh)