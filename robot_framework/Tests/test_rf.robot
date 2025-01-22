*** Settings ***
Documentation     This suite contains variable definitions.
Library       SeleniumLibrary
Resource    ../Ressources/keywords.robot
Resource    ../Ressources/variables.robot


*** Test Cases ***

Scenario : Exercice3 - Parcours Client Commande Articles
#Exercice3
#Connecter compte standard
    Given A user of the website
    When I fill my logins
    Then I can navigate on the website
#Trier la liste décroissant
    When I filter the products
    Then The products are filtred
#Ajouter les 2 premiers produits
    When I add the first two products to my cart
    Then Some products were added into my cart
#Aller au panier
    When I navigate to my cart
    Then I am on the cart page
#Vérifier qu'on a bien des produits au panier
    
#Saisir informations client
    When I fill my personnal info
    Then I am redirected to the next step
#Vérifier prix
    Then I can confirm the total price of the command
#Finaliser commande
    When I go to the final step
    Then My command is confirmed
    Then I am redirected to the product page
#Deconnexion
    When I Deconnect my account
    Then I am on the connection page



*** Comments ***
Tests sauceDemo 1er jet
Scenario : Connection - Deconnection Test
    Given A user of the website
    When I fill my logins
    Then I can navigate on the website

    When I Deconnect my account
    Then I am on the connection page

Scenario : Add some differents products on cart
    Given A user of the website
    When I fill my logins
    Then I can navigate on the website

    When I choose to add some products to my cart
    Then Some products were added into my cart

Scenario : Drop some differents products from cart
    Given A user of the website
    When I fill my logins
    Then I can navigate on the website 

    When I choose to add some products to my cart
    Then Some products were added into my cart

    When I navigate to my cart
    Then I am on the cart page

    When I delete a product from my cart
    Then My cart is freed from one article

    When I delete all products from my cart
    Then My cart is empty




Tests Gerkhinisés non refactorisés
Scenario : Connection - Deconnection Test
    Given A user of the website
    When I fill my logins
    Then I can navigate on the website

    When I Deconnect my account
    Then I am on the connection page

Scenario : Add some differents products on cart
    Given A user of the website
    When I fill my logins
    Then I can navigate on the website

    When I choose to add some products to my cart
    Then Some products were added into my cart

Scenario : Drop some differents products from cart
    Given A user of the website
    When I fill my logins
    Then I can navigate on the website 

    When I choose to add some products to my cart
    Then Some products were added into my cart

    When I navigate to my cart
    Then I am on the cart page

    When I delete a product from my cart
    Then My cart is freed from one article

    When I delete all products from my cart
    Then My cart is empty


1ers tests
TestKingJouet
    [Documentation]    This test case opens a browser, clicks on a captcha input, and enters text.
    Open Browser    ${URL}    browser=chrome
    Click Element    locator=//button[@id='onetrust-accept-btn-handler']
    Input Text    locator=//input[@id='algoliaSearch']    text=Lego
    Press Key    locator=//input[@id='algoliaSearch']    key=ENTER    
    
Scenario : Search some lego on the KingJouet Website
    Given I Am On The Site KingJouet
    When I Accept The Cookies
    When I Search An Article
    Then I See At Least One Article
*** Comments ***



    Given I Am On The Blocked Page
    When I Contact Support Team
    Then A Message Is Send To Support Team



