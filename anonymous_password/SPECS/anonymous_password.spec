Name:           anonymous_password
Version:        0.0
Release:        1%{?dist}
Summary:        Script to find password of anonymous ldap user

Group:          System Environment/Daemons
License:        WTFPL
URL:            http://github.com/stahnma
Source0:        anonymous_password.rb
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildRequires:  ruby-rdoc
Requires:       ruby-ldap, ruby >= 1.8
BuildArch:      noarch

%description
This is a small program designed to discover the current
anonymous dn password to bind to the LDAP directory.
Obviously to search the directory you must bind as
an account other than the ANONYMOUS_DN

%package docs
Summary:        The anonymous ldap user script rdocs
Group:          Documentation
%description docs
The rdoc documentation (in html format) for the anonymous
ldap user script. 

%prep
cp -f %{SOURCE0} .

%build
rdoc anonymous_password.rb

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_sbindir}
install -p -m755 anonymous_password.rb $RPM_BUILD_ROOT/%{_sbindir}/anonymous_password

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%{_sbindir}/anonymous_password

%files docs
%defattr(-,root,root,-)
%doc doc

%changelog
* Mon Feb 01 2010 <stahnma@websages.com>  - 0.0-1
- Initial Package SPEC
