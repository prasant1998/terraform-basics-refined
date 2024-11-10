If a resource or module block includes a for_each argument whose value is a map or a set of strings, Terraform creates one instance for each member of that map or set.

for_each loops over each name in the user_names variable and creates a user resource with each name.
each.key represents the current item in the loop, so each IAM user will be named ram, shyam, or happy.


For the second block example:

for_each iterates over the users_with_roles map. each.key gives the user name, and each.value provides the role, which I added as a tag.


Use set(string) when we need unique values without specific ordering. Example USeCase: 	Unique usernames, tags, or labels
Use map(string) when we need key-value associations, where each key maps to a value. Example UseCase: User-role mappings, instance configs

For the Last Block

for_each iterates over each security group in security_groups, Each security group gets a name (from each.key) and a description.
Using a dynamic block inside the security group, we iterate over ingress_ports for each group, creating ingress rules for each port.
Using dynamic blocks helps reduce repetition and makes our code cleaner and more flexible.

dynamic "<block_name>" {
  for_each = <collection>      # The collection to iterate over (e.g., list, set)
  content {
    <block_content>            # The contents for each generated block
  }
}



Difference b/w count and for_each.

count: Best for simple, uniform lists. Resources are accessed by numeric indexes (0, 1, 2...).
for_each: Best for sets/maps where each item is distinct. Resources are accessed by unique keys, making them easier to manage and less error-prone in large infrastructures.