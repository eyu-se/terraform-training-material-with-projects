variable "bucket_name"       { 
    type = string 
    }
variable "enable_versioning" { 
    type = bool   
    default = true 
    }
variable "sse_algorithm"     { 
    type = string   
    default = "AES256" 
    }
variable "force_destroy"     { 
    type = bool   
    default = false 
    }
variable "tags"              { 
    type = map(string)   
    default = {} 
    }
