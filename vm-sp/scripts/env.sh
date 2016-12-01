#!/bin/bash

SERVICE_USER_GROUP=vagrant:vagrant

ENV_SRC_DIR=/apps/git/borrow-env
ENV_TARGET_DIR=/apps/borrow

cp -rp "$ENV_SRC_DIR"/* "$ENV_TARGET_DIR"
chown -R "$SERVICE_USER_GROUP" "$ENV_TARGET_DIR"
