#!/bin/bash
#
# Validate that the repository has the following structure:
# -- README.md
# -- main.tf
# -- db.tf
# -- autoscaling.tf
# -- lb.tf
#
# The repository can also have ecs.tf or ec2.tf but these are not tested.

failed=0
for file in README.md main.tf db.tf autoscaling.tf lb.tf; do
    if [ ! -f "$file" ]; then
        echo "FAIL: Missing $file"
        failed=1
    fi
done

if [ $failed -eq 1 ]; then
    echo "Repository structure is not valid. Please fix the errors above."
    exit 1
fi

