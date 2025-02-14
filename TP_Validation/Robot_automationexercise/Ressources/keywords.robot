*** Settings ***
Documentation     This suite contains variable definitions.
Library        Collections
Library           SeleniumLibrary
Resource        ../Ressources/variables.robot


*** Variables ***
${LOCABOT}    //div[text(),'Sauce Labs Bike Light']
${LOCATC}    //button[@id='add-to-cart-sauce-labs-@{SD_ARTICLES}']
${NBART}     0
${URL2}    https://automationexercise.com
${CALCULTOTAL}    0
${LOCPRIX}        //div[@data-test='inventory-item-price']
${ELMT1}        //div[@class='inventory_list']/div[@class='inventory_item'][position() = 1]/div[@class='inventory_item_description']/div[@class='pricebar']//button
${ELMT2}        //div[@class='inventory_list']/div[@class='inventory_item'][position() = 2]/div[@class='inventory_item_description']/div[@class='pricebar']//button
@{ELMTS}    ${ELMT1}    ${ELMT2}
${NAV}                    Chrome
${XPATH_ELT}    //li[@text='Cras justo odio']
${PRODUCTS_RUBRIQUE}        Products
${ACCOUNT_CREATED}          Account Created!
${SEARCHED_RESULT_PAGE}     Searched Products
${LOGOUT_XPATH}              //ul[@class="nav navbar-nav"]/li/a[@href="/logout"]
${HOME_XPATH}                //ul[@class="nav navbar-nav"]/li/a[@href="/"]
${LOGOUTCOLOR}               brown
${NAVCOLOR}                 orange
${ACCOUNT_DELETED}        Account Deleted!


*** Keywords ***
Get Keyword
    [Documentation]    This keyword gets a keyword and logs it.
    [Arguments]    ${keyword}
    ${keyword}    Set Variable    ${keyword}
    Log    ${keyword}
    RETURN    ${keyword}


Sur le site
    Open Browser    ${URL2}    ${NAV}
    Maximize Browser Window
    Sleep    1s

Acceder au site
    Go To    ${URL2}

Clic sur element
    [Arguments]    ${XPATH_ELT}
    Wait Until Element Is Visible   ${XPATH_ELT}
    Click Element    ${XPATH_ELT}
    Sleep    2s

Element selectionne
    Log    OK

A user of the website
    Open Browser    ${URL}    ${NAV}
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

    Should Be Equal    ${URL1}    ${URL2}

    

Gerer les cookies
    Sleep   1s
    ${popup_visible}    Run Keyword And Return Status    Element Should Be Visible    //div[contains(@class, 'fc-consent-root')]
    Run Keyword If    ${popup_visible}    Click Element    //button[contains(@class, 'fc-cta-consent')]



Le navigateur est lancé
    Open Browser    about:blank    ${NAV}
    Maximize Browser Window

l'utilisateur accède à "http://automationexercise.com"
    Acceder au site
    Gerer les cookies

NavElement is colored
    [Arguments]    ${COULEUR}    ${XPATH}
    ${color}    Get Element Attribute    ${XPATH}    style
    Should Contain    ${color}    color: ${COULEUR}

La page d'accueil est visible
    NavElement is colored    ${NAVCOLOR}    ${HOME_XPATH}
    
User is connected
    NavElement is colored    ${LOGOUTCOLOR}    ${LOGOUT_XPATH}

L'utilisateur clique sur le bouton
    [Arguments]    ${PRODUCTS_RUBRIQUE}
    Clic sur element    //a[contains(text(), '${PRODUCTS_RUBRIQUE}')]

L'utilisateur est redirigé avec succès vers la page "TOUS LES PRODUITS"
    ${URL_Locale}=    Get Location
    Comparer URL    ${URL_locale}   ${URL2}/products

L'utilisateur est redirigé avec succès vers la page "INSCRIPTION/CONNEXION"
    ${URL_Locale}=    Get Location
    Comparer URL    ${URL_locale}   ${URL2}/login

The user is redirect to the signup page
    ${URL_Locale}=    Get Location
    Comparer URL    ${URL_locale}   ${URL2}/signup

L'utilisateur effectue une recherche pour trouver le produit
    [Arguments]    ${RECHERCHE}
    Input Text    //input[@id='search_product']    ${RECHERCHE}
    Click Button  //button[@id='submit_search']

"PRODUITS RECHERCHÉS" est visible
    The following string is visible     ${SEARCHED_RESULT_PAGE}

