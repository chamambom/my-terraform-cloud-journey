#dynamic_block_for_each loop 

From main.tf I moved security_rule to the sec_rules named variable in variable.tf file. The type of sec_rules is list(object({})). Inside main.tf to use multiple rules I am using dynamic block with name security_rule (as same as resource attribute), Under it I have mentioned for_each loop taking sec_rules map/set information stored and mentioned in the variable default value. This values are fetched in the loop fashion with key pair value map (dictionary).

