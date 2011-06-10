package WWW::Mixcloud;

use Moose;
use URI;
use LWP::UserAgent;
use JSON;
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

my $API_BASE = 'http://api.mixcloud.com';

sub _build_ua {
    my $self = shift;

    return LWP::UserAgent->new;
}

=head2 cloudcast

    my $cloudcast = $mixcloud->cloudcast( $url );

=cut

sub cloudcast {
    my ( $self, $url ) = @_;

    my $uri = URI->new( $url );

    my $data = decode_json $self->_api_call( $uri->path );

    warn pp $data;

    my $cloudcast = WWW::Mixcloud::Cloudcast->new({
        listener_count   => $data->listener_count,
        name             => $data->name,
        tags             =>
        url              => $data->url,
        pictures         => 
        update_time      => DateTime->new( $data->update_time ),
        play_count       => $data->play_count,
        comment_count    => $data->comment_count,
        percantage_music => $data->percentage_music,
        user             => $data->user,
        key              => $data->key,
        created_time     => DateTime->new( $data->created_time ),
        audio_length     => $data->audio_length,
        sections         =>
        slug             => $data->slug,
        description      => $data->description,
    });

    return $cloudcast;
}

sub _api_call {
    my ( $self, $path ) = @_;

    my $res = $self->ua->get( $API_BASE . $path );

    if ( $res->is_success ) { 
        #warn pp $res->content;
    }

    return $res->content;

}

1;
