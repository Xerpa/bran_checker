# BRAN Checker

(Brazilian Account Number Checker)

[![Xerpa](https://circleci.com/gh/Xerpa/bran_checker.svg?style=shield)](https://circleci.com/gh/Xerpa/bran_checker) [![SourceLevel](https://app.sourcelevel.io/github/Xerpa/-/bran_checker.svg)](https://app.sourcelevel.io/github/Xerpa/-/bran_checker) [![Coverage Status](https://coveralls.io/repos/github/Xerpa/bran_checker/badge.svg?branch=master)](https://coveralls.io/github/Xerpa/bran_checker?branch=master)

This rules are based on [this document](http://177.153.6.25/ercompany.com.br/boleto/laravel-boleto-master/manuais/Regras%20Validacao%20Conta%20Corrente%20VI_EPS.pdf)

## Supported Banks
  -  C6
  -  Itaú
  -  Nubank
  -  Santander
## Next steps:
-   Implement validator for:
    -   Bradesco
    -   Banco do Brasil
    -   Caixa Econômica Federal
-   Improve documentation
-   Improve test coverage

## Installation

```elixir
def deps do
  [
    {:bran, "~> 0.2.3"}
  ]
end
```
