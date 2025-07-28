# ansible-lint docker container

## Building

Build the image with following commands if you want to build it by hand.

```bash
docker image rm atterdag/ansible-lint:25.6.1 atterdag/ansible-lint:latest
docker buildx build --build-arg DATE=$(date +%Y%m%d) --tag atterdag/ansible-lint:25.6.1 --tag atterdag/ansible-lint:latest .
docker push atterdag/ansible-lint:latest
docker push atterdag/ansible-lint:25.6.1
```

## Running

```bash
docker run --rm --tty --volume <full or relative path to ansible code>:/workspace atterdag/ansible-lint <ansible YAML file(s)> [<ansible-lint switches>]
```

## Example

```bash
docker run --rm --tty --volume ~/src/github/atterdag/ansible-filters-ldif/test:/workspace atterdag/ansible-lint inventory.yml playbook.yml --parseable
```
