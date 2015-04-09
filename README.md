# Contracto

Creates HTTP server based on your contract.

# IN PROGRESS

## Usage

    $ gem install contracto
    $ contracto start git@github.com:kv109/contracto_sample-contract.git
    $ curl 0.0.0.0:54321/users; curl 0.0.0.0:54321/users/1; curl 0.0.0.0:54321/users/2
    $ contracto stop

## How to write contract

See [documentation](https://github.com/kv109/contracto_sample-contract).

## About consumer-driven contracts pattern

http://martinfowler.com/articles/consumerDrivenContracts.html

## Contributing

1. Fork it ( https://github.com/[my-github-username]/contracto/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
