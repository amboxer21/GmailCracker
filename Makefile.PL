# Makefile.PL for My::Module
use ExtUtils::MakeMaker;
use Data::Dumper;
use Cwd;

use strict;
use warnings;

my $iter;

my @Arr = ( '/usr/local/lib/perl5/5.16.3/i686-linux/Cwd.pm',

		 '/usr/local/lib/perl5/5.16.3/i686-linux/Tk.pm',

		 '/usr/local/lib/perl5/5.16.3/i686-linux/WWW/Curl/Easy.pm',);

foreach $iter ( @Arr ) {

        if( -e $iter ) {

                print "\nChecking for $iter... yes.\n";

        }

                elsif( ! -e $iter ) {

                        print "\nChecking for $iter... NO\n\nInstalling now.\n";

			#print Dumper qx/perl -MCPAN -e 'install "$iter"'/;

			if( $iter =~ m/\/[a-zA-Z0-9].*\/+/i ) {

                                if( ! defined( $ARGV[0] ) && $' eq 'Tk.pm' ) {

                                       	qx/perl -MCPAN -e 'install "Tk"'/;

                                }

                                        elsif( ! defined( $ARGV[0] ) && $' eq 'Cwd.pm' ) {

                                                qx/perl -MCPAN -e 'install "Cwd"'/;

                                        }

                                        elsif( $ARGV[0] eq '' && $' eq 'Curl.pm' ) {

                                                qx/perl -MCPAN -e 'install "WWW::Curl"'/;

                                        }


				if( $ARGV[0] eq "force" && $' eq 'Tk.pm' ) {

                                       	qx/perl -MCPAN -e 'force install "Tk"'/;

                                }

                                        elsif( $ARGV[0] eq "force" && $' eq 'Cwd.pm' ) {

                                                qx/perl -MCPAN -e 'force install "Cwd"'/;

                                        }

                                        elsif( $ARGV[0] eq "force" && $' eq 'Curl.pm' ) {

                                                qx/perl -MCPAN -e 'force install "WWW::Curl"'/;

                                        }

                                if( $ARGV[0] eq "remote" && $' eq 'Tk.pm' ) {

                                       	`bash Build.sh\ tk`

                                }

                                        elsif( $ARGV[0] eq "remote" && $' eq 'Cwd.pm' ) {

                                                `bash Build.sh\ cwd`

                                        }

                                        elsif( $ARGV[0] eq "remote" && $' eq 'Curl.pm' ) {

                                                `bash Build.sh\ curl`

                                        }

			}

		}

 }

WriteMakefile (
   NAME => 'GmailCracker',
   AUTHOR => 'Anthony Guevara',
   
   PREREQ_PM => {
   'Cwd' => 3.40, 
   'Tk' => 804.031, 
   'WWW::Curl::Easy' => 4.17,
   });
