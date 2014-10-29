#!/bin/bash

function cwd_build() {

#wdir=($PWD);

echo -e "\n\nDownloading...\n\n"

wget "https://cpan.metacpan.org/authors/id/S/SM/SMUELLER/PathTools-3.47.tar.gz" &&

echo -e "\n\nExtracting...\n\n"

tar xzvf PathTools-3.47.tar.gz &&

echo -e "\n\nChanging directories...\n\n"

        cd "PathTools-3.47";

	echo -e "\n\nBuilding...\n\n"

        perl Makefile.PL &&

        make &&

	echo -e "\n\nInstalling...\n\n"

        make install &&

        echo -e "\n\nFinished\n\n";

	echo -e "\n\nCleaning up...\n\n";

	rm -rf PathTools* &&

        return

}

function tk_build() {

echo -e "\n\nDownloading...\n\n"

wget "https://cpan.metacpan.org/authors/id/S/SR/SREZIC/Tk-804.032.tar.gz"  &&

echo -e "\n\nExtracting...\n\n";

tar xzvf Tk-804.032.tar.gz &&

echo -e "\n\nChanging directories...\n\n";

        cd "Tk-804.032";

	echo -e "\n\nBuilding...\n\n";

        perl Makefile.PL &&

        make &&

	echo -e "\n\nInstalling...\n\n";

        make install &&

        echo -e "\n\nFinished\n\n";

	echo -e "\n\nCleaning up...\n\n";

	rm -rf PathTools* &&

        return

}

function curl_build() {

echo -e "\n\nDownloading...\n\n"

wget "https://cpan.metacpan.org/authors/id/S/SZ/SZBALINT/WWW-Curl-4.17.tar.gz"  &&

echo -e "\n\nExtracting...\n\n";

tar xzvf WWW-Curl-4.17.tar.gz &&

echo -e "\n\nChanging directories...\n\n";

        cd "WWW-Curl-4.17";

	echo -e "\n\nBuilding...\n\n";

        perl Makefile.PL &&

        make &&

	echo -e "\n\nInstalling...\n\n";

        make install &&

        echo -e "\n\nFinished\n\n";

	echo -e "\n\nCleaning up...\n\n";

	rm -rf PathTools* &&

        return

}

case $1 in

"cwd")

	echo -e "\n\nBuild CWD.\n\n";

        cwd_build;

	;;

"tk")

	echo -e "\n\nBuilding Tk.\n\n";

	tk_build;

	;;

"curl")

	echo -e "\n\nBuilding Curl.\n\n";

	tk_build;

	;;

--force|force|f|-f)

	perl Makefile.PL force;

	;;

--remote|remote|r|-r)

	perl Makefile.PL remote;

	;;

--help|help|-h|h)

	echo -e "\n\nUSAGE: $0 . .\n\n";

	;;

'')

	perl Makefile.PL &&

	make &&

	make install;

	;;

esac
