#!/usr/bin/env perl
use IPC::System::Simple qw(system systemx capture capturex);
use JSON::XS;
use DateTime::Format::ISO8601;
use File::Path qw(make_path);
my $json    = JSON::XS->new;
my @remotes = qw/remote gdrive/;

sub get_modified {
    my $file     = shift;
    my $output   = capture( "rclone", "lsjson", $file );
    my $decoded  = $json->decode($output);
    my $modified = $decoded->[0]->{ModTime};
    my $dt       = DateTime::Format::ISO8601->parse_datetime($modified);
    return $dt;
}

sub copy_file {
    my ( $src, $dest ) = @_;
    return capturex( "rclone", "-v", "copy", $src, $dest );
}

my $local_dir  = $ENV{HOME} . "/dropbox/keepass";
my $backup_dir = "$local_dir/bak";
my $local_path = "$local_dir/keepass2.kdbx";
my $local_mod  = get_modified($local_path);

for my $remote (@remotes) {
    my $remote_dir  = sprintf( "%s:keepass",       $remote );
    my $remote_path = sprintf( "%s/keepass2.kdbx", $remote_dir );
    my $remote_mod  = get_modified($remote_path);
    my $diff        = $remote_mod->epoch - $local_mod->epoch;

    next unless (abs($diff) > 5);
    if ( $diff >= 0 ) {
        my $datestamp = capturex( "date", "+%F-%H%M%S" );
        chomp($datestamp);
        my $conflict_path =
          $backup_dir . "/" . join( '-', $remote, $datestamp );
        make_path($conflict_path);
        warn
"[$remote] WARNING: Remote file is newer than local file by $diff seconds, copying from remote to $conflict_path";
warn "See if there were any local modifications after $remote_mod";
        my $out = copy_file( $remote_dir, $conflict_path );
        print $out . "\n";
        next;
    }
    warn sprintf( "[$remote] Local file is newer by %d seconds", abs($diff) );
    my $out = copy_file( $local_path, $remote_dir );
    print $out . "\n";
}

exit 0;
