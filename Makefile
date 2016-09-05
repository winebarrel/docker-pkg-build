hello: hello.c
	gcc hello.c -o hello

clean:
	rm -f hello

rpm:
	docker run --name docker-pkg-build-centos6 -v $(shell pwd):/tmp/src docker-pkg-build-centos6 make -C /tmp/src docker:rpm
	docker rm docker-pkg-build-centos6

deb:
	docker run --name docker-pkg-build-ubuntu-trusty -v $(shell pwd):/tmp/src docker-pkg-build-ubuntu-trusty make -C /tmp/src docker:deb
	docker rm docker-pkg-build-ubuntu-trusty

docker\:rpm:
	cd ../ && tar zcf hello.tar.gz src
	mv ../hello.tar.gz /root/rpmbuild/SOURCES/
	cp hello.spec /root/rpmbuild/SPECS/
	rpmbuild -ba /root/rpmbuild/SPECS/hello.spec
	mv /root/rpmbuild/RPMS/x86_64/hello-*.rpm pkg/
	mv /root/rpmbuild/SRPMS/hello-*.src.rpm pkg/

docker\:deb:
	dpkg-buildpackage -us -uc
	mv ../hello_* pkg/

docker\:build\:centos: Dockerfile.centos6
	docker build -f Dockerfile.centos6 -t docker-pkg-build-centos6 .

docker\:build\:ubuntu: Dockerfile.ubuntu-trusty
	docker build -f Dockerfile.ubuntu-trusty -t docker-pkg-build-ubuntu-trusty .
