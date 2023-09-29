Feature: Este feature se encargará de realizar las pruebas correspondientes al Get de los Bookings

  Background:

    * url requestURL
    #verificamos si el servicio está levantado con el health
    * call read('/common/health.feature')

    @happypath1 @getBooking
  Scenario: Se probara obtener la lista de bookins

    Given path 'booking'
    When method get
    Then status 200
      #validamos que retorne un arreglo
      And match response == '#[]'
       # Validamos la estructura del primer elemento
      And match response[0] == { 'bookingid': '#number' }

  @happypath2 @getBookingFirstId
  Scenario: Validaremos obtener un booking por id y que respete el contrato
    Given path 'booking'
    When method get
    Then status 200
    #guardamos el primer id
    * def primerId = response[0].bookingid
    * def jsonValidate = read('../response/getBookings.json')[0].schema

    Given path 'booking/'+primerId
    And header Accept = 'application/json'
    When method get
    Then status 200
    #validamos que corresponda con el schema correspondiente
    And match response == karate.jsonPath(response, '$')

  @UnHappypath1 @getBookingUnHappyPath
  Scenario: Se valida cuando el id no existe
    Given path 'booking/0'
    And header Accept = 'application/json'
    When method get
    Then status 404









