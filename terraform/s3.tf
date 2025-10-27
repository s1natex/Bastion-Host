resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "openvpn_bucket" {
  bucket = "${var.project_name}-openvpn-backup-${random_id.bucket_suffix.hex}"

  force_destroy = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-openvpn-backup"
    }
  )
}
