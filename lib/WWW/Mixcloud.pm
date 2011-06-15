package WWW::Mixcloud;

use Moose;
use namespace::autoclean;

use URI;
use LWP::UserAgent;
use JSON;
use DateTime::Format::Atom;

use WWW::Mixcloud::Cloudcast;
use WWW::Mixcloud::User;
use WWW::Mixcloud::Picture;

use Data::Dump qw/ pp /;

has api_key => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has api_secret => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has ua => (
    is  => 'ro',
    isa => 'LWP::UserAgent',
    lazy_build => 1,
);

__PACKAGE__->meta->make_immutable;

my $API_BASE = 'http://api.mixcloud.com';

sub _build_ua {
    my $self = shift;

    return LWP::UserAgent->new;
}

=head2 get_cloudcast

    my $cloudcast = $mixcloud->get_cloudcast( $url );

=cut

sub get_cloudcast {
    my ( $self, $url ) = @_;

    my $uri = URI->new( $url );

    my $data = $self->_api_call( $uri->path );

    my $cloudcast = WWW::Mixcloud::Cloudcast->new_from_data( $data );
    warn pp $cloudcast;

    return $cloudcast;
}

=head2 get_user

=cut

sub get_user {
    my ( $self, $url ) = @_;

    my $uri = URI->new( $url );

    my $data = $self->_api_call( $uri->path );

    my $user = WWW::Mixcloud::User->new_from_data( $data );

    return $user;
}

=head2 get_tag

=cut

sub get_tag {

}

=head2 get_artist

=cut

sub get_artist {

}

=haed2 get_track

=cut

sub get_track {

}

=head2 get_category

=cut

sub get_category {

}

sub _api_call {
    my ( $self, $path ) = @_;

    my $res = $self->ua->get( $API_BASE . $path );

    if ( $res->is_success ) { 
        #warn pp $res->content;
    }

    return decode_json $res->content;

}

1;
