# Guestbook docker container

## Getting Started

This README file is inside a folder that contains a `Vagrantfile` (hereafter this folder shall be called the [vagrant_root]), which tells Vagrant how to set up your virtual machine in VirtualBox.

To use the vagrant file, you will need to have done the following:

  1. Download and Install [Docker](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
  2. Open a shell prompt (Terminal app on a Mac) and cd into the folder containing the `Dockerfile`

### Building Our First Image

Using the explanations from before, we are ready to create our first guestbook image with docker!

```sudo docker build -t guestbook . ```

* Note: The -t [name] flag here is used to tag the image. To learn more about what else you can do during build, run sudo docker build --help.


### Running A Guestbook Instance

Using the image we have build, we can now proceed to the final step: creating a container running a Guestbook instance inside, using a name of our choice (if desired with -name [name]).

Finally, you can start the container itself with the following command:

```sudo docker run -p 80:80 -name guestbook -i -t guestbook```

After this is configured and run, you could visit http://<yourhostip>:80/ in a browser, and you'll see the Rails demo app.

* Note: If a name is not set, we will need to deal with complex, alphanumeric IDs which can be obtained by listing all the containers using ```sudo docker ps -l```

Enjoy!

## Author Information

Created in 2016 by [RaviBhure](http://www.ravibhure.com/).
