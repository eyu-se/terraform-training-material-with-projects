output "data_bucket_arn" {
  value = module.data.bucket_arn
}

output "logs_bucket_id" {
  value = module.logs.bucket_id
}

output "events_queue_url" {
  value = module.events.queue_url
}

output "users_table_arn" {
  value = module.users.table_arn
}
