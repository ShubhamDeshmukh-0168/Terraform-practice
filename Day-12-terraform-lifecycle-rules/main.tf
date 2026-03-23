resource "aws_instance" "name" {
    ami           = "ami-02dfbd4ff395f2a1b"
    instance_type = "t2.micro"

    # lifecycle {
    #   create_before_destroy = true # This will create a new instance before destroying the old one when changes are made to the resource, ensuring minimal downtime.
    # }
    #lifecycle {
     #ignore_changes = [ tags ] # This will ignore changes to the tags attribute, preventing Terraform from making unnecessary updates to the instance when only tags are modified.
    #}
    lifecycle {
      prevent_destroy = true # This will prevent the instance from being destroyed, adding an extra layer of protection against accidental deletions. If you try to destroy the instance, Terraform will raise an error instead.
    }
    tags = {
        Name = "shubham-instance"
    }
}

#if we want to use multiple lifecycle rules, we can combine them in a single lifecycle block like this:
#lifecycle { 
#   create_before_destroy = true
#   ignore_changes = [ tags ]
#   prevent_destroy = true
 #}