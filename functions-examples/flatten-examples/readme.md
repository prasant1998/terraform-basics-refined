#  Flattening a List of Maps with Subnets

We may have a list of maps, where each map contains a list of sub-elements, and we want to flatten that list.

The regions variable contains a list of objects, where each object represents a region and contains a list of subnet objects.

We use the for expression to extract the subnets from each region, resulting in a list of lists.

The flatten() function is then used to merge all the individual subnet lists into a single list of subnet objects.

---

# Conditionally Include Subnets Based on a Flag


The include_subnets variable is a map that indicates whether subnets should be included for each region.

The region_subnets variable is a map of region names to a list of subnet IDs.

We use a conditional expression inside the for loop: if the include flag for the region is true, the corresponding subnets are included; otherwise, an empty list ([]) is used.

The flatten() function is then used to merge all the resulting subnet lists into a single list, which only includes subnets for regions where include_subnets is true.