Feature: Este feature probará la actualización de los datos

  Background:
    * url requestURL
    * call read('/common/health.feature')
    * def accessToken = call read('/common/Auth.feature')
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * cookie token = accessToken.tokenResponse
    * print accessToken.tokenResponse
    * def book_new = call read('/createBooking.feature@CreateBooking')
    * print book_new.bookId

  @happypath1 @update
  Scenario: Se probara la actualización de datos
    * def inputData = read('../request/postBookings.json')[4].schema
    * print inputData
    Given path 'booking/'+book_new.bookId
    And request inputData
    When method PUT
    Then status 200

  @unHappypath1 @update2
  Scenario: Se probara la actualización de datos para un id inexistente
    * def inputData = read('../request/postBookings.json')[4].schema
    * print inputData
    Given path 'booking/0'
    And request inputData
    When method PUT
    Then status 405

    #--PartialUpdateBooking

  @happypath2 @update3
  Scenario: Se probara la actualización de datos parcial
    * def inputData = read('../request/postBookings.json')[5].schema
    * print inputData
    Given path 'booking/'+book_new.bookId
    And request inputData
    When method PATCH
    Then status 200

  @unHappypath2 @update4
  Scenario: Se probara la actualización de datos para un id inexistente
    * def inputData = read('../request/postBookings.json')[5].schema
    * print inputData
    Given path 'booking/0'
    And request inputData
    When method PATCH
    Then status 405
    