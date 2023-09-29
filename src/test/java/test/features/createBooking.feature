Feature: Se probara la creación de bookings

  Background:

    * url requestURL

    * call read('/common/health.feature')
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'

  @happypath1 @CreateBooking
  Scenario: Se probara la creación de un booking y validamos los datos
    * def inputData = read('../request/postBookings.json')[0].schema
    * print inputData
    Given path 'booking'
    And request inputData
    When method post
    Then status 200
    * def bookId = response.bookingid
    * def jsonValidate = read('../response/getBookings.json')[1].schema
    And match response == karate.jsonPath(response, '$')

  @happypath2 @CreateBooking2
  Scenario: Se probara la creación de un booking y validamos los datos con la consulta por id
    * def inputData = read('../request/postBookings.json')[0].schema
    * print inputData
    Given path 'booking'
    And request inputData
    When method post
    Then status 200
    * def bookId = response.bookingid
    * def jsonValidate = read('../response/getBookings.json')[1].schema
    And match response == karate.jsonPath(response, '$')

  # se validará el booking creado mediante la consulta por id
    * def jsonValidate = read('../response/getBookings.json')[0].schema

    Given path 'booking/' + bookId
    And header Accept = 'application/json'
    When method get
    Then status 200
  # validamos que corresponda con el schema correspondiente
    And match response == karate.jsonPath(response, '$')

  @Unhappypath1 @CreateBooking3
  Scenario: Validamos cuando enviamos un request incorrecto o mal armado
    * def inputData = read('../request/postBookings.json')[1].schema
    * print inputData
    Given path 'booking'
    And request inputData
    When method post
    Then status 500

  @Unhappypath2 @CreateBooking4
  Scenario: Validamos cuando enviamos un request sin datos
    * def inputData = read('../request/postBookings.json')[2].schema
    * print inputData
    Given path 'booking'
    And request inputData
    When method post
    Then status 500

  @Unhappypath2 @CreateBooking4
  Scenario: Validamos cuando enviamos un con valores incorrectos
    * def inputData = read('../request/postBookings.json')[3].schema
    * print inputData
    Given path 'booking'
    And request inputData
    When method post
    Then status 500








