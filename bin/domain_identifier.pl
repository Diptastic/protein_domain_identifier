#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Getopt::Long qw(GetOptions);
use ProteinDomainIdentifier;
use JSON;
use File::Basename;

# Declare command-line options variables
my $input_file;
my $output_file;
my $output_format = 'text';  # default output format
my $verbose = 0;

# Parse command-line options
GetOptions(
    'input|i=s'        => \$input_file,
    'output|o=s'       => \$output_file,
    'format|f=s'       => \$output_format,
    'verbose|v'        => \$verbose,
) or die usage();

# Check required input file argument
die "Error: Input file is required\n" unless $input_file;
die "Error: Input file '$input_file' does not exist\n" unless -e $input_file;

# Set default output file if not provided
unless ($output_file) {
    my ($name, $path, $suffix) = fileparse($input_file, qr/\.[^.]*/);
    $output_file = "reports/${name}_domains.${output_format}";
}

# Create reports directory if it doesn't exist
mkdir 'reports' unless -d 'reports';

# Run domain identification
print "Processing file: $input_file\n" if $verbose;
my $results = ProteinDomainIdentifier::identify_domains($input_file);

# Output results in the requested format
if ($output_format eq 'json') {
    open my $fh, '>', $output_file or die "Cannot write to $output_file: $!";
    print $fh encode_json($results);
    close $fh;
    print "Results written to $output_file (JSON format)\n" if $verbose;
}
elsif ($output_format eq 'csv') {
    open my $fh, '>', $output_file or die "Cannot write to $output_file: $!";
    print $fh "Protein,Domain,Start,End\n";
    foreach my $r (@$results) {
        print $fh join(',', $r->{protein}, $r->{domain}, $r->{start}, $r->{end}) . "\n";
    }
    close $fh;
    print "Results written to $output_file (CSV format)\n" if $verbose;
}
else {  # plain text output
    open my $fh, '>', $output_file or die "Cannot write to $output_file: $!";
    foreach my $r (@$results) {
        print $fh "Protein: $r->{protein}\n";
        print $fh "  Domain: $r->{domain}\n";
        print $fh "  Location: $r->{start} - $r->{end}\n\n";
    }
    close $fh;
    print "Results written to $output_file (text format)\n" if $verbose;
}

exit 0;

# Usage message for help
sub usage {
    return <<"USAGE";
Usage: $0 --input <fasta_file> [--output <file>] [--format <text|csv|json>] [--verbose]

Options:
  --input|-i     Input FASTA file (required)
  --output|-o    Output file path (default: reports/<input>_domains.<format>)
  --format|-f    Output format: text (default), csv, or json
  --verbose|-v   Print detailed progress messages
USAGE
}
