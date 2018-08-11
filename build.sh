#!/bin/bash

# Build the executable
(cd src/client && env GOOS=linux go build -o main client.go)

# Zip
zip dist/client/client.zip src/client/main

# Remove the executable
rm src/client/main

# Give the zip to Terraform
mv dist/client/client.zip terraform/dist/client.zip
