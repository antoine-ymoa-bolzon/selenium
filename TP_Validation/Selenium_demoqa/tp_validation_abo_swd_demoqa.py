import pytest
import pytest_bdd
from pytest_bdd import parsers

from selenium import webdriver
from selenium.webdriver.common.by import By
from pytest_bdd import scenario ,given, then ,when

from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.action_chains import ActionChains

import keyboard
import time



@pytest.fixture
def browser():
    options = webdriver.ChromeOptions()
    options.add_argument("--start-maximized")

    driver = webdriver.Chrome(options=options)
    #driver = webdriver.Chrome()
    yield driver
    driver.quit()

def base():
    return 'https://demoqa.com/'

def url():

    page = {
        'elements':['textbox','checkbox','radio-button','webtables','buttons','links','broken','upload-download','dynamic-properties'], 
        'forms':['automation-practice-form'], 
        'alertsWindows':['browser-windows','alerts','frames','nestedframes','modal-dialogs'], 
        'widgets':['accordian','auto-complete','date-picker','slider','progress-bar','tabs','tool-tips','menu','select-menu'], 
        'interactions':['sortable','selectable','resizable','droppable','dragabble'], 
        'bookStoreApplication':['login','books','profile','swagger/']} 
    
    return page

def persona():

    return "Barnaby","Johns","0674859685"


def verifier_presence_element(driver, id_element):
    """
    Vérifie si un élément est présent et visible dans la page via son XPath.

    :param driver: Instance de WebDriver (ex: Chrome, Firefox).
    :param xpath: XPath de l'élément du bouton à vérifier.
    :return: True si le bouton est visible, False sinon.
    """
    try:
        # Attendre que le bouton soit visible dans un délai de 10 secondes
        WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, f'//button[@id="{id_element}"]'))
        )
        print(f"✅ Le bouton avec l'id '{id_element}' est présent et visible.")
        return True
    except Exception as e:
        print(f"❌ Le bouton avec l'id '{id_element}' n'est pas visible ou n'existe pas. Erreur: {e}")
        return False


def verifier_url(driver, url_attendue):
    """
    Vérifie si l'URL actuelle du navigateur correspond à l'URL attendue.
    
    :param driver: Instance WebDriver (ex: Chrome, Firefox).
    :param url_attendue: URL à vérifier.
    :return: True si l'URL correspond, False sinon.
    """
    url_actuelle = driver.current_url
    return url_actuelle == url_attendue

def alimenter_champ(driver, id_element, valeur):
    try: 
        time.sleep(1)
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.ID, id_element))
        )
        driver.find_element(By.ID, id_element).send_keys(valeur)

    
    except Exception as e:
        print(f"impossible d'alimenter le champs. Peut-être n'est-il pas visible ou chargé?")

def cliquer_sur_element(driver, id_element):
    """
    Trouve et clique sur un élément HTML par son ID CSS.

    :param driver: Instance de WebDriver (ex: Chrome, Firefox).
    :param id_element: ID de l'élément HTML à cliquer.
    """
    try:
        if driver.find_element(By.ID, id_element):

            element = driver.find_element(By.ID, id_element)
            
            ActionChains(driver).move_to_element(element).click().perform()
            print(f"✅ Clic réussi sur l'élément avec l'ID : {id_element}")

        else:
            driver.execute_script("window.scrollBy(0, 200);")
            time.sleep(1)
            element = driver.find_element(By.ID, id_element)
            
            ActionChains(driver).move_to_element(element).click().perform()
            print(f"✅ Clic réussi (après scroll) sur l'élément avec l'ID : {id_element}")

        
    except Exception as e:
        print(f"❌ Erreur lors du clic sur l'élément {id_element} : {e}")


