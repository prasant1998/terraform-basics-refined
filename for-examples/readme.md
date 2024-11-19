# Filter Instances by Tags and Modify Data


We want to filter instances that have a specific tag (e.g., "Environment" = "dev") and generate a list of their IDs.

The for expression filters the instances list to return only the IDs of instances that have the Environment tag set to "dev".

---

# Convert a List of Subnets into a Map

The subnets variable contains a list of objects, each with name and cidr attributes.

The for expression transforms this list into a map where the keys are the subnet names, and the values are the corresponding CIDR blocks.\

---

# Flatten a List of Lists

The subnets_by_region variable contains a list of objects, where each object has a region and a subnets list.

The for expression extracts the subnets list from each region and then flattens them into a single list using the flatten() function.



