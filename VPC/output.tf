output "sg" {
  value = aws_security_group.sg.id
}
output "pu_sb" {
  value = aws_subnet.pu_sb.id
}
output "pr_sb" {
  value = aws_subnet.pr_sb.id
}