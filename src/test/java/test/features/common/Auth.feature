Feature: Creación de token

  Background:

    * url requestURL
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  @createToken
  Scenario: Creacion de token

    Given path 'auth'
    And request
    """
    {
    "username" : "admin",
    "password" : "password123"
    }
    """
    When method post
    Then status 200
    * def tokenResponse = response.token
    * print tokenResponse
