package WWW::Mixcloud;

use Moose;

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

sub cloudcast {

}

1;
