output "simple_bucket_arn" { value = module.simple_bucket.bucket_arn }
output "configured_bucket_id" { value = module.configured_bucket.bucket_id }
output "events_queue_url" { value = module.events.queue_url }
output "users_table_arn" { value = module.users.table_arn }
