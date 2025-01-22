*** Settings ***
Documentation     This suite contains variable definitions.
Library       SeleniumLibrary
Resource    ../Ressources/variables.robot

*** Variables ***
${LOCABOT}    //div[text(),'Sauce Labs Bike Light']
${LOCATC}    //button[@id='add-to-cart-sauce-labs-@{SD_ARTICLES}']
${NBART}     0
${URL2}    https://demoqa.com/selectable
${CALCULTOTAL}    0
${LOCPRIX}        //div[@data-test='inventory-item-price']
${ELMT1}        //div[@class='inventory_list']/div[@class='inventory_item'][position() = 1]/div[@class='inventory_item_description']/div[@class='pricebar']//button
${ELMT2}        //div[@class='inventory_list']/div[@class='inventory_item'][position() = 2]/div[@class='inventory_item_description']/div[@class='pricebar']//button
@{ELMTS}    ${ELMT1}    ${ELMT2}

*** Keywords ***
Get Keyword
    [Documentation]    This keyword gets a keyword and logs it.
    [Arguments]    ${keyword}
    ${keyword}    Set Variable    ${keyword}
    Log    ${keyword}
    RETURN    ${keyword}


Sur le site
    Open Browser    ${URL2}    browser=chrome
    #Go To    ${URL2}
    Maximize Browser Window
    Sleep    1s

Clic sur element
    Wait Until Element Is Visible    //li[@text='Cras justo odio']
    Click Element    //li[@text='Cras justo odio']
    Sleep    2s

Element selectionne
    Log    OK

A user of the website
    Open Browser    ${URL}    browser=chrome
    Maximize Browser Window

I fill my logins
    Input Text    //input[@id='user-name']    ${LOGIN_SD}
    Input Password    //input[@id='password']    ${PWD_SD}
    Click Element    //input[@id='login-button']


I can navigate on the website
    #Vérifier URL
    ${LOCURL}=    Get Location
    Comparer URL    '${URL}inventory.html'    ${LOCURL}

I navigate to a specific product page
    Log    OK1

    #Click Element    ${LOCABOT} 

I Choose a specific product
    Log    OK2

I am on a specific product page
    Log    OK3

I add some products in my cart

    FOR    ${i}    IN    @{SD_ARTICLES}
        Click Element    //button[@id='add-to-cart-sauce-labs-${i}']
    END
    

I choose to add some products to my cart

    FOR    ${i}    IN    @{SD_ARTICLES}
        Click Element    //button[@id='add-to-cart-sauce-labs-${i}']
    END

Some products were added into my cart
    #Vérifier que le nombre de produits à ajouter correspond au nombre ajouté
    ${NBART}=    Get Length    item=@{ELMTS}
    ${PASTILLE}=    Get Text    //span[@class='shopping_cart_badge']

    Evaluate    ${NBART} == ${PASTILLE}



I add the first two products to my cart
    #Pour cocher les deux premiers éléments de la liste indépendemment de leur id
    #Permet de rester OK même en cas de changement de filtrage
    

    FOR    ${ELT}    IN    @{ELMTS}

        Wait Until Element Is Visible    ${ELT}
        Sleep    1s
        Click Button       ${ELT}

    END


I Deconnect my account
    Click Button    //button[@id='react-burger-menu-btn']
    Wait Until Element Is Visible    //a[@id='logout_sidebar_link']
    Click Element    //a[@id='logout_sidebar_link']


I am on the connection page
    #Vérifier URL
    ${LOCURL}=    Get Location
    Comparer URL    '${URL}'    ${LOCURL}


I navigate to my cart
    Click Element    //div[@id='shopping_cart_container']

I am on the cart page
    #Vérifier URL
    ${LOCURL}=    Get Location
    Comparer URL    '${URL}cart.html'    ${LOCURL}


I delete a product from my cart
    ${NBART}=    Get Text    //span[@class='shopping_cart_badge']
    Click Button    //button[@id='remove-sauce-labs-backpack']


My cart is freed from one article
    ${NBACTART}=    Get Text    //span[@class='shopping_cart_badge']

    IF    ${NBACTART} == ${NBART}-1
        Log    Panier OK (-1)
    END
    

I delete all products from my cart
    Log    OK

My cart is empty
    Log    OK




