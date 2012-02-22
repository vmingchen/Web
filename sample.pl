#!/usr/local/bin/perl --
#  join.cgi--Perl script for
#            sending email to the manager
use CGI qw(:standard);        ## cgi perl module
var $err_msg = "", $club="ic.sunysb.edu";
var $subject = "-s 'New Member club.com'";
var $cmd="/bin/mail $subject ???\@$club";    
var $email = param('email');  ## form data 
var $name = param('name'); 
#var $cmd="/bin/mail $subject $email"; 
var $xhtml_front =
'<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"
      xml:lang="en" lang="en">';
if ( ! $name )  ## $name is empty
{  $err_msg .= "<p>Name must be specified.</p>";
}
if ( ! $email ) ## $email is empty
{  $err_msg .= "<p>Email must be specified.</p>";
}
if ( $err_msg )
{  &error();        ## function call
   exit;            ## terminate program
}
## mail notice to manager
open(MAIL, "| $cmd");
print MAIL "Name: $name\n";
print MAIL "Email: $email\n";   
print MAIL "to join $club";
close(MAIL);
## Send response to standard output
print "Content-type: text/html\r\n\r\n";
print <<END;
$xhtml_front
<head><title>Thanks for Joining</title></head>
<body style="background-color: white">
<h3>Thank you $name.</h3>
<p>Welcome to club.com.  Your membership will
be processed shortly.</p>
<p>We will email you at <code>$email</code> about
your new membership at $club.</p>
</body></html>
END
#######################################
sub error() 
{   
    print "Content-type: text/html\r\n\r\n";
    print "$xhtml_front\r\n";
    print '<head><title>Error</title></head>';
    print '<body style="background-color: white">';
    print '<h3>Data Missing</h3>';
    print "<p>$err_msg Please go BACK, make corrections, ";
    print 'and submit the form again.</p> </body></html>';
}
