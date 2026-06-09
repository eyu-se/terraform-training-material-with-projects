variable "table_name"      { type = string }

variable "hash_key"        { 
    type = string 
    default = "pk" 
    }
variable "range_key"       { 
    type = string 
    default = null 
    }
variable "billing_mode"    { 
    type = string 
    default = "PAY_PER_REQUEST" 
    }
variable "attribute_type"  { 
    type = string 
    default = "S" 
    }
variable "tags"            { 
    type = map(string) 
    default = {} 
    }
