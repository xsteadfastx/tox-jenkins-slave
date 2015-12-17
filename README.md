tox-jenkins-slave
=================

A docker slave container for using with the [jenkins docker plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin). It contains the wonderful [tox](https://tox.readthedocs.org/) and the python versions:

* 2.3
* 2.4
* 2.5
* 2.6
* 3.1
* 3.2
* 3.3
* 3.4
* 3.5

Thanks to the [fkrull](https://launchpad.net/~fkrull/+archive/ubuntu/deadsnakes).

It starts up an openssh-server with the user `jenkins` and the password `jenkins`.

How to use
----------

In `Configure System` -> `Cloud` -> `Docker` -> `Add Docker Template`:

1. **Docker Image**: `xsteadfastx/tox-jenkins-slave`
2. **Remote Filing System Root**: `/home/jenkins`
3. **Labels**: `tox-jenkins-slave`
4. **Launch method**: `Docker SSH computer launcher`
  * **Credentials**: Add a new one with username `jenkins` and password `jenkins`
5. **Remote FS Root Mapping**: `/home/jenkins`
6. **Remove volumes**: `True`

In the job you have to use the image specifically.

1. **Docker Container**: `True`
2. **Restrict where this project can be run**: `True`
  * **Label Expression**: `tox-jenkins-slave`

More information
----------------

- I didnt got it working for Matrix-Projects. You need to add a new project for each Python version you want to test. If you dont care of viewing different junit test results then you can just run tox without a specific python version and it will tell you anyway if something went wrong.
- if working with files: jenkins kills all environment variables with using SSH. So the locales are fucked up. I had alot of problems working with files. I add them back in the Python script itself. Here is a working example:

```
import os
import tox

os .environ['LANG'] = 'C.UTF-8'
os.chdir(os.environ['WORKSPACE'])

tox.cmdline(['-e py34'])
```
