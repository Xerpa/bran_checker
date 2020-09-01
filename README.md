# BankValidatorBR

![Elixir CI](https://github.com/itsmegrave/bank_validator_br/workflows/Elixir%20CI/badge.svg) [![SourceLevel](https://app.sourcelevel.io/github/itsmegrave/bank_validator_br.svg)](https://app.sourcelevel.io/github/itsmegrave/bank_validator_br) [![Coverage Status](https://coveralls.io/repos/github/Xerpa/bank_validator_br/badge.svg?branch=master)](https://coveralls.io/github/Xerpa/bank_validator_br?branch=master)

This rules are based on [this document](http://177.153.6.25/ercompany.com.br/boleto/laravel-boleto-master/manuais/Regras%20Validacao%20Conta%20Corrente%20VI_EPS.pdf)

## TODO:

- Implement validator for:
  - Bradesco
  - Banco do Brasil
  - Caixa Econômica
  - ~~Santanter~~
- Create Hex.pm package
- Implement validator for other brazilian banks
- Improve documentations
- Add tests

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bank_validator_br` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bank_validator_br, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bank_validator_br>.
