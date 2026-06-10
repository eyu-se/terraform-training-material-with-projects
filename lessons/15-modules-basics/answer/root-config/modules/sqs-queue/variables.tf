variable "queue_name" { type = string }
variable "delay_seconds" { 
    type = number
    default = 0 
}
variable "tags" { 
    type = map(string) 
    default = {} 
    }
