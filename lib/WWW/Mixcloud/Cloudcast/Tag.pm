# ABSTRACT: Represents cloudcast tags in the Mixcloud API
package WWW::Mixcloud::Cloudcast::Tag;

use Moose;
use namespace::autoclean;

use Carp qw/ croak/;

# VERSION

=head1 ATTRIBUTES

=head2 url

=cut

has url => (
    is       => 'ro',
    required => 1,
);

=head2 name

=cut

has name => (
    is       => 'ro',
    required => 1,
);

=head2 key

=cut

has key => (
    is       => 'ro',
    required => 1,
);

__PACKAGE__->meta->make_immutable;

=head1 METHODS

=head2 new_list_from_data

    my @tags = WWW::Mixcloud::Cloudcast::Tag->new_from_data( $data )

=cut

sub new_list_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    my @tags;
    foreach my $tag ( @{$data} ) {
        push @tags, $class->new_from_data( $tag );
    }

    return \@tags;
}

=head2 new_from_data

    my $tag = WWW::Mixcloud::Cloudcast::Tag->new_from_data( $data )

=cut

sub new_from_data {
    my $class = shift;
    my $data  = shift || croak 'Data reference required for construction';

    return $class->new({
        url  => $data->{url},
        name => $data->{name},
        key  => $data->{key},
    });
}

1;
