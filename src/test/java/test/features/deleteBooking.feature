Feature: Este feature probará la actualización de los datos

  Background:
    * url requestURL
    * call read('/common/health.feature')
    * def accessToken = call read('/common/Auth.feature')
    * header Content-Type = 'application/json'
    * header Accept = 'application/json'
    * cookie token = accessToken.tokenResponse
    * print accessToken.tokenResponse
    * def new_book = call read('/createBooking.feature@CreateBooking')
    * print new_book.bookId

  @happypath1 @delete1
  Scenario: Se probara la eliminación de un booking
    Given path 'booking/'+new_book.bookId
    When method DELETE
    Then status 201

    #validamos que no existe
    Given path 'booking/'+new_book.bookId
    And header Accept = 'application/json'
    When method get
    Then status 404

  @unHappypath1 @delete2
  Scenario: Se probara la eliminación de un booking inexistente
    Given path 'booking/0'
    When method DELETE
    Then status 405
    