.PHONY: fmt validate plan clean

fmt:
	terraform fmt -recursive

validate: fmt
	terraform validate

plan: fmt validate
	terraform plan -out=tfplan

clean:
	rm -f tfplan
