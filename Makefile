PLAN_FILE ?= plan.json

plan:
    cd terraform/environments/dev && \
    terraform init && \
    terraform plan -out=plan.tfplan && \
    terraform show -json plan.tfplan > ../../$(PLAN_FILE)

test-policy:
    conftest test $(PLAN_FILE) -p policy/terraform