def verifier_texte_par_id(driver, id_element, texte_attendu):
    """
    Vérifie si le texte affiché dans un élément HTML correspond au texte attendu.

    :param driver: Instance de WebDriver (ex: Chrome, Firefox).
    :param id_element: ID de l'élément HTML à vérifier.
    :param texte_attendu: Texte attendu dans l'élément.
    :return: True si le texte correspond, False sinon.
    """
    try:
        time.sleep(1)
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.ID, id_element))
        )


        element = driver.find_element(By.XPATH, f'//p[@id="{id_element}"]//b')
        texte_actuel = element.text

        if texte_actuel == texte_attendu:
            print(f"✅ Le texte de l'élément '{id_element}' est bien : '{texte_attendu}'")
            return True
        else:
            print(f"❌ Texte incorrect ! Attendu: '{texte_attendu}', Trouvé: '{texte_actuel}'")
            return False

    except Exception as e:
        print(f"❌ Erreur lors de la récupération du texte de l'élément {id_element} : {e}")
        return False


def survoler_element(driver,id_element,tooltip_xpath):
    try:
        time.sleep(1)
        element = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.ID, id_element))
        )

        # Effectuer le hover avec ActionChains
        action = ActionChains(driver)
        action.move_to_element(element).perform()
        time.sleep(1)

        # Attendre que le tooltip soit visible après le hover
        tooltip = WebDriverWait(driver, 5).until(
            EC.visibility_of_element_located((By.XPATH, tooltip_xpath))
        )


        print(f"✅ Tooltip affiché : '{tooltip.text}'")
        return True


    except Exception as e:
        print(f"Impossible de survoler l'élément dont l'id est {id_element} :\n {e}")
        return False
    

def selectionner_option_par_xpath(driver, xpath_select, nbentree=0, nbdown=0, xpath_alim="", xpath_options="", autocomp=""):
    """
    Sélectionne une option dans un select ou un faux select basé sur <div>.

    :param driver: Instance WebDriver.
    :param xpath_select: Pour le clic sur l'élément.
    :param xpath_alim: Pour le input pour valider l'autocomplétion.
    :param xpath_options: pour pointer la liste d'options si possible
    :param autocomp: chaîne à entrer pour trouver l'option voulue
    """
    
    print(f"XOX Debut: "+xpath_select)
    try:
        print(f"XOX Try: "+xpath_select)
        # 1. Attendre que le chevron soit visible et cliquable
        chevron = WebDriverWait(driver, 10).until(EC.element_to_be_clickable((By.XPATH, xpath_select)))
        
        print(f"XOX clic: "+xpath_select)
        # 2. Cliquer sur le chevron pour ouvrir le menu
        chevron.click()
        time.sleep(2)

        #option = WebDriverWait(driver, 10).until(EC.element_to_be_clickable((By.XPATH, xpath_alim)))
        if int(nbdown) > 0:
            for _ in range(nbdown):
                print(f"appui Down pour XPATH="+xpath_select)
                chevron.send_keys("ARROW_DOWN")

        if int(nbentree) > 0:
            for _ in range(nbentree):
                print(f"appui Entrée pour XPATH="+xpath_select)
                chevron.send_keys("\ue007")


        chevron.send_keys("\ue007")
        
        print(f"✅ Option sélectionnée")

    except Exception as e:
        print(f"❌ Erreur lors de la sélection de l'option : {e}")
    

############################################################################################################
#Scénario 1- The visitor can see the correct return httpcode of some buttons
############################################################################################################
@scenario('features/tp_validation_swd_abo.feature', '1- The visitor can see the correct return httpcode of some buttons')
def test_scenario1_httpcode():
    pass

@given('I am on the Links page')
def open_links_page(browser):
    browser.get(base() + url()['elements'][5])
    time.sleep(1)
    verifier_url(browser,base() + url()['elements'][5])
    time.sleep(1)