Tous les produits contiennent
    [Arguments]    ${RECHERCHE}
    ${PRODUCT_Res}    Get WebElements    //div[@class='overlay-content']/p
    ${count}    Get Length    ${PRODUCT_Res}
    Should Be True    ${count} > 0    "Aucun produit trouvé !"

    ${produits_non_valides}    Create List

    FOR    ${PRD}    IN    @{PRODUCT_Res}
        ${TXT}    Execute JavaScript    return arguments[0].textContent.trim();    ARGUMENTS    ${PRD}
        Log    Produit trouvé : ${TXT}
        
        Run Keyword And Continue On Failure
        ...    Should Contain    ${TXT}    ${RECHERCHE}    
        ...    "⚠️ Attention : '${TXT}' ne contient pas '${RECHERCHE}' !"

        # Si le texte ne contient pas le mot recherché, on l'ajoute à la liste des produits non conformes
        ${is_valid}    Run Keyword And Return Status    Should Contain    ${TXT}    ${RECHERCHE}
        IF    not ${is_valid}
            Append To List    ${produits_non_valides}    ${TXT}
            
        END
    END

    # Afficher les produits non conformes si la liste n'est pas vide
    ${nb_non_valides}    Get Length    ${produits_non_valides}
    IF    ${nb_non_valides} > 0
        Log Many    ⚠️ Attention : Les produits suivants ne contiennent pas '${RECHERCHE}':    @{produits_non_valides}
    END



Les résultats affichés contiennent 
    [Arguments]    ${RECHERCHE}
    ${URL_Locale}=    Get Location
    Comparer URL    ${URL_locale}   ${URL2}/products?search=${RECHERCHE}

    Tous les produits contiennent    ${RECHERCHE}

Fill input text by name
    [Arguments]    ${NAME}    ${CHAINE}
    Input Text    //input[@name='${NAME}']    ${CHAINE}

User fill the register inputs
    [Arguments]    ${FORM}    &{FIELD_VALUES}
    FOR    ${name}    ${value}    IN    &{FIELD_VALUES}

        Run Keyword And Ignore Error    Fill Input If Exists    ${name}    ${value}    ${FORM}
        
    END

User fill the new password
    [Arguments]    ${NWPWD}
    #vu que gogolito semble incapable de remplir tous les champs s'il y en a un en password, malgré une condition explicite 
    # (soit on a password rempli et pas le reste, soit il s'en b... et  rempli uniquement le reste)
    Input Password    //input[@name='password']    ${NWPWD}

Fill Input If Exists
    [Arguments]    ${NAME}    ${VALUE}    ${FORM}
    ${LOCATOR}    Set Variable    //form[@action='${FORM}']//input[@name='${NAME}']
    ${ELEMENT_EXISTS}=    Run Keyword And Return Status    Element Should Be Visible    ${LOCATOR}
    Run Keyword If    ${ELEMENT_EXISTS}    Input Text    ${LOCATOR}    ${VALUE}
    # Si l'élément n'est pas trouvé, cette étape est ignorée, et l'exécution continue sans erreur

Submit the form
    [Arguments]    ${SUBMIT_XPATH}
    Scroll Until Element Is Visible    ${SUBMIT_XPATH}
    # Cliquer directement sur le bouton via JavaScript
    Click Button    ${SUBMIT_XPATH}
    Sleep    4s

Scroll Until Element Is Visible
    [Arguments]    ${XPATH}
    # Trouver l'élément à cliquer
    ${ELT}=    Get WebElement    ${XPATH}

    Scroll Element Into View    ${ELT}
    Execute Javascript    window.scrollBy(0, 150);

The following string is visible 
    [Arguments]    ${RUBRIQUE}
    ${TEXTE_Recup}    Get Text    //h2[@class='title text-center']
    Should Match Regexp    ${TEXTE_Recup}    (?i)${RUBRIQUE}
    
The creation of new account is confirmed
    Sleep    1s
    The following string is visible     ${ACCOUNT_CREATED}

    ${URL_Locale}=    Get Location
    Comparer URL    ${URL_locale}   ${URL2}/account_created

    Click Element    //a[@href="/"]


Adding a product
    ${ELEMENT_EXISTS}=    Run Keyword And Return Status    Element Should Be Visible    //a[.='Add to cart']
    Click Element       //a[.='Add to cart']
    Sleep    1s
    Click Button    //button[@class='btn btn-success close-modal btn-block']
    
Come to products page
    Go To    ${URL2}/products
    Execute Javascript    window.scrollBy(0, 300);

User add some products to his cart
    [Arguments]     ${NB_PRODUCTS}
    Come to products page

    ${NB_PRODUCTS} =    Convert To Integer    ${NB_PRODUCTS}

    FOR    ${i}    IN RANGE    ${NB_PRODUCTS}
        Adding a product
    END

User click on the delete user button
    ${ELEMENT_EXISTS}=    Run Keyword And Return Status    Element Should Be Visible    //a[contains(.,'Delete Account')]
    Click Element       //a[contains(.,'Delete Account')]

The account deletion is confirmed
    Sleep    1s
    The following string is visible     ${ACCOUNT_DELETED}

    ${URL_Locale}=    Get Location
    Comparer URL    ${URL_locale}   ${URL2}/delete_account

    Click Element    //a[@href="/"]


*** Comments ***
