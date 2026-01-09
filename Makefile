PATH := $(HOME)/ansible/.venv/bin:$(PATH)

.PHONY: prod staging

# var for tags
TAGS ?=

staging:
	ansible-playbook -i inventories/staging playbooks/$(filter-out staging,$(MAKECMDGOALS)).yml $(if $(TAGS),--tags $(TAGS))

prod:
	@read -p "Deploy to PROD? (yes/no): " a; [ "$$a" = "yes" ]
	ansible-playbook -i inventories/prod playbooks/$(filter-out prod,$(MAKECMDGOALS)).yml $(if $(TAGS),--tags $(TAGS))

%:
	@: