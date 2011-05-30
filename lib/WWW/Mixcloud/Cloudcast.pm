package WWW::Mixcloud::Cloudcast;

use Moose;

has listener_count => (
    isa      => 'Num',
    is       => 'ro',
    required => 1,
);

has name => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

has tags => (

);

has url => (

);

has pictures => (

);

has update_time => (

);

has play_count => (

);

has comment_count => (

);

has percentage_music => (

);

has user => (

);

has key => (

);

has created_time => (

);

has audio_length => (

);

has sections => (

);

1;
