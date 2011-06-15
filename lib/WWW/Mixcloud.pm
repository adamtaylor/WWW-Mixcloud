package WWW::Mixcloud;

use Moose;
use namespace::autoclean;

use URI;
use LWP::UserAgent;
use JSON;
use DateTime::Format::Atom;

use WWW::Mixcloud::Cloudcast;
use WWW::Mixcloud::Cloudcast::Tag;
use WWW::Mixcloud::Artist;
use WWW::Mixcloud::Category;
use WWW::Mixcloud::Track;
use WWW::Mixcloud::User;

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

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Cloudcast->new_from_data( $data );
}

=head2 get_user

=cut

sub get_user {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::User->new_from_data( $data );
}

=head2 get_tag

=cut

sub get_tag {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Cloudcast::Tag->new_from_data( $data );
}

=head2 get_artist

=cut

sub get_artist {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Artist->new_from_data( $data );
}

=head2 get_track

=cut

sub get_track {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Track->new_from_data( $data );
}

=head2 get_category

=cut

sub get_category {
    my ( $self, $url ) = @_;

    my $data = $self->_api_call( $url );

    return WWW::Mixcloud::Category->new_from_data( $data );
}

sub _api_call {
    my ( $self, $url ) = @_;

    my $uri = URI->new( $url );

    my $res = $self->ua->get( $API_BASE . $uri->path );

    if ( $res->is_success ) { 
        #warn pp $res->content;
    }

    return decode_json $res->content;

}

1;
