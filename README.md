== How To Build

image:https://travis-ci.org/onealtom/dt_build.svg?branch=master["Build Status", link="https://travis-ci.org/onealtom/dt_build"]

[source,]
----
$ ./dtc --veriosn
Version: DTC 1.4.1-gb06e55c8
$ make clean
$ make
$ make install DTB_DEST=/dest/path/file/name.dtb
----

== Get devicetree version

[source,]
----
$ cat /proc/device-tree/dt_ver/build_time
$ cat /proc/device-tree/dt_ver/commit
$ cat /proc/device-tree/dt_ver/builder
----




