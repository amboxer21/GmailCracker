use strict;

use Tk;
require Tk::FileSelect;

my $mw = MainWindow->new;
$mw->title( 'Gmail Cracker' );
$mw->geometry( '400x400' );
my $EntryLabel = $mw->Label( -text => 'User Name ' )->pack( -side => 'left', -anchor => 'w', );      
my $ListButton = $mw->Button( -text => "Get List", 
		              -command => \&choose_dir )->pack( -side => 'right', -anchor => 'e', -padx => '5', -pady => '5'  );
		             
my $UserNameEntry = $mw->Entry( -background => 'WHITE', -width => '28', )->pack( -side => 'left', -anchor => 'e', );		             

sub choose_dir {
my $FileSelector = $mw->FileSelect( -directory => '/' );
my $File = $FileSelector->Show;
print $File;
};

MainLoop;
