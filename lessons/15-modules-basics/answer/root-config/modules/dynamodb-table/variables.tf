variable "table_name" { type = string }
variable "hash_key" { 
    type = string
    default = "pk" 
    }
variable "billing_mode" { 
    type = string 
    default = "PAY_PER_REQUEST" 
    }
variable "tags" { 
    type = map(string) 
    default = {} 
    }
