package WWW::Mixcloud::Cloudcast::Section;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

use WWW::Mixcloud::Track;

has track => (
    isa      => 'WWW::Mixcloud::Track',
    is       => 'ro',
    required => 1,
);

has position => (
    is       => 'ro',
    required => 1,
);

has start_time => (
    is       => 'ro',
    required => 1,
);

has section_type => (
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head2 new_list_from_data

=cut

sub new_list_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    my @sections;

    foreach my $section ( @{$data} ) {
        my $track = WWW::Mixcloud::Track->new_from_data( $section->{track} );

        push @sections, $class->new({
            track        => $track,
            position     => $section->{position},
            start_time   => $section->{start_time},
            section_type => $section->{section_type},
        })
    }

    return \@sections;
}
1;
