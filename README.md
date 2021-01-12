# BRAN Checker

(Brazilian Account Number Checker)

[![Xerpa](https://circleci.com/gh/Xerpa/bran_checker.svg?style=shield)](https://circleci.com/gh/Xerpa/bran_checker) [![SourceLevel](https://app.sourcelevel.io/github/Xerpa/-/bran_checker.svg)](https://app.sourcelevel.io/github/Xerpa/-/bran_checker) [![Coverage Status](https://coveralls.io/repos/github/Xerpa/bran_checker/badge.svg?branch=master)](https://coveralls.io/github/Xerpa/bran_checker?branch=master)

This rules are based on [this document](http://177.153.6.25/ercompany.com.br/boleto/laravel-boleto-master/manuais/Regras%20Validacao%20Conta%20Corrente%20VI_EPS.pdf)

## Next steps:

-   Implement validator for:
    -   Bradesco
    -   Banco do Brasil
    -   Caixa Econômica Federal
    -   ~~Santander~~
-   Create Hex.pm package
-   Implement validator for other brazilian banks
-   Improve documentations
-   Add tests

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bran` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bran, "~> 0.1.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bran>.
