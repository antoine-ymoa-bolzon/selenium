*** Settings ***
Documentation       Rechercher un produit spécifique et vérifier les résultats
Library       SeleniumLibrary
Resource    ../Ressources/keywords.robot

*** Variables ***
${SEARCHED_PRODUCT}         Dress
${PRODUCT_TERMINOLOGY}      Products
${INSCRIPTION_TERMINOLOGY}  Signup / Login
&{FORM_FIELDS}    name=Biscotte    email=zebiscotte@lolmail.com    last_name=Biscotte    first_name=Johnny    address1=12, rue du Jonc    state=France    city=Wattrelos    zipcode=59150    mobile_number=0654852312    password=B1scott4
${SIGNUP_XPATH}    //button[@type='submit'][.='Signup']
${REGISTER_XPATH}    //button[@type='submit'][.='Create Account']
${FORM_LOG}    /login
${FORM_SIG}    /signup
${NB_PRODUCTS}    2


*** Test Cases ***
Scenario : 3-1 - Recherche simple
    #Suite de Test "Rechercher un produit spécifique et vérifier les résultats"
        Given Le navigateur est lancé 
        And L'utilisateur accède à "http://automationexercise.com"
        Then La page d'accueil est visible
        When L'utilisateur clique sur le bouton    ${PRODUCT_TERMINOLOGY}
        Then L'utilisateur est redirigé avec succès vers la page "TOUS LES PRODUITS"
        When L'utilisateur effectue une recherche pour trouver le produit    ${SEARCHED_PRODUCT}
        Then "PRODUITS RECHERCHÉS" est visible
        And Les résultats affichés contiennent    ${SEARCHED_PRODUCT}


Scenario : 3-2 - Vérifier les détails de l'adresse sur la page de paiement
    #Suite de Test "Rechercher un produit spécifique et vérifier les résultats"
        Given Le navigateur est lancé 
        And L'utilisateur accède à "http://automationexercise.com"
        Then La page d'accueil est visible
        When L'utilisateur clique sur le bouton    ${INSCRIPTION_TERMINOLOGY}
        Then L'utilisateur est redirigé avec succès vers la page "INSCRIPTION/CONNEXION"
        When User fill the register inputs    ${FORM_SIG}    &{FORM_FIELDS}
        And Submit the form    ${SIGNUP_XPATH}
        Then The user is redirect to the signup page
        When User fill the register inputs    ${FORM_SIG}    &{FORM_FIELDS}
        And User fill the new password    ${FORM_FIELDS}[password]
        And Submit the form    ${REGISTER_XPATH}
        Then The creation of new account is confirmed 
        And User is connected
        When User add some products to his cart    ${NB_PRODUCTS}
        #And Open his cart
        #Then Two products are visibles in his cart
        #When The user proceed to the payment
        #And check his multiples adresses
        #Then The adresses are the same
        #And Input adress is the same too
        When User click on the delete user button
        Then The account deletion is confirmed









*** Comments ***
Scénario 3: Rechercher un produit spécifique et vérifier les résultats 
 
@RechercheSimple
    Given Le navigateur est lancé
    And L'utilisateur accède à "http://automationexercise.com"
    Then La page d'accueil est visible
    When L'utilisateur clique sur le bouton "Produits"
    Then L'utilisateur est redirigé avec succès vers la page "TOUS LES PRODUITS"
    When L'utilisateur saisit "Robe" dans la barre de recherche et clique sur le bouton "Rechercher"
    Then "PRODUITS RECHERCHÉS" est visible
    And Les résultats affichés contiennent "Robe"


@vérifier les détails de l'adresse sur la page de paiement
    Lancez le navigateur
    Accédez à l'URL http://automationexercise.com
    Vérifiez que la page d'accueil est bien visible
    Cliquez sur le bouton « Inscription/Connexion »
    Remplissez tous les détails dans l'inscription et créez un compte
    Vérifiez « COMPTE CRÉÉ ! » et cliquez sur le bouton « Continuer »
    Vérifiez « Connecté avec le nom d'utilisateur » en haut
    Ajouter des produits au panier
    Cliquez sur le bouton « Panier »
    Vérifiez que la page du panier s'affiche
    Cliquez sur « Procéder au paiement »
    Vérifiez que l'adresse de livraison et l'adresse de facturation sont les mêmes que celles renseignées lors de l'enregistrement du compte
    Cliquez sur le bouton « Supprimer le compte »
    Vérifiez « COMPTE SUPPRIMÉ ! » et cliquez sur le bouton « Continuer »





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



