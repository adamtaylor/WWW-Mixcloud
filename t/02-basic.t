use Test::More;

use WWW::Mixcloud;

SKIP: {
    skip 'Set environment variable MIXCLOUD_KEY 
        and MIXCLOUD_SECRET for testing', 5
        unless defined $ENV{MIXCLOUD_KEY} && $ENV{MIXCLOUD_SECRET};

    my $mixcloud = WWW::Mixcloud->new({
        api_key    => $ENV{MIXCLOUD_KEY},
        api_secret => $ENV{MIXCLOUD_SECRET},
    });

    ok($mixcloud, 'Got something');
    isa_ok($mixcloud, 'WWW::Mixcloud');
    is($mixcloud->api_key, $ENV{MIXCLOUD_KEY}, 'Correct API key');
    is($mixcloud->api_secret, $ENV{MIXCLOUD_SECRET}, 'Correct secret key');
    isa_ok($mixcloud->ua, 'LWP::UserAgent');
    ok(
        $mixcloud->cloudcast('http://www.mixcloud.com/spartacus/party-time/'),
        'Got some cloud cast data'
    );
}

done_testing;