@when('I click on the hyperlinks dedicated to API calls')
def when_action_sc1(browser):
    #scroller pour disposer de la visibilité sur toute la liste des liens
    browser.execute_script("window.scrollBy(0, 200);")
    #cliquer sur created
    cliquer_sur_element(browser, 'created')
    verifier_texte_par_id(browser, 'linkResponse', '201')
    
    #cliquer sur no content
    cliquer_sur_element(browser, 'no-content')
    verifier_texte_par_id(browser, 'linkResponse', '204')

    #cliquer sur moved
    cliquer_sur_element(browser, 'moved')
    verifier_texte_par_id(browser, 'linkResponse', '301')

    #cliquer sur bad request
    cliquer_sur_element(browser, 'bad-request')
    verifier_texte_par_id(browser, 'linkResponse', '400')

    #cliquer sur unauthorized
    cliquer_sur_element(browser, 'unauthorized')
    verifier_texte_par_id(browser, 'linkResponse', '401')

    #cliquer sur forbidden
    cliquer_sur_element(browser, 'forbidden')
    verifier_texte_par_id(browser, 'linkResponse', '403')

    #cliquer sur not found
    cliquer_sur_element(browser, 'invalid-url')
    verifier_texte_par_id(browser, 'linkResponse', '404')


@then('I see the specifics messages of the concerned hyperlinks')
def then_action_sc1():
    #Oups, déjà vérifié dans le When
    pass




############################################################################################################
#Scénario 2- The visitor can fill a form
############################################################################################################
@scenario('features/tp_validation_swd_abo.feature', '2- The visitor can fill a form')
def test_scenario2_form():
    pass

@given('I am on the Forms page')
def open_forms_page(browser):
    browser.get(base() + url()['forms'][0])
    time.sleep(1)
    verifier_url(browser,base() + url()['forms'][0])
    time.sleep(1)

@when('I fill some input fields')
def when_action_sc2(browser):
    #scroller pour disposer de la visibilité sur tous les champs
    browser.execute_script("window.scrollBy(0, 400);")
    #CHAMPS OBLIGATOIRES: FirstName, LastName, Gender, Mobile
    time.sleep(1)
    #FirstName
    alimenter_champ(browser, 'firstName', persona()[0])
    #LastName
    alimenter_champ(browser, 'lastName', persona()[1])
    #Gender
    cliquer_sur_element(browser, 'gender-radio-3')
    #Mobile
    alimenter_champ(browser, 'userNumber', persona()[2])

@then('I can submit a form')
def then_action_sc2(browser):
    time.sleep(1)
    #scroller pour disposer de la visibilité sur le bouton submit
    browser.execute_script("window.scrollBy(0, 400);")
    #cliquer sur submit
    cliquer_sur_element(browser, 'submit')
    #vérifier que formulaire envoyé
    #>>présence bouton id=closeLargeModal sur le modal de confirmation d'envoi
    verifier_presence_element(browser, 'closeLargeModal')
    cliquer_sur_element(browser, 'closeLargeModal')
    time.sleep(2)




############################################################################################################
#Scénario 3- The visitor can see tooltips element
############################################################################################################
@scenario('features/tp_validation_swd_abo.feature', '3- The visitor can see tooltips element')
def test_scenario3_tooltips():
    pass

@given('I am on the Tooltips page')
def open_tooltips_page(browser):
    browser.get(base() + url()['widgets'][6])
    time.sleep(1)
    verifier_url(browser,base() + url()['widgets'][6])
    time.sleep(1)

@when('I perform a hover event on element')
def when_action_sc3(browser):
    #survoler bouton
    survoler_element(browser,'toolTipButton','//div[@role="tooltip"]')
    #survoler input text
    survoler_element(browser,'toolTipTextField','//div[@role="tooltip"]')

@then('I see its specific tooltip')
def then_action_sc3():
    #Oups, déjà vérifié dans le When
    pass




############################################################################################################
#Scénario 4- The visitor can select options
############################################################################################################
@scenario('features/tp_validation_swd_abo.feature', '4- The visitor can select options')
def test_scenario4_select():
    pass

