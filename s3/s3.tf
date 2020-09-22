provider "aws" {
  region = "us-west-1"
  access_key = "AKIA3Q56NSKEL7I6OEMH"
  secret_key = "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"
}

variable "upload_directory" {
  default = "website_files/"
}

variable "mime_types" {
  default = {
    htm   = "text/html"
    html  = "text/html"
    css   = "text/css"
    ttf   = "font/ttf"
    js    = "application/javascript"
    map   = "application/javascript"
    json  = "application/json"
  }
}

resource "aws_s3_bucket" "websitefiles" {
  bucket  = "websitefilesbucket"
  acl     = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "websitefilesobject" {
  for_each      = fileset(var.upload_directory, "**/*.*")
  bucket        = aws_s3_bucket.websitefiles.bucket
  key           = replace(each.value, var.upload_directory, "")
  source        = "${var.upload_directory}${each.value}"
  acl           = "public-read"
  etag          = filemd5("${var.upload_directory}${each.value}")
}