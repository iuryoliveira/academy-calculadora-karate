Feature: Cálculo de soma de uma calculadora
    Como uma pessoa qualquer
    Desejo realizar a soma de dois números
    Para conhecer o resultado do cálculo

    Background: Configurar base url da calculadora
        Given url "https://crud-api-academy.herokuapp.com/api/v1"
        And path "calculadora/soma"

    Scenario: Não deve ser possível realizar cálculos sem enviar dois números
        Given request { }
        When method post
        Then status 400
        And match response == { error: "Envie dois números para serem calculados." }

    Scenario: Não deve ser possível realizar cálculos sem enviar o primeiro número
        Given request { num2: 1 }
        When method post
        Then status 400
        And match response == { error: "Envie dois números para serem calculados." }

    Scenario: Não deve ser possível realizar cálculos sem enviar o segundo número
        Given request { num1: 1 }
        When method post
        Then status 400
        And match response == { error: "Envie dois números para serem calculados." }

    Scenario: Somar dois números com sucesso
        Given request { num1: 1, num2: 2 }
        When method post
        Then status 200
        And match response == { resultado: 3 }

    Scenario Outline: Calcular <primeiroNumero> + <segundoNumero> = <resultadoEsperado>
        Given request { num1: "#(primeiroNumero)", num2: "#(segundoNumero)" }
        When method post
        Then status 200
        And match response == { resultado: "#(resultadoEsperado)" }
        
        Examples:
            | primeiroNumero! | segundoNumero!  | resultadoEsperado! |
            | 5               | 4               | 9                  |
            | 2               | 3.5             | 5.5                |
            | 0.4             | 8.2             | 8.6                |
            | -1              | -5              | -6                 |
            | -5.4            | -4              | -9.4               |
            | -3.9            | -7.2            | -11.1              |