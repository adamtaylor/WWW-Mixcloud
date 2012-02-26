package WWW::Mixcloud::Category;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

use WWW::Mixcloud::Picture;

has name => (
    is       => 'ro',
    required => 1,
);

has format => (
    is       => 'ro',
    required => 1,
);

has url => (
    is       => 'ro',
    required => 1,
);

has key => (
    is       => 'ro',
    required => 1,
);

has slug => (
    is       => 'ro',
    required => 1,
);

has pictures => (
    isa      => 'ArrayRef[WWW::Mixcloud::Picture]',
    is       => 'ro',
    required => 1,
    default  => sub { [] },
);

__PACKAGE__->meta->make_immutable;

=head2 new_from_data

=cut

sub new_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    my $pictures = WWW::Mixcloud::Picture->new_list_from_data( $data->{pictures} );
    return $class->new({
        name     => $data->{name},
        format   => $data->{format},
        url      => $data->{url},
        key      => $data->{key},
        slug     => $data->{slug},
        pictures => $pictures,
    });

}

1;
