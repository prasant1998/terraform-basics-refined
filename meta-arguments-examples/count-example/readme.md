count is a meta-argument defined by the Terraform language. It can be used with modules and with every resource type.

count.index — The distinct index number (starting with 0) corresponding to this instance.

If our instances are almost identical, count is appropriate. If some of their arguments need distinct values that can't be directly derived from an integer, it's safer to use for_each.

Difference b/w count and for_each.

count: Best for simple, uniform lists. Resources are accessed by numeric indexes (0, 1, 2...).
for_each: Best for sets/maps where each item is distinct. Resources are accessed by unique keys, making them easier to manage and less error-prone in large infrastructures.