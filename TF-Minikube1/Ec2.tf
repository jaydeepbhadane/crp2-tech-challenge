
resource "aws_instance" "Demo" {

     ami = "ami-03d3eec31be6ef6f9"
     instance_type = "t2.medium"
     availability_zone = "ap-south-1a"
     vpc_security_group_ids = [aws_security_group.allow_tls.id]
     key_name = "MyKubekey"
     tags={
          Name="Ubuntu-instance"
          }
provisioner "remote-exec" {
      inline = [

             "sudo apt update -y",
             "sudo apt upgrade -y",
             "sudo apt install docker.io -y",
             "sudo apt install -y curl wget apt-transport-https",
             "wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
             "sudo cp minikube-linux-amd64 /usr/local/bin/minikube",
             "sudo chmod +x /usr/local/bin/minikube",
             "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
             "chmod +x kubectl",
             "sudo mv kubectl /usr/local/bin/",
             "sudo usermod -aG docker ubuntu",
             "minikube start",
             "curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.2.4 sh -",
             "kubectl create namespace istio-system"

               ]
      connection {

           type ="ssh"
           host = self.public_ip
           user = "ubuntu"
           private_key = file ("./MyKubekey.pem")
          }

     }

}