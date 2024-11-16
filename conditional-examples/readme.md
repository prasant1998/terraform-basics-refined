
Ternary Operator.

```
condition ? true_value : false_value

If the condition evaluates to true, the true_value is returned. Otherwise, the false_value is returned.

```

# Simple Example

This Example shows the working of ternary operator

If var.enable_feature is true, the output will be "Feature is enabled".
If var.enable_feature is false, the output will be "Feature is disabled".

# Using Conditionals with count

If var.create_instance is true, one EC2 instance will be created (count = 1).
If var.create_instance is false, no EC2 instance will be created (count = 0).