@given('I am on the Selects page')
def open_selects_page(browser):
    browser.get(base() + url()['widgets'][8])
    time.sleep(1)
    verifier_url(browser,base() + url()['widgets'][8])
    time.sleep(1)

@when('I select specific option on select list')
def when_action_sc4(browser):
    #scroller pour disposer de la visibilité sur tous les champs
    browser.execute_script("window.scrollBy(0, 400);")
    #select1 another root option
    selectionner_option_par_xpath(browser, "//div[@id='withOptGroup']//div[contains(@class, ' css-1wy0on6')]", 0, 5, "//div[@id='withOptGroup']//div[contains(@class, ' css-1wy0on6')]//div[@class='css-1g6gooi']/div/input[@type='text']", "", "Ano")
    #select2 another
    selectionner_option_par_xpath(browser, "//div[@id='selectOne']//div[contains(@class, ' css-1wy0on6')]", 0, 5, "//div[@id='selectOne']//div[contains(@class, ' css-1wy0on6')]//div[@class='css-1g6gooi']/div/input[@type='text']", "", "Ano")
    #select3 aqua
    #récupérer de l'exercice
    select3 = browser.find_element(By.XPATH, "//select[@id='oldSelectMenu']")
    select3.click()
    time.sleep(1)
    select3.send_keys("ARROW_DOWN")
    #Appuyer sur Entrée
    select3.send_keys("\ue007")
    time.sleep(2)
    #drop down toutes les couleurs 
    selectionner_option_par_xpath(browser, "//div[@class='row']//div[@class=' css-2b097c-container']//div[contains(@class, ' css-tlfecz-indicatorContainer')]", 4 )
    #multi select audi
    selectionner_option_par_xpath(browser, "//select[@id='cars']", 0, 4 )


    time.sleep(3)


@then('The selected option is correctly selected')
def then_action_sc4():
    pass




############################################################################################################
#Scénario 5- The visitor can choose a radio button option
############################################################################################################
@scenario('features/tp_validation_swd_abo.feature', '5- The visitor can choose a radio button option')
def test_scenario5_radio(browser):
    browser.maximize_window()
    pass

@given('I am on the RadioButtons page')
def open_radios_page(browser):
    browser.get(base() + url()['elements'][2])
    time.sleep(1)
    verifier_url(browser,base() + url()['elements'][2])
    time.sleep(1)

@when('I select some options')
def when_action_sc5():
    pass

@then('The selected option is selected')
def then_action_sc5():
    pass




############################################################################################################
#Scénario 6- The visitor can see the color changing
############################################################################################################
@scenario('features/tp_validation_swd_abo.feature', '6- The visitor can see the color changing')
def test_scenario6_style(browser):
    browser.maximize_window()
    pass

@given('I am on the Dynamic properties page')
def open_dynamics_page(browser):
    browser.get(base() + url()['elements'][8])
    time.sleep(1)
    verifier_url(browser,base() + url()['elements'][8])
    time.sleep(1)

@when('I waiting some seconds')
def when_action_sc6():
    pass

@then('The color button style is altered')
def then_action_sc6():
    pass




############################################################################################################
#Scénario 7- The visitor can create a user
############################################################################################################
@scenario('features/tp_validation_swd_abo.feature', '7- The visitor can create a user')
def test_scenario7_create(browser):
    browser.maximize_window()
    pass

@given('I am on the Bookstore Login page')
def open_bookstore_page(browser):
    browser.get(base() + url()['bookStoreApplication'][0])
    time.sleep(1)
    verifier_url(browser,base() + url()['bookStoreApplication'][0])
    time.sleep(1)

@when('I fill the form to create a new user')
def when_action_sc7():
    pass

@when('I successfuly pass the captcha')
def pass_captcha():
    pass

@then('The creation of a new user is confirmed by alert')
def then_action_sc7():
    pass