#Exercice3
I filter the products
    Wait Until Element Is Visible    //select[@class='product_sort_container']
    Click Element    //select[@class='product_sort_container']
    Sleep    1s
    Select From List By Value    //select[@class='product_sort_container']    hilo
    

The products are filtred
    #Vérifier le tri
    Log    OK TRI


I fill my personnal info
    Click Button     //button[@id='checkout']
    Wait Until Element Is Visible    //div[@id='checkout_info_container']
    Input Text    //input[@id='first-name']    ${PRENOM}
    Input Text    //input[@id='last-name']    ${NOM}
    Input Text    //input[@id='postal-code']    ${CP}
    Wait Until Element Is Visible    //input[@id='continue']
    Click Element    //input[@id='continue']


I am redirected to the next step
    #Vérifier URL
    ${LOCURL}=    Get Location
    Comparer URL    '${URL}checkout-step-two.html'    ${LOCURL}



I can confirm the total price of the command
    Wait Until Element Is Visible    //div[@data-test='inventory-item-price']
    Wait Until Element Is Visible    //div[@class='summary_subtotal_label']
    
    ${PRIXITEMS}=    Calcul Valeurs Of Similar Elements    ${LOCPRIX} 

    ${PRIXTOT}=    Get Text    //div[@class='summary_subtotal_label']


    Sleep    2s
    ${PRIX2}=    Recup Price By Slice Execution ${PRIXTOT} $
    Sleep    1s

    IF    ${PRIXITEMS} - ${PRIX2} != 0
        Log    y'a le klug qui déborde
    ELSE
        Log    ça sent le maroilles
    END


I go to the final step
    Wait Until Element Is Visible    //button[@id='finish']
    Click Button    //button[@id='finish']


My command is confirmed

    ${LOCURL}=    Get Location    
    Wait Until Element Is Visible    //span[@class='title']
    Comparer URL    '${URL}checkout-complete.html'    ${LOCURL}

    Wait Until Element Is Visible    //button[@id='back-to-products']
    Click Element    //button[@id='back-to-products']

I am redirected to the product page
    
    ${LOCURL}=    Get Location
    Comparer URL    '${URL}inventory.html'    ${LOCURL}


Recup Price By Slice Execution ${VAR} ${FILTRE}
    #Fonction permettant de slicer le contenu texte d'un locator VAR via le pattern FILTRE
    ${RES}=    Execute Javascript    return '${VAR}'.slice('${VAR}'.indexOf('${FILTRE}') + 1)

    RETURN     ${RES}

Calcul Valeurs Of Similar Elements
    [Arguments]    ${LOC}

    ${ELEMENTS}=    Get WebElements    ${LOC}
    

    FOR    ${ELEMENT}    IN    @{ELEMENTS}
        ${TEXTE}=    Get Text    ${ELEMENT}
        
        ${TEXTDEC}=     Recup Price By Slice Execution ${TEXTE} $

        ${CALCULTOTAL}=   Additionner ${TEXTDEC} ${CALCULTOTAL}
    END
    
    RETURN     ${CALCULTOTAL}


Additionner ${STRING1} ${STRING2}
     
    ${RES}=    Execute Javascript    return parseFloat(${STRING1}) + parseFloat(${STRING2})

    RETURN     ${RES}


Comparer URL
    [Arguments]    ${URL1}    ${URL2}

    Should Be Equal    ${URL1}    '${URL2}'
    


*** Comments ***

I Am On The Site KingJouet
    Open Browser    ${URL}    browser=chrome

I Accept The Cookies
    Click Element    locator=//button[@id='onetrust-accept-btn-handler']

I Search An Article
    Input Text    locator=//input[@id='algoliaSearch']    text=${PRODUCT}
    Press Key    locator=//input[@id='algoliaSearch']    key=ENTER

I See At Least One Article
    Pass Execution    message=OK

I Am On The Blocked Page
#Ouvrir la page d'accueil
    Open Browser    ${URL}    browser=chrome
    ${ELEMENT}=    Run Keyword And Return Status    Element Should Be Visible    locator=${LOCABOT}
    
    
    IF     ${ELEMENT}
        I Accept The Cookies
    ELSE
        I Contact Support Team
    END
    

I Contact Support Team
    Click Element    locator=//iframe//button[@id='show-human-auth']
    Input Text    locator=//textarea[@id='human-comment']     text=@{TEXTECOMPLET}

A Message Is Send To Support Team
    Pass Execution    OK




*** Comments ***