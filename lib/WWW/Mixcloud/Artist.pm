package WWW::Mixcloud::Artist;

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

has slug => (
    isa      => 'Str',
    is       => 'ro',
    required => 1,
);

1;
