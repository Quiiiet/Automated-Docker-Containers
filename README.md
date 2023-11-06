
# Automated Docker Containers

# Overview:
The Docker Container Setup project aims to provide an automated script for setting up Docker containers based on user preferences. The script allows users to choose an operating system (Ubuntu, openSUSE, CentOS, or a custom image) and optionally install software within the container. The script handles the installation and configuration of Docker, pulls the specified Docker image, and customizes the container based on the user's choices.

# User Stories:
- As a developer, I want to easily set up Docker containers with different operating systems to test my applications in various environments.

- As a system administrator, I want a streamlined process for deploying Docker containers with specific software configurations to ensure consistent setups across multiple instances.

- As a researcher, I want the flexibility to use custom Docker images in my experiments and easily install additional software within the containers.

- As a DevOps engineer, I want to automate the setup of Docker containers, including the installation of necessary software, to improve efficiency and reduce manual configuration steps.

- As a beginner in Docker, I want a user-friendly script that guides me through the process of creating and customizing Docker containers without requiring extensive knowledge of Docker commands.

# Usage
- chmod 777 DockerHelper.sh
- ./DockerHelper.sh
  
Note: The chmod command can be used in various ways. Choose the method that best suits your needs. Ensure that the user and group who will execute the script have execution permissions. This might include Linux users and Docker, Also, ensure that installDocker.sh is located in the same directory as the main script, DockerHelper.sh.

# Demo:
The script will automatically download and install Docker.
![](https://files.filterhost.net/index.php/s/TqgZRg6HZKtxxon/preview)

The script will ask the user which operating system is desired.

![](https://files.filterhost.net/index.php/s/rp82Rtx3NGbXStN/preview)

Or, the user can select a custom image from Docker Hub.

![3](https://files.filterhost.net/index.php/s/zLKjWTdao974fFS/preview)

If the user chooses Ubuntu as the operating system, the script will list the available versions.

![4](https://files.filterhost.net/index.php/s/tcSG9DSqp3FeL5y/preview)

If the user chooses openSUSE as the operating system, the script will list the available versions.

![5](https://files.filterhost.net/index.php/s/xEmb2a5LekNokLo/preview)

If the user chooses CentOS as the operating system, the script will list the available versions.

![6](https://files.filterhost.net/index.php/s/xdDzMeineRX9Nqx/preview)

Then, the script will ask the user if they want to install a specific software or tool from the list, depending on the selected operating system, such as Ubuntu or openSUSE.

![7](https://files.filterhost.net/index.php/s/c247qd9YCgnDE3D/preview)

Similarly, if CentOS is selected.

![8](https://files.filterhost.net/index.php/s/J4ZSYiseTxgYSJz/preview)

Following this, the container will begin to be configured and set up.

![9](https://files.filterhost.net/index.php/s/77BcQdNQ79jwdEj/preview)

Once completed, the container will be ready for use. The user should enter the provided command to log into the container.

![10](https://files.filterhost.net/index.php/s/Ec53d7dHcfkYntH/preview)
