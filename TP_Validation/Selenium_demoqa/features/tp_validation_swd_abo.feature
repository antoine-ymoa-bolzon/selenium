Feature: DemoQA Validation TP : Making interactives actions
    As a visitor
    I want to verify the correct use of some html inputs

    Scenario: 1- The visitor can see the correct return httpcode of some buttons
        Given   I am on the Links page
        When    I click on the hyperlinks dedicated to API calls
        Then    I see the specifics messages of the concerned hyperlinks

    Scenario: 2- The visitor can fill a form
        Given   I am on the Forms page
        When    I fill some input fields
        Then    I can submit a form

    Scenario: 3- The visitor can see tooltips element
        Given   I am on the Tooltips page
        When    I perform a hover event on element
        Then    I see its specific tooltip

    Scenario: 4- The visitor can select options
        Given   I am on the Selects page
        When    I select specific option on select list
        Then    The selected option is correctly selected

    Scenario: 5- The visitor can choose a radio button option
        Given   I am on the RadioButtons page
        When    I select some options
        Then    The selected option is selected

    Scenario: 6- The visitor can see the color changing
        Given   I am on the Dynamic properties page
        When    I waiting some seconds
        Then    The color button style is altered

    Scenario: 7- The visitor can create a user
        Given   I am on the Bookstore Login page
        When    I fill the form to create a new user
        And     I successfuly pass the captcha
        Then    The creation of a new user is confirmed by alert


"""
MétaActions déduites: "se connecter au site","se rendre sur la rubrique", "interagir avec un élément", "vérifier un résultat attendu"
Action déduites: "Alimenter champ", "Cliquer sur bouton", "Vérifier URL", "Checker une checkbox", "Selectionner une option", "Vérifier appel API
""""


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
