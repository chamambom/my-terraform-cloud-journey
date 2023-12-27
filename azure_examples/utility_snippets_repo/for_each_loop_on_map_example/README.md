#for_each_loop_on_map_example

This article is a second part of a post Hashicorp Terraform dynamic block for_each loop with example, In earlier script I used dynamic block with using for_each loop. In This script I will use same for_each loop without any block inside resource, instead I am using each.value to get the looped information. This is how the below script looks like and it is smaller and easier one than the dynamic block. I have for your reference have two files main.tf and variable.tf. Here I am testing creating multiple Resource Groups within single variable using for_each loop for demo, values from map dictionary are fetched with values with key pair.

