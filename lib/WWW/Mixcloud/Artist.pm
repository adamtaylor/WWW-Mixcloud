package WWW::Mixcloud::Artist;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

has url => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has name => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has key => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has slug => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head2 new_from_data

=cut

sub new_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    return $class->new({
        url  => $data->{url},
        name => $data->{name},
        key  => $data->{key},
        slug => $data->{slug},
    });
}

1;
