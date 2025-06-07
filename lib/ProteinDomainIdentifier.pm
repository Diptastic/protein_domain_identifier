package ProteinDomainIdentifier;
use strict;
use warnings;
use Bio::SeqIO;

# Define regex patterns for protein domains
my %domains = (
    'Zinc Finger'      => qr/C.{2,4}C.{12}H.{3,5}H/,
    'Kinase Domain'    => qr/DLKPEN/,
    'Helix-turn-Helix' => qr/.{2}A.{2}A.{2}A.{2}A/
);

# identify_domains: parses FASTA file and finds domain matches
# Input: path to FASTA file
# Output: arrayref of hashrefs with protein, domain, start, end
sub identify_domains {
    my ($fasta_path) = @_;
    my $in = Bio::SeqIO->new(-file => $fasta_path, -format => 'fasta')
        or die "Cannot open FASTA file '$fasta_path': $!";

    my @results;
    while (my $seq_obj = $in->next_seq) {
        my $seq = $seq_obj->seq;
        my $id  = $seq_obj->display_id;

        # Search each domain pattern in the sequence
        foreach my $domain (keys %domains) {
            while ($seq =~ /$domains{$domain}/g) {
                push @results, {
                    protein => $id,
                    domain  => $domain,
                    start   => $-[0] + 1,
                    end     => $+[0],
                };
            }
        }
    }
    return \@results;
}

1;  # Perl modules must return true value
