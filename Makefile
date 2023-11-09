.PHONY: list commit save load tag push run

# Variables
IMAGE_NAME = my-ubuntu-guix
TAG = latest
USERNAME = your_username
SAVE_PATH = my-ubuntu-guix.tar

# Targets
list:
	@docker ps

commit:
	@$(eval CONTAINER_ID=$(shell docker ps -q --filter ancestor=$(IMAGE_NAME)))
	@docker commit $(CONTAINER_ID) $(IMAGE_NAME):$(TAG)
	@echo "Committed container $(CONTAINER_ID) as $(IMAGE_NAME):$(TAG)"

save:
	@docker save $(IMAGE_NAME):$(TAG) -o $(SAVE_PATH)
	@echo "Saved image to $(SAVE_PATH)"

load:
	@docker load -i $(SAVE_PATH)
	@echo "Loaded image from $(SAVE_PATH)"

tag:
	@docker tag $(IMAGE_NAME):$(TAG) $(USERNAME)/$(IMAGE_NAME):$(TAG)
	@echo "Tagged image as $(USERNAME)/$(IMAGE_NAME):$(TAG)"

push:
	@docker push $(USERNAME)/$(IMAGE_NAME):$(TAG)
	@echo "Pushed image to $(USERNAME)/$(IMAGE_NAME):$(TAG)"

run:
	@docker run --privileged -it $(IMAGE_NAME)
