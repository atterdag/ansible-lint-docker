# Use official Python base image
FROM python:3.13-slim-bookworm

ARG DATE=19700101

LABEL maintainer="Valdemar Lemche <valdemar@lemche.net>" \
      name="atterdag/ansible-lint" \
      version="$DATE"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1


# Install system dependencies
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        libssl-dev \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for the workspace
RUN mkdir -p /workspace /.ansible /logs

# Create a non-root user and switch to it
RUN useradd --create-home --shell /bin/bash ansible \
    && chown -R ansible:ansible /workspace /.ansible /logs
USER ansible
WORKDIR /home/ansible

# Ensure user installed pip package executables are in the PATH
ENV PATH="/home/ansible/.local/bin:${PATH}"

# Upgrade pip
RUN pip install --user --upgrade pip

# Install Python dependencies
RUN pip install --user --no-cache-dir \
    ansible \
    ansible-core \
    ansible-compat

# Install ansible-lint
RUN pip install --user --no-cache-dir ansible-lint

# Set the working directory
VOLUME /workspace
WORKDIR /workspace

# Set entrypoint for the container
ENTRYPOINT ["ansible-lint"]

# Set default command
CMD ["ansible-lint", "--help"]
