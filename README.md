# reciprocal-borrowing-vagrant

This repository contains a Vagrant configuration for setting up a Shibboleth Identity Provider (IdP) and Service Provider (SP) for use in developing the "reciprocal-borrowing" Rails application.

For more information about the configuration, see [docs/ConfigurationNotes.md](docs/ConfigurationNotes.md).

----
**Warning:**

This document is not intended to show best practices
for setting up a production Shibboleth instance.

----

## Prerequisites

### Prerequisite 1: Java JDK

The IdP Vagrant configuration requires the Java JDK. Download the jdk-7u79-linux-x64.rpm file from Oracle (http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html) and placed in the vagrant_shared/oracle_jdk/required/ directory.

### Prerequisite 2: Rails Application

The "reciprocal-borrowing" Rails application must be cloned into the directory containing this repository, using the following command:

```
> git clone https://github.com/umd-lib/reciprocal-borrowing.git
```

This directory will be synced with the /apps/borrow/reciprocal-borrowing/ directory in the VM. It should be set to whatever branch you are interested in working with.

## VM Configuration

### Shibboleth IdP Configuration

 * CentOS 5.10
 * IP Address: 192.168.33.10
 * Apache v2.2.3
 * Tomcat v6.0.39
 * Java JDK v1.7.0_79
 * Shibboleth Identity Provider v2.3.8
 
### Shibboleth SP Configuration

 * CentOS 7.2
 * IP Address: 192.168.33.20
 * Apache v2.4.6
 * Tomcat v7.0.42
 * Shibboleth v2.6.0

**Note:** There is no particular rationale for using CentOS 5.10/Apache 2.2.3 for the IdP and CentOS 7.2/Apache 2.4.6 for the SP. Basically, we'd already figured out how to do an IdP on CentOS 5.1, and there seemed no reason to go through the hassle of figuring out how to make it work on CentOS 7.2. For the SP, we wanted a later CentOS version, as that would more closely mirror the production system on which the "reciprocal-borrowing" application would be based.
 
### Service Account 

On the SP machine, the "vagrant" user is used as the service account. This is necessary because the Rails application directory is synced with the host machine, and there does not appear to be a way to easily change the ownership of synced directories.

On the IdP machine, a "shib" service user is used.

To access the "shib" service account:

```
> su - shib
Password: [Password]
```
The default password is "shib".

The default username and password for the IdP service user can be changed in [vagrant_env_config.sh](vagrant_env_config.sh) of the IdP Vagrant machine.


## SP Client Setup

The SP Vagrant machine uses the following application:

* Apache HTTP server
* Git
* Shibboleth client
* Ruby
* RVM
* Passenger Phusion

The Apache HTTP server, Git, Shibboleth, and Passenger Phusion were installed via the "yum" package manager. See https://wiki.shibboleth.net/confluence/display/SHIB2/NativeSPLinuxRPMInstall for information about installing Shibboleth via yum.

Ruby is installed system-wide via yum. The RVM (Ruby Version Manager - https://rvm.io/) is installed on the "vagrant" account, as a "single-user" install (see [https://rvm.io/rvm/install](https://rvm.io/rvm/install)). RVM is then used to install the Ruby version used by the Rails application.

### Shibboleth Certificates

Pre-configured self-signed certificates for the Shibboleth SP client are provided in the vm-setup/shibboleth_config/ directory (sp-cert.pem, sp-key.pem). The public key from sp-cert.pem is used in the /apps/shibboleth-idp/metadata/some-metadata.xml file for the IdP.

### Build the SP Vagrant machine

1) Build the SP virtual machine by running the "vagrant up" command:

```
repo> cd vm-sp
repo> vagrant up
```

### Starting and Stopping Rails

The Rails application is started automatically. To stop and start the Rails application:

1) Login to the Vagrant SP machine:

```
(In the vm-sp subdirectory)
repo> vagrant ssh
```

2) To stop the Rails application:

```
sp> cd /apps/borrow
sp> ./control stop
```

The start the Rails application:

```
sp> cd /apps/borrow
sp> ./control start
```

## IdP Setup

The IdP Vagrant machine uses the following application:

* Java SDK
* Expect
* Apache Httpd
* OpenSSL
* Apache Tomcat
* Shibboleth Identity Provider

The Java SDK is installed using the JDK RPM file downloaded as part of Prerequisite #1.

Expect, Apache Httpd, and OpenSSL are installed via the "yum" package manager.

Apache Tomcat and the Shibboleth Identity Provider are downloaded from the Internet and installed using Vagrant provisioning scripts.

The [vagrant_env_config.sh](vagrant_env_config.sh) file contains parameters that can be modified to adjust particular build configuration elements.


### Build the IdP Vagrant machine

1) Build the IdP virtual machine by running the "vagrant up" command:

```
repo> cd vm-idp
repo> vagrant up
```

### Starting and Stopping the Shibboleth IdP

The Shibboleth IdP application will not typically need to be stopped and started. To do so, do the following:

1) Login to the Vagrant IdP machine:

```
(In the vm-idp subdirectory)
repo> vagrant ssh
```

2) Switch to the "shib" service account:

```
idp> su - shib
```

3) Run the following commands to stop Tomcat and Apache:

```
idp> cd /apps/tomcat
idp> ./control stop
idp> sudo /etc/init.d/httpd stop
```

Run the following commands to start Tomcat and Apache:

```
idp> cd /apps/tomcat
idp> ./control start
idp> sudo /etc/init.d/httpd start
```

## Usage

Once both the SP and IdP Vagrant machines are up, the Rails application can be accessed via a web browser at [https://192.168.33.20/](https://192.168.33.20/).

**Note:** Because both the SP and IdP use self-signed SSL certificates, the browser will display warnings. These are expected, and should not occur in a production environment using real SSL certificates.

To demonstrate a Shibboleth interaction, do the following:

1) In a web browser, go to [https://192.168.33.20/](https://192.168.33.20/). A home page with a list of institutions will be displayed.

2) Select the "University of Maryland" link from the list.

3) The browser will display a password dialog. Type in the following:

| Field    | Value  |
| -------- | ------ |
| Username | myself |
| Password | shib   |

4) The browser will display a result page.


## Troubleshooting Shibboleth

The Vagrant IdP and SP machines should hopefully "just work", but here are some things to try if things don't seem to be working:

### IdP Troubleshooting

#### IdP Sanity Check

1) Using a web browser (or curl), go to the following URL:

```
https://192.168.33.10/idp/profile/Metadata/SAML
```

An XML file containing the IdP metadata should be returned.


#### IdP Log Files

The Shibboleth IdP log files are located in the "/apps/shibboleth-idp/logs/" directory. the "idp-process.log" might be particularly helpful.


### SP Troubleshooting

#### SP Sanity Check

1) Using a web browser (or curl), go to the following URL:

```
https://192.168.33.20/Shibboleth.sso/Metadata
```

An XML file containing the SP metadata should be returned.

#### SP Log Files

The Shibboleth SP log files are located in the "/var/log/shibboleth/" directory. "su"/"sudo" is needed to access the files in the directory.

----

## License

These files are provided under the CC0 1.0 Universal license (http://creativecommons.org/publicdomain/zero/1.0/).
