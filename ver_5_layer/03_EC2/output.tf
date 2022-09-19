output "ec2_instance" {
    # value = aws_instance.this[*].id
    value = aws_instance.this
}
