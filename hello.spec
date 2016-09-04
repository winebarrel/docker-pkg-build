%define  debug_package %{nil}

Name:   	hello
Version:  0.1.0
Release:  1%{?dist}
Summary:  hello

Group:    Development/Tools
License:  MIT
URL:      https://github.com/winebarrel/hello
Source0:  %{name}.tar.gz

%description
hello

%prep
%setup -q -n src

%build
make

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/bin
install -m 755 %{name} %{buildroot}/usr/bin/

%files
%defattr(755,root,root,-)
/usr/bin/%{name}
