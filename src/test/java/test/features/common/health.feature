Feature: Se probara si está levantado el servicio

  Background:

    * url requestURL

  @happypathHealth
  Scenario: Se probara el servicio

    Given path 'ping'
    When method get
    Then status 201
    And match response == "Created"