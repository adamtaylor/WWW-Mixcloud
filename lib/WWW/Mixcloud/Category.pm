# ABSTRACT: Represents categories in the Mixcloud API
package WWW::Mixcloud::Category;

use Moose;
use namespace::autoclean;

use Carp qw/ croak /;

# VERSION

use WWW::Mixcloud::Picture;

=head1 ATTRIBUTES

=head2 name

=cut

has name => (
    is       => 'ro',
    required => 1,
);

=head2 format

=cut

has format => (
    is       => 'ro',
    required => 1,
);

=head2 url

=cut

has url => (
    is       => 'ro',
    required => 1,
);

=head2 key

=cut

has key => (
    is       => 'ro',
    required => 1,
);

=head2 slug

=cut

has slug => (
    is       => 'ro',
    required => 1,
);

=head2 pictures

ArrayRef of L<WWW::Mixcloud::Picture> objects.

=cut

has pictures => (
    isa      => 'ArrayRef[WWW::Mixcloud::Picture]',
    is       => 'ro',
    required => 1,
    default  => sub { [] },
);

__PACKAGE__->meta->make_immutable;

=head2 new_from_data

    my $category = WWW::Mixcloud::Category->new_from_data( $data )

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
