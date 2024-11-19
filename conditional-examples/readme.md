
Ternary Operator.

```
condition ? true_value : false_value

If the condition evaluates to true, the true_value is returned. Otherwise, the false_value is returned.

```

# Simple Example

This Example shows the working of ternary operator

If var.enable_feature is true, the output will be "Feature is enabled".
If var.enable_feature is false, the output will be "Feature is disabled".

---

# Using Conditionals with count

If var.create_instance is true, one EC2 instance will be created (count = 1).
If var.create_instance is false, no EC2 instance will be created (count = 0).

---

# Default Value for Security Group

We want to set a default value for a security group rule based on whether an input variable for enable_https is true or false.

If enable_https is true, the rule will allow inbound traffic on port 443 (HTTPS).
If enable_https is false, the rule will allow inbound traffic on port 80 (HTTP).

---

# Creating Resources Conditionally

We want to create an S3 bucket only if a specific variable (create_bucket) is set to true. Otherwise, the bucket won't be created.

If create_bucket is true, the S3 bucket will be created.
If create_bucket is false, the bucket will not be created because count will be 0.

---

# Creating Conditional Outputs Based on a Map

We have a map of different environments (dev, prod, etc.) and we want to filter out the environments that should be deployed based on a list of allowed environments.

The for expression filters the environments map to include only the environments present in allowed_environments.

Let’s break it into parts:

for env, name in var.environments:
This loops through the var.environments map.
env is the key (e.g., dev, prod).
name is the value (e.g., development, production).

env => name:
This adds the key (env) and value (name) to the output map.

if contains(var.allowed_environments, env):

This checks if the key (env) exists in var.allowed_environments.
If env is allowed, it adds the key-value pair to the result.

---


# Setting Resource Tags Based on Conditions

We want to assign different tags to an AWS EC2 instance depending on the environment (dev, prod, etc.).

If environment is "prod", the instance will have tags specific to production.
If environment is "dev", the tags will reflect development.
If neither, it will default to "Unknown".

---

# Dynamically Setting a Region for AWS Resources

We want to choose a region for AWS resources based on the environment:

Based on the environment, the region local will be set dynamically.

If environment is "prod", the region will be "us-east-1".
If "dev", it will be "us-west-1", and for other values, it defaults to "us-east-2".

---

# Setting Optional Tags for Resources

If tags is provided (i.e., not an empty map), the custom tags will be used.
If no tags are provided, a default "Environment" = "Default" tag will be added.