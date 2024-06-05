#Simple Ec2 creation with defaults setting and existing key pair
provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "sample" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    tags ={
        Name="example"
    }   
    #key_name = "mohith123"   #uncomment to add existing key pair name
}
################################################################
#with creating new key pair

#Generate a new private key
resource "tls_private_key" "key123" {
    algorithm = "RSA"
    rsa_bits = "4096"
}

# Save the generated public key to a local file
resource "local_file" "key123_public_key" {
    content  = tls_private_key.key123.public_key_openssh
    filename = "Key123.pub"
}

# Upload the public key to AWS
resource "aws_key_pair" "Key123" {
    key_name   = "key123"
    public_key = local_file.key123_public_key.content
}

# Save the private key to a local file
resource "local_file" "key123_private_key" {
    content  = tls_private_key.key123.private_key_pem
    filename = "Key123.pem"
}
