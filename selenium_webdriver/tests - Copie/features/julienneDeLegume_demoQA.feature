Feature: DemoQA Inputs Uses
    As a visitor
    I want to verify the correct use of some html inputs

    Scenario: The visitor can select some check options
        Given I am on the checkbox page
        When I check all the options
        * I uncheck some specific options
        Then All options are checked except some specific ones


    Scenario: The visitor can delete some table rows
        Given I am on the webtables page
        When I delete some rows
        Then The concerned rows are deleted from the table


    Scenario: The visitor can modify some table rows
        Given I am on the webtables page
        When I modify some rows contents
        Then The concerned rows are visibly modified in the table


    #Scenario: The visitor can open a new tab
    #    Given I am on the browser windows page
    #    When I open a new tab
    #    * I navigate to it
    #    Then I am on a new tab


    Scenario: The visitor can open and close a new tab
        Given I am on the browser windows page
        When I open a new tab
        * I navigate to it
        * I close it
        Then I am on the browser windows page


    Scenario: The visitor can open a specific modal dialog
        Given I am on the modal dialogs page
        When I open the targeted modal panel
        Then I can see the expected content in the modal dialog
        * I close the modal dialog


    Scenario: The visitor can start a progress bar and see it complete
        Given I am on the progress bar page
        When I start the progress bar
        Then the progress bar reaching is completely green
        * the progress bar reaching text is 100%
    

    Scenario: The visitor can navigate through a menu
        Given I am on the menu page
        When I navigate through the menu
        Then I can see the expected content in the menu


    Scenario: The visitor can select one option in a select menu 
        Given I am on the select menu page
        When I select one option in the select menu 'Select Value'
        * I select one option in the select menu 'Select One'
        * I select one option in the select menu 'Old Style Select Menu'
        Then I can see the expected contents in the select menus selected items
        

    Scenario: The visitor can select multiple options in a select menu
        Given I am on the select menu page
        When I select multiple options in the select menu 'Multi Select Drop Down'
        Then I can see the expected contents in the select menu selected items
