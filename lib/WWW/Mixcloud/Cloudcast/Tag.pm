package WWW::Mixcloud::Cloudcast::Tag;

use Moose;

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

1